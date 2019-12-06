/* ==== BEGIN - PAX Creation ==== */
resource "aws_cloudwatch_event_rule" "ecs_task_change_event_rule" {
  name        = "ci-ecsTaskChange-${var.env[terraform.workspace]}"
  description = "Capture all ECS Task Changes to a Stopped State to monitor potential ECS task failure"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.ecs"
  ],
  "detail-type": [
    "ECS Task State Change"
  ],
  "detail": {
    "desiredStatus": [
      "STOPPED"
    ],
    "lastStatus": [
      "STOPPED"
    ],
    "clusterArn": [
      "${aws_ecs_cluster.cluster.arn}"
    ]
  }
}
PATTERN


  count       = "${var.enable_pax[terraform.workspace]}"
}

resource "aws_cloudwatch_event_target" "cloudwatch_lambda_target" {
  rule      = "${aws_cloudwatch_event_rule.ecs_task_change_event_rule.name}"
  target_id = "SendToLambda"
  arn       = "${aws_lambda_function.ecs_throttling_lambda.arn}"

  count     = "${var.enable_pax[terraform.workspace]}"
}

resource "aws_lambda_permission" "allow_cloudwatch_events" {
  function_name = "${aws_lambda_function.ecs_throttling_lambda.function_name}"
  statement_id  = "AllowExecutionFromEvents"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.ecs_task_change_event_rule.arn}"

  count = "${var.enable_pax[terraform.workspace] == 1 ? var.allow_cloudwatch_events_needed[terraform.workspace] : 0}"
}

/* ==== END - PAX Creation ==== */

