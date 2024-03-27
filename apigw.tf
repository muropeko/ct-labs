resource "aws_api_gateway_rest_api" "this" {
    name = module.label_api.id

    endpoint_configuration {
        types = ["REGIONAL"]
    }
}


###################
#   GET COURSES   #
###################
resource "aws_api_gateway_resource" "courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    parent_id = aws_api_gateway_rest_api.this.root_resource_id
    path_part = "courses"
}


resource "aws_api_gateway_method" "get_courses" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.courses.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.courses.id
    http_method = aws_api_gateway_method.get_courses.http_method
    integration_http_method = "POST"
    type = "AWS"
    uri = module.lambda.lambda_label_courses_invoke_arn 
    request_parameters = {"integration.request.header.X-Authorization" = "'static'"}
    request_templates = {
        "application/xml" = <<EOF
        {
            "body" : $input.json('$')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.courses.id
    http_method = aws_api_gateway_method.get_courses.http_method
    status_code = "200"
    response_models = {"application/json" = "Empty"}
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = true,
      "method.response.header.Access-Control-Allow-Methods" = true,
      "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "get_courses" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.courses.id
    http_method = aws_api_gateway_method.get_courses.http_method
    status_code = aws_api_gateway_method_response.get_courses.status_code
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}


###################
#   GET AUTHORS   #
###################
resource "aws_api_gateway_resource" "authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    parent_id = aws_api_gateway_rest_api.this.root_resource_id
    path_part = "authors"
}

resource "aws_api_gateway_method" "get_authors" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.authors.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_authors.http_method
    integration_http_method = "POST"
    type = "AWS"
    uri = module.lambda.lambda_label_authors_invoke_arn
    request_parameters = {"integration.request.header.X-Authorization" = "'static'"}
    request_templates = {
        "application/xml" = <<EOF
        {
            "body" : $input.json('$')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_authors.http_method
    status_code = "200"
    response_models = {"application/json" = "Empty"}
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = true,
      "method.response.header.Access-Control-Allow-Methods" = true,
      "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "get_authors" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.authors.id
    http_method = aws_api_gateway_method.get_authors.http_method
    status_code = aws_api_gateway_method_response.get_authors.status_code
    response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}

##################
#   GET COURSE   #
##################
resource "aws_api_gateway_resource" "Id" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    parent_id   = aws_api_gateway_resource.courses.id
    path_part   = "{id}"
}

resource "aws_api_gateway_method" "get_course" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.Id.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_course" {
    rest_api_id             = aws_api_gateway_rest_api.this.id
    resource_id             = aws_api_gateway_resource.Id.id
    http_method             = aws_api_gateway_method.get_course.http_method
    integration_http_method = "POST"
    type                    = "AWS"
    uri                     = module.lambda.lambda_label_get_course_invoke_arn
    request_templates = {
        "application/json" = <<EOF
        {
            "id": "$input.params('id')"
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "get_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.get_course.http_method
    status_code = "200"
    response_models = {
        "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true
        "method.response.header.Access-Control-Allow-Methods" = true
        "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "get_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.get_course.http_method
    status_code = aws_api_gateway_method_response.get_course.status_code
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
        "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'"
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}

#####################
#   UPDATE COURSE   #
#####################
resource "aws_api_gateway_method" "update_course" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.Id.id
    http_method   = "PUT"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "update_course" {
    rest_api_id             = aws_api_gateway_rest_api.this.id
    resource_id             = aws_api_gateway_resource.Id.id
    http_method             = aws_api_gateway_method.update_course.http_method
    integration_http_method = "POST"
    type                    = "AWS"
    uri                     = module.lambda.lambda_label_update_course_invoke_arn
    request_templates = {
        "application/json" = <<EOF
        {
            "id": "$input.params('id')",
            "title": $input.json('$.title'),
            "authorId": $input.json('$.authorId'),
            "length": $input.json('$.length'),
            "category": $input.json('$.category'),
            "watchHref": $input.json('$.watchHref')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "update_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.update_course.http_method
    status_code = "200"
    response_models = {
        "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true
        "method.response.header.Access-Control-Allow-Methods" = true
        "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "update_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.update_course.http_method
    status_code = aws_api_gateway_method_response.update_course.status_code
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
        "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'"
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}

###################
#   SAVE COURSE   #
###################
resource "aws_api_gateway_method" "save_course" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.Id.id
    http_method   = "POST"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "save_course" {
    rest_api_id             = aws_api_gateway_rest_api.this.id
    resource_id             = aws_api_gateway_resource.Id.id
    http_method             = aws_api_gateway_method.save_course.http_method
    integration_http_method = "POST"
    type                    = "AWS"
    uri                     = module.lambda.lambda_label_save_course_invoke_arn
    request_templates = {
        "application/json" = <<EOF
        {
            "title": $input.json('$.title'),
            "authorId": $input.json('$.authorId'),
            "length": $input.json('$.length'),
            "category": $input.json('$.category')
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "save_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.save_course.http_method
    status_code = "200"
    response_models = {
        "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true
        "method.response.header.Access-Control-Allow-Methods" = true
        "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "save_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.save_course.http_method
    status_code = aws_api_gateway_method_response.save_course.status_code
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
        "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'"
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}


#####################
#   DELETE COURSE   #
#####################
resource "aws_api_gateway_method" "delete_course" {
    rest_api_id   = aws_api_gateway_rest_api.this.id
    resource_id   = aws_api_gateway_resource.Id.id
    http_method   = "DELETE"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "delete_course" {
    rest_api_id             = aws_api_gateway_rest_api.this.id
    resource_id             = aws_api_gateway_resource.Id.id
    http_method             = aws_api_gateway_method.delete_course.http_method
    integration_http_method = "POST"
    type                    = "AWS"
    uri                     = module.lambda.lambda_label_delete_course_invoke_arn
    request_templates = {
        "application/json" = <<EOF
        {
            "id": "$input.params('id')",
        }
        EOF
    }
    content_handling = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "delete_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.delete_course.http_method
    status_code = "200"
    response_models = {
        "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true
        "method.response.header.Access-Control-Allow-Methods" = true
        "method.response.header.Access-Control-Allow-Origin" = false
    }
}

resource "aws_api_gateway_integration_response" "delete_course" {
    rest_api_id = aws_api_gateway_rest_api.this.id
    resource_id = aws_api_gateway_resource.Id.id
    http_method = aws_api_gateway_method.delete_course.http_method
    status_code = aws_api_gateway_method_response.delete_course.status_code
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
        "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'"
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}
