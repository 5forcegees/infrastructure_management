resource "aws_sns_topic_subscription" "sns-subscription" {
  topic_arn     = "${var.topic_arn}"
  protocol      = "${var.protocol}"
  endpoint      = "${var.endpoint}"
  filter_policy = "${var.filter_policy}"
}
