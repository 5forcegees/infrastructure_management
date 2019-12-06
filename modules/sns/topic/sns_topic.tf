resource "aws_sns_topic" "sns" {
  name = "${var.name}"

  #  policy = "${var.policy}"

  application_success_feedback_sample_rate = "${var.application_success_feedback_sample_rate}"
  http_success_feedback_sample_rate        = "${var.http_success_feedback_sample_rate}"
  lambda_success_feedback_sample_rate      = "${var.lambda_success_feedback_sample_rate}"
  sqs_success_feedback_sample_rate         = "${var.sqs_success_feedback_sample_rate}"
}
