terraform {
  backend "s3" {
    bucket = "590184041689-terraform-tfstate-2024"
    key = "main/dev/terraform.tfstate"
    region = "eu-north-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.7.4, < 2.0.0"
}


# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}