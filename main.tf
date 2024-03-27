module "s3" {
  source      = "./modules/s3"
  bucket_name = "590184041689-my-tf-test-bucket-module"
}

module "s3_frontend" {
  source = "./modules/s3"
  bucket_name = "590184041689-s3-frontend"
}

module "table_authors" {
  source     = "./modules/dynamodb"
  context    = module.label.context
  table_name = "author" 
}
module "table_courses" {
  source     = "./modules/dynamodb"
  context    = module.label.context
  table_name = "course" 
}

module "lambda" {
  source        = "./modules/lambda"
  context    = module.label.context

  table_name    = "get-all-authors"
  table_name_courses = "get-all-courses"
  table_name_save_courses = "save-course"
  table_name_get_courses = "get-course"
  table_name_delete_courses = "delete-course"
  table_name_update_courses = "update-course"
  

  table_author_name  = module.table_authors.id
  table_courses_name  = module.table_courses.id
  
  table_author_arn = module.table_authors.arn
  table_courses_arn = module.table_courses.arn
}

resource "aws_s3_bucket" "this" {
  bucket = "testing-bucket-march-2024"

  tags = {
    Name        = "lab"
    Environment = "Dev"
  }
}
