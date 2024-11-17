resource "aws_iam_user" "terraform_user" {
  name = var.terraform_username

  tags = {
    purpose = "User to deploy Resoruces via Terrafoarm"
  }
}


# User access state file
data "aws_iam_policy_document" "s3_policy_document" {

  statement {
    sid = "ListanyBucket"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
    effect = "Allow"

  }

  statement {

    sid = "UserAccessStatefile"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.state_bucket.arn}/terraform/.tfstate",
    ]
  }
}


# User Permissions
data "aws_iam_policy_document" "user_permissions" {

  statement {
    sid = "Listpermissions"

    actions = var.user_permission_list

    resources = [
      "*",
    ]
    effect = "Allow"

  }

}

# combine document policies into one 
data "aws_iam_policy_document" "terraform_user_policy_document" {
    override_policy_documents = [
        data.aws_iam_policy_document.s3_policy_document.json,
        data.aws_iam_policy_document.user_permissions.json
    ]
}

# attach combined policy document to user 
resource "aws_iam_user_policy" "terraform_policy" {
  name = "terraform-policy"
  user = aws_iam_user.terraform_user.name
  policy = data.aws_iam_policy_document.terraform_user_policy_document.json
}
