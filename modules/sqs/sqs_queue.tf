resource "aws_sqs_queue" "queue" {
  name = "${var.queue_name}"

  content_based_deduplication = "${var.content_deduplication}"
  delay_seconds               = "${var.delay_seconds}"
  fifo_queue                  = "${var.fifo_queue}"
  max_message_size            = "${var.max_message_size}"
  message_retention_seconds   = "${var.message_retention}"
  receive_wait_time_seconds   = "${var.wait_time}"
  visibility_timeout_seconds  = "${var.visibility_timeout}"
  tags                        = "${var.default_tags}"
}
