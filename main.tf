provider "aws" {
  region = var.region
  default_tags {
    tags = {
        "project" = var.project_name
    }
  }
}
module "bootstrap_aws" {
  source = "./bootstrap"
  terraform_username = "highbee-terraform"
  bucket_name = "highbee-billion"
}