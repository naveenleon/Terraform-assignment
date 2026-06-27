terraform {
  backend "s3" {
    bucket         = "terraform-state-dev-bucket-31"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
