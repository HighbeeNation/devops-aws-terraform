variable "bucket_name" {
  type = string

   validation {
    condition = length(var.bucket_name) > 0
    error_message = "bucket name not set"
  }
}

variable "terraform_username" {
  type = string

  validation {
    condition = length(var.terraform_username) > 0
    error_message = "terraform user name not set"
  }
}

variable "user_permission_list" {
  description = "List of permissions to create or access resources by our terraform user"
  type =  list(string)
  default = [ "s3:CreateBucket" ]
}