resource "aws_cloudwatch_log_group" "log_group" {
  count = "${length(var.names)}"

  name              = "${var.names[count.index]}"
  retention_in_days = "${var.log_group_retention}"

  tags = {
    Environment = "${var.env}"
    Service     = "${var.names[count.index]}"
  }
}

resource "aws_cloudwatch_log_subscription_filter" "log_group_filter" {
  depends_on = ["aws_lambda_permission.splunk_forward_allow_cloudwatch"]
  count      = "${length(var.names)}"

  name            = "lambdafunction-logfilter-${var.names[count.index]}"
  log_group_name  = "${aws_cloudwatch_log_group.log_group.*.name[count.index]}"
  filter_pattern  = ""
  destination_arn = "${var.splunk_forwarder_lambda_arn}"
}

resource "aws_lambda_permission" "splunk_forward_allow_cloudwatch" {
  count = "${length(var.names)}"

  statement_id  = "splunk-forward-allow-${var.names[count.index]}-cloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = "${var.splunk_forwarder_lambda_arn}"
  principal     = "logs.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.log_group.*.arn[count.index]}"
}
