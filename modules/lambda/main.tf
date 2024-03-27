module "label" {
  source = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name = var.table_name
}

module "label_courses" {
  source = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name = var.table_name_courses
}

module "label_save_courses"{
  source = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name = var.table_name_save_courses
}

module "label_get_courses"{
  source = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name = var.table_name_get_courses
}

module "label_delete_courses"{
  source = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name = var.table_name_delete_courses
}

module "label_update_courses"{
  source = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
  name = var.table_name_update_courses
}

####

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = module.label.id
  description   = "Lambda function to get all authors"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = "${path.module}/lambda_src/get_all_authors/index.js"
  environment_variables = {
    TABLE_NAME = var.table_author_name
  }
  
  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = ["dynamodb:Scan"],
      resources = [var.table_author_arn]
    }
  }

  tags = module.label.tags
}


module "lambda_label_courses" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = module.label_courses.id
  description   = "Lambda function to get all courses"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = "${path.module}/lambda_src/get_all_courses/index.js"
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = ["dynamodb:Scan"]
      resources = [var.table_courses_arn]
    }
  }

  tags = module.label_courses.tags
}

module "lambda_label_save_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = module.label_save_courses.id
  description   = "Lambda function to save course"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = "${path.module}/lambda_src/save_course/index.js"
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = ["dynamodb:PutItem"]
      resources = [var.table_courses_arn]
    }
  }

  tags = module.label_save_courses.tags
}

module "lambda_label_get_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = module.label_get_courses.id
  description   = "Lambda function to get course"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = "${path.module}/lambda_src/get_course/index.js"
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = ["dynamodb:GetItem"]
      resources = [var.table_courses_arn]
    }
  }

  tags = module.label_get_courses.tags
}

module "lambda_label_delete_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = module.label_delete_courses.id
  description   = "Lambda function to delete course"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = "${path.module}/lambda_src/delete_course/index.js"
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = ["dynamodb:DeleteItem"]
      resources = [var.table_courses_arn]
    }
  }

  tags = module.label_delete_courses.tags
}

module "lambda_label_update_course" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.2"

  function_name = module.label_update_courses.id
  description   = "Lambda function to update course"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = "${path.module}/lambda_src/update_course/index.js"
  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = ["dynamodb:PutItem"]
      resources = [var.table_courses_arn]
    }
  }

  tags = module.label_update_courses.tags
}
