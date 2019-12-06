
resource "aws_cloudwatch_metric_alarm" "increaing_sqs_age_alarms" {

  alarm_name                = "${var.queue_name}-increasing-queue-age"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${var.platformQueueAgeThreshold}"
  insufficient_data_actions = []

  dimensions {
    QueueName = "${var.queue_name}"
  }

  alarm_description = "Average Age of Items in queue has exceeded ${var.platformQueueAgeThreshold}."
  actions_enabled   = "${var.requiresPlatformNotification}"
  alarm_actions     = ["${var.platformSNSArn}"]
}


resource "aws_cloudwatch_metric_alarm" "high_sqs_age_alarms" {

  alarm_name                = "${var.queue_name}-high-queue-age"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${var.generalQueueAgeThreshold}"
  insufficient_data_actions = []

  dimensions {
    QueueName = "${var.queue_name}"
  }

  alarm_description = "Average Age of Items in queue has exceeded ${var.platformQueueAgeThreshold}."
  actions_enabled   = "${var.requiresGeneralNotification}"
  alarm_actions     = ["${var.generalSNSArn}"]
}


resource "aws_cloudwatch_metric_alarm" "critical_sqs_age_alarms" {
  
  alarm_name                = "${var.queue_name}-critical-queue-age"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${var.nocQueueAgeThreshold}"
  insufficient_data_actions = []

  dimensions {
    QueueName = "${var.queue_name}"
  }

  alarm_description = "Average Age of Items in queue has exceeded ${var.platformQueueAgeThreshold}."
  actions_enabled   = "${var.requiresNOCNotification}"
  alarm_actions     = ["${var.nocSNSArn}"]
}

