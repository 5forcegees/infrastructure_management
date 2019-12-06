data "aws_ecs_task_definition" "service" {
  count = "${length(var.ecs_service_names)}"

  task_definition = "${var.ecs_service_names[count.index]}-${var.env}"
}

/* ==== Creates agents that are deployed to ECS ==== */
resource "aws_ecs_service" "fargate_consoleService" {
  count = "${length(var.ecs_service_names)}"

  name                               = "${element(var.ecs_service_names, count.index)}"
  cluster                            = "${var.cluster_name}"
  desired_count                      = "${lookup(var.desired_count_map, element(var.ecs_service_names, count.index))}"
  deployment_minimum_healthy_percent = 50

  task_definition = "arn:aws:ecs:${var.region}:${var.account_id}:task-definition/${data.aws_ecs_task_definition.service.*.family[count.index]}:${data.aws_ecs_task_definition.service.*.revision[count.index]}"

  launch_type = "FARGATE"

  network_configuration {
    subnets          = ["${var.subnets}"]
    security_groups  = ["${var.security_groups}"]
    assign_public_ip = "${var.assign_public_ip}"
  }

  lifecycle {
    ignore_changes = ["task_definition", "desired_count"]
  }
}
