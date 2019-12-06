/* ==== BEGIN PAX DynamoDB Tables ==== */
resource "aws_dynamodb_table" "ecs_throttling_table" {
  name           = "ci-ECSTaskFailureTracking-${var.env[terraform.workspace]}"
  hash_key       = "taskArn"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "taskArn"
    type = "S"
  }

  ttl {
    attribute_name = "expiration_time"
    enabled        = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-ECSTaskFailureTracking-${var.env[terraform.workspace]}"
  ))}"
}

resource "aws_dynamodb_table" "ecs_throttling_notification_table" {
  name           = "ci-ECSTaskFailureNotificationTracking-${var.env[terraform.workspace]}"
  hash_key       = "Service"
  range_key      = "ClusterName"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "Service"
    type = "S"
  }

  attribute {
    name = "ClusterName"
    type = "S"
  }

  ttl {
    attribute_name = "expiration_time"
    enabled        = true
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-ECSTaskFailureNotificationTracking-${var.env[terraform.workspace]}"
  ))}"
}

/* ==== END PAX DynamoDB Tables ==== */

