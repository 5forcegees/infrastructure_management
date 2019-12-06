resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.log_group_name}"
  retention_in_days = "${var.log_group_retention}"
}

resource "aws_cloudwatch_log_subscription_filter" "log_group_filter" {
  depends_on = ["aws_lambda_permission.splunk_forward_allow_cloudwatch"]

  name            = "lambdafunction-logfilter-${var.source_lambda_name}"
  log_group_name  = "${var.log_group_name}"
  filter_pattern  = ""
  destination_arn = "${var.splunk_forwarder_lambda}"                     //give it the ARN
}

resource "aws_lambda_permission" "splunk_forward_allow_cloudwatch" {
  statement_id  = "splunk-forward-allow-${var.source_lambda_name}-cloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = "${var.splunk_forwarder_lambda}"                            //give it the ARN
  principal     = "logs.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.log_group.arn}"
}
