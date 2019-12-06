variable "nocContainerThreshold" {
  default = {
    dev          = "90"
    test         = "90"
    test-account = "90"
    qa           = "90"
    prod         = "90"
    dev-ft  = "190"
    test-ft = "190"
  }
}

variable "generalContainerThreshold" {
  default = {
    dev          = "75"
    test         = "75"
    test-account = "75"
    qa           = "75"
    prod         = "75"
    dev-ft  = "75"
    test-ft = "75"
  }
}

variable "platformContainerThreshold" {
  default = {
    dev          = "60"
    test         = "60"
    test-account = "60"
    qa           = "60"
    prod         = "60"
    dev-ft  = "60"
    test-ft = "60"
  }
}

variable "requiresNocNotification" {
  default = {
    dev          = "false"
    test         = "false"
    test-account = "false"
    qa           = "true"
    prod         = "true"
    dev-ft  = "false"
    test-ft = "false"
  }
}

variable "requiresGeneralNotification" {
  default = {
    dev          = "false"
    test         = "false"
    test-account = "false"
    qa           = "true"
    prod         = "true"
    dev-ft  = "false"
    test-ft = "false"
  }
}

variable "requiresPlatformNotification" {
  default = {
    dev          = "false"
    test         = "false"
    test-account = "false"
    qa           = "true"
    prod         = "true"
    dev-ft  = "false"
    test-ft = "false"
  }
}

resource "aws_cloudwatch_metric_alarm" "increaing_container_count_alarms" {
  count = "${length(var.webService_names[terraform.workspace])}"

  alarm_name                = "ci-${var.env[terraform.workspace]}-${element(var.webService_names[terraform.workspace], count.index)}-increasing-container-count"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1 
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${floor(((lookup(var.webService_max_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index)) - lookup(var.webService_min_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index))) * var.platformContainerThreshold[terraform.workspace] / 100.0) + lookup(var.webService_min_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index)))}"
  insufficient_data_actions = []

  dimensions {
    TargetGroup = "${element(module.ecs_webService.webServices_tg, count.index)}"
    LoadBalancer = "${data.terraform_remote_state.infrastructure.alb_suffix}" 
  }

  alarm_description = "Over ${var.platformContainerThreshold[terraform.workspace]}% of the available capacity of containers for the ${element(var.webService_names[terraform.workspace], count.index)} service are being utilized."
  actions_enabled   = "${var.requiresPlatformNotification[terraform.workspace]}"
  alarm_actions     = ["${data.terraform_remote_state.infrastructure.platform_sns_arn}"]
}


resource "aws_cloudwatch_metric_alarm" "high_container_count_alarms" {
  count = "${length(var.webService_names[terraform.workspace])}"

  alarm_name                = "ci-${var.env[terraform.workspace]}-${element(var.webService_names[terraform.workspace], count.index)}-high-container-count"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${floor(((lookup(var.webService_max_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index)) - lookup(var.webService_min_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index))) * var.generalContainerThreshold[terraform.workspace] / 100.0) + lookup(var.webService_min_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index)))}"
  insufficient_data_actions = []

  dimensions {
    TargetGroup = "${element(module.ecs_webService.webServices_tg, count.index)}"
    LoadBalancer = "${data.terraform_remote_state.infrastructure.alb_suffix}"
  }

  alarm_description = "Over ${var.generalContainerThreshold[terraform.workspace]}% of the available capacity of containers for the ${element(var.webService_names[terraform.workspace], count.index)} service are being utilized."
  actions_enabled   = "${var.requiresGeneralNotification[terraform.workspace]}"
  alarm_actions     = ["${data.terraform_remote_state.infrastructure.general_sns_arn}"]
}


resource "aws_cloudwatch_metric_alarm" "critical_container_count_alarms" {
  count = "${length(var.webService_names[terraform.workspace])}"

  alarm_name                = "ci-${var.env[terraform.workspace]}-${element(var.webService_names[terraform.workspace], count.index)}-critical-container-count"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${floor(((lookup(var.webService_max_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index)) - lookup(var.webService_min_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index))) * var.nocContainerThreshold[terraform.workspace] / 100.0) + lookup(var.webService_min_count_map[terraform.workspace], element(var.webService_names[terraform.workspace], count.index)))}"
  insufficient_data_actions = []

  dimensions {
    TargetGroup = "${element(module.ecs_webService.webServices_tg, count.index)}"
    LoadBalancer = "${data.terraform_remote_state.infrastructure.alb_suffix}"
  }

  alarm_description = "Over ${var.nocContainerThreshold[terraform.workspace]}% of the available capacity of containers for the ${element(var.webService_names[terraform.workspace], count.index)} service are being utilized."
  actions_enabled   = "${var.requiresNocNotification[terraform.workspace]}"
  alarm_actions     = ["${data.terraform_remote_state.infrastructure.noc_sns_arn}"]
}
