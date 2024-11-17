variable "project_name" {
  type = string
  default = "aws-terraform"  
  
  validation {
    condition = length(var.project_name) > 0
    error_message = "project_name can not be empty!"
  }
}

variable "region" {
    type = string
    default = "us-east-1"
    
    validation {
        condition = length(var.region) > 0
        error_message = "region can't be empty"
    }
  
    validation {
      condition = contains(["us-east-1"], var.region)
      error_message = "Not a valid REgion"
    }
}


