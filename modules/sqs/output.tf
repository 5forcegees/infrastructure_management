output "name" {
  value = "${aws_sqs_queue.queue.name}"
}

output "arn" {
  value = "${aws_sqs_queue.queue.arn}"
}

output "url" {
  value = "${aws_sqs_queue.queue.id}"
}
