locals {
    tag_name = var.bucket_name
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        =  local.tag_name
    Environment = "Dev"
  }
}

module "s3_frontend" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.1"

  # bucket = "590184041689-s3-frontend"

  versioning = {
    enabled = false
  }
}