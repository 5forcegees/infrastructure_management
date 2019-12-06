output "sns_name" {
  value = "${aws_sns_topic.sns.name}"
}

output "sns_arn" {
  value = "${aws_sns_topic.sns.arn}"
}
