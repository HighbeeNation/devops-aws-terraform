# State Bucket 
resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.bucket_name}-s3highbee"
  
  tags = {
    purpose = "Terraform State Bucket"
  }
}

# State Bucket Poolicy Document
data "aws_iam_policy_document" "state_bucket_policy_document" {

  statement {
    sid = "User List Bucket"

    principals {
      type = "AWS"
      identifiers = [ aws_iam_user.terraform_user.arn ]
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.state_bucket.arn,
    ]

  }

  statement {

    sid = "User Access State file"

    principals {
      type = "AWS"
      identifiers = [ aws_iam_user.terraform_user.arn ]
    }

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

# Attach Policy to Bucket
resource "aws_s3_bucket_policy" "state_bucket_policy_attachement" {
  bucket = aws_s3_bucket.state_bucket.id
  policy = data.aws_iam_policy_document.state_bucket_policy_document.json
}

