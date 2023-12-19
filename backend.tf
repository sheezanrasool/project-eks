terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "project-eks"
    key            = "prod/state-file/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}