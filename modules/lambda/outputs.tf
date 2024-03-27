#get all courses
output "lambda_label_courses_invoke_arn" {
  value = module.lambda_label_courses.lambda_function_invoke_arn
}
output "lambda_label_courses_function_name" {
  value = module.lambda_label_courses.lambda_function_name
}


#get course
output "lambda_label_get_course_invoke_arn" {
  value = module.lambda_label_get_course.lambda_function_invoke_arn
}
output "lambda_label_get_course_function_name" {
  value = module.lambda_label_get_course.lambda_function_name
}

#update course
output "lambda_label_update_course_invoke_arn" {
  value = module.lambda_label_update_course.lambda_function_invoke_arn
}
output "lambda_label_update_course_function_name" {
  value = module.lambda_label_update_course.lambda_function_name
}

#save course
output "lambda_label_save_course_invoke_arn" {
  value = module.lambda_label_save_course.lambda_function_invoke_arn
}
output "lambda_label_save_course_function_name" {
  value = module.lambda_label_save_course.lambda_function_name
}

#delete course
output "lambda_label_delete_course_invoke_arn" {
  value = module.lambda_label_delete_course.lambda_function_invoke_arn
}
output "lambda_label_delete_course_function_name" {
  value = module.lambda_label_delete_course.lambda_function_name
}

###

#get all authors
output "lambda_label_authors_invoke_arn" {
  value = module.lambda.lambda_function_invoke_arn
}
output "lambda_label_authors_function_name" {
  value = module.lambda.lambda_function_name
}







