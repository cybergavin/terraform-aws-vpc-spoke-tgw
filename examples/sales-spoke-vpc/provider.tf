terraform {
  required_version = "= 1.8.8" # Pin to the exact version in production
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.82.0" # Use the exact version tested in production
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}