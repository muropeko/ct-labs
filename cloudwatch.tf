module "notification_label" {
    source = "cloudposse/label/null"
    version = "0.25.0"
    context = module.label.context
    name = "notification"
}


resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name                = module.notification_label.id
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = 60
  statistic                 = "Sum"
  threshold                 = 1
  alarm_description         = "Alarm for errors in lambda function ${module.lambda.lambda_label_update_course_function_name}"
  insufficient_data_actions = []
  treat_missing_data = "notBreaching"
  dimensions = {
    "FunctionName" = "${module.lambda.lambda_label_update_course_function_name}"
  }
  datapoints_to_alarm = 1

  actions_enabled = "true"
  alarm_actions = [aws_sns_topic.this.arn]
  ok_actions = [ aws_sns_topic.this.arn]
} 

resource "aws_sns_topic" "this" {
  name = module.label.id
}

resource "aws_sns_topic_subscription" "this" {
    topic_arn = aws_sns_topic.this.arn
    protocol = "email"
    endpoint = "anastasiia.dovhoshyia.ri.2022@lpnu.ua"
}