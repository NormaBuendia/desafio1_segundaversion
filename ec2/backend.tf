# Terraform backend configuration
terraform {
  backend "s3" {
    bucket = "jf-terraform-bucket"
    key    = "nginx-ec2/terraform.tfstate"
    region = "us-east-1"
  }
}