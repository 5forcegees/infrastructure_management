data "aws_ecs_task_definition" "service" {
  count = "${length(var.ecs_service_names)}"

  task_definition = "${var.ecs_service_names[count.index]}-${var.env}"
}

/* ==== Creates agents that are deployed to ECS ==== */
resource "aws_ecs_service" "fargate_webService" {
  depends_on = ["aws_alb_listener_rule.rules"]
  depends_on = ["aws_alb_target_group.alb_tg"]
  count      = "${length(var.ecs_service_names)}"

  name          = "${var.ecs_service_names[count.index]}"
  cluster       = "${var.cluster_arn}"
  desired_count = "${lookup(var.desired_count_map, element(var.ecs_service_names, count.index))}"

  #iam_role                          = "${var.ecs_service_role}"
  deployment_minimum_healthy_percent = 100

  health_check_grace_period_seconds  = 30
  
  task_definition = "arn:aws:ecs:${var.region}:${var.account_id}:task-definition/${data.aws_ecs_task_definition.service.*.family[count.index]}:${data.aws_ecs_task_definition.service.*.revision[count.index]}"

  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb_tg.*.arn[count.index]}"
    container_name   = "${var.ecs_service_names[count.index]}"
    container_port   = 5000
  }

  network_configuration {
    subnets          = ["${var.subnets}"]
    security_groups  = ["${var.security_groups}"]
    assign_public_ip = "${var.assign_public_ip}"
  }

  lifecycle {
    ignore_changes = ["task_definition", "desired_count"]
  }
}

/* ==== Create service target group for alb ==== */
resource "aws_alb_target_group" "alb_tg" {
  count = "${length(var.ecs_service_names)}"

  name                 = "ci-${var.env}-${var.ecs_service_names[count.index]}-tg"
  port                 = 5000
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = 110

  health_check = {
    path    = "/healthcheck"
    matcher = 200
    unhealthy_threshold = 3 
    timeout = 2  
  }

  target_type = "ip"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env}-default-tg"
  ))}"
}

output "aws_alb_tg_suffix" {
  value = "${aws_alb_target_group.alb_tg.*.arn_suffix}"
}

/* ==== create alb rules for all services ==== */
resource "aws_alb_listener_rule" "rules" {
  count = "${length(var.alb_listener_rules)}"

  listener_arn = "${var.alb_listener_arn}"
  priority     = "${element(split(",", element(var.alb_listener_rules, count.index)), 2)}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_tg.*.arn[index(var.ecs_service_names, element(split(",", element(var.alb_listener_rules, count.index)), 0))]}"
  }

  condition {
    field  = "path-pattern"
    values = ["${element(split(",", element(var.alb_listener_rules, count.index)), 1)}"]
  }
}

resource "aws_alb_listener_rule" "rules_ssl" {
  count = "${length(var.alb_listener_rules)}"

  listener_arn = "${var.alb_listener_ssl_arn}"
  priority     = "${element(split(",", element(var.alb_listener_rules, count.index)), 2)}"

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_tg.*.arn[index(var.ecs_service_names, element(split(",", element(var.alb_listener_rules, count.index)), 0))]}"
  }

  condition {
    field  = "path-pattern"
    values = ["${element(split(",", element(var.alb_listener_rules, count.index)), 1)}"]
  }
}

resource "aws_appautoscaling_policy" "scale_up_policies_alb" {
  count      = "${length(var.ecs_service_names)}"
  depends_on = ["aws_ecs_service.fargate_webService"]
  depends_on = ["aws_alb_target_group.alb_tg"]

  name               = "ci-${var.env}-${var.ecs_service_names[count.index]}-scale-up-alb-traffic"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${var.cluster_name}/${var.ecs_service_names[count.index]}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${var.alb_arn_suffix}/${aws_alb_target_group.alb_tg.*.arn_suffix[count.index]}"
    }

    disable_scale_in = true
    target_value     = 750
  }
}
