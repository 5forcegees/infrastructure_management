resource "aws_appautoscaling_target" "ecs_targets" {
  count = "${length(var.service_names)}"

  max_capacity       = "${lookup(var.max_count_map, element(var.service_names, count.index))}"
  min_capacity       = "${lookup(var.min_count_map, element(var.service_names, count.index))}"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_down_policies_mem" {
  count = "${var.requiresMemScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_target.ecs_targets"]

  name               = "ci-${var.env}-${element(var.service_names, count.index)}-scale-down-mem"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 600
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = -1
      metric_interval_upper_bound = 0
    }
  }
}

resource "aws_appautoscaling_policy" "scale_up_policies_mem" {
  count = "${var.requiresMemScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_target.ecs_targets"]

  name               = "ci-${var.env}-${element(var.service_names, count.index)}-scale-up-mem"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = 1
      metric_interval_upper_bound = 15.0
      metric_interval_lower_bound = 0.0
    }

    step_adjustment {
      scaling_adjustment          = 3
      metric_interval_lower_bound = 15.0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "low_memory_usage_alarms" {
  count = "${var.requiresMemScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_policy.scale_down_policies_mem"]

  alarm_name                = "ci-${var.env}-${element(var.service_names, count.index)}-low-memory-usage"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 2
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${lookup(var.min_mem_map, element(var.service_names, count.index))}"
  insufficient_data_actions = []

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${element(var.service_names, count.index)}"
  }

  alarm_description = "This metric monitors low memory utilization"
  alarm_actions     = ["${aws_appautoscaling_policy.scale_down_policies_mem.*.arn[count.index]}"]
}

resource "aws_cloudwatch_metric_alarm" "high_memory_usage_alarms" {
  count = "${var.requiresMemScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_policy.scale_up_policies_mem"]

  alarm_name                = "ci-${var.env}-${element(var.service_names, count.index)}-high-memory-usage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "${lookup(var.max_mem_map, element(var.service_names, count.index))}"
  datapoints_to_alarm       = 2
  evaluation_periods        = 3
  insufficient_data_actions = []

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${element(var.service_names, count.index)}"
  }

  alarm_description = "This metric monitors high memory utilization"
  alarm_actions     = ["${aws_appautoscaling_policy.scale_up_policies_mem.*.arn[count.index]}"]
}


resource "aws_cloudwatch_metric_alarm" "sqs-low-messages" {
  count = "${var.requiresSQSScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_policy.scale_down_policies_messages"]

  alarm_name = "ci-${var.env}-${element(var.service_names, count.index)}-low-messages"

  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "0"
  insufficient_data_actions = []

  dimensions {
    QueueName = "ci-${element(var.service_names, count.index)}-${var.env}"
  }

  alarm_description         = "This metric monitors the number of messages within the queue"
  alarm_actions             = ["${aws_appautoscaling_policy.scale_down_policies_messages.*.arn[count.index]}"]
}

resource "aws_appautoscaling_policy" "scale_down_policies_messages" {
  count = "${var.requiresSQSScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_target.ecs_targets"]

  name               = "ci-${var.env}-${element(var.service_names, count.index)}-scale-down-messages"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = -1
      metric_interval_upper_bound = 0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "sqs-high-messages" {
  count = "${var.requiresSQSScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_policy.scale_up_policies_messages"]

  alarm_name = "ci-${var.env}-${element(var.service_names, count.index)}-high-messages"

  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "${lookup(var.sqs_threshold, element(var.service_names, count.index))}"
  insufficient_data_actions = []

  dimensions {
    QueueName = "ci-${element(var.service_names, count.index)}-${var.env}"
  }

  alarm_description         = "This metric monitors the number of messages within the queue"
  alarm_actions             = ["${aws_appautoscaling_policy.scale_up_policies_messages.*.arn[count.index]}"]
}

resource "aws_appautoscaling_policy" "scale_up_policies_messages" {
  count = "${var.requiresSQSScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_target.ecs_targets"]

  name               = "ci-${var.env}-${element(var.service_names, count.index)}-scale-up-messages"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = 1
      metric_interval_upper_bound = 1500.0
      metric_interval_lower_bound = 0.0
    }

    step_adjustment {
      scaling_adjustment          = 3
      metric_interval_lower_bound = 1500.0
    }    
  }
}

resource "aws_appautoscaling_policy" "scale_down_policies_cpu" {
  count = "${var.requiresCPUScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_target.ecs_targets"]

  name               = "ci-${var.env}-${element(var.service_names, count.index)}-scale-down-cpu"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 600
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = -1
      metric_interval_upper_bound = 0
    }
  }
}

resource "aws_appautoscaling_policy" "scale_up_policies_cpu" {
  count = "${var.requiresCPUScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_target.ecs_targets"]

  name               = "ci-${var.env}-${element(var.service_names, count.index)}-scale-up-cpu"
  policy_type        = "StepScaling"
  resource_id        = "service/${var.cluster_name}/${element(var.service_names, count.index)}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      scaling_adjustment          = 1
      metric_interval_upper_bound = 15.0
      metric_interval_lower_bound = 0.0
    }

    step_adjustment {
      scaling_adjustment          = 3
      metric_interval_lower_bound = 15.0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_usage_alarms" {
  count = "${var.requiresCPUScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_policy.scale_down_policies_cpu"]

  alarm_name                = "ci-${var.env}-${element(var.service_names, count.index)}-low-cpu-usage"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "30"
  insufficient_data_actions = []

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${element(var.service_names, count.index)}"
  }

  alarm_description = "This metric monitors low CPU utilization"
  alarm_actions     = ["${aws_appautoscaling_policy.scale_down_policies_cpu.*.arn[count.index]}"]
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_usage_alarms" {
  count = "${var.requiresCPUScaling ? length(var.service_names) : 0}"
  depends_on = ["aws_appautoscaling_policy.scale_up_policies_cpu"]

  alarm_name                = "ci-${var.env}-${element(var.service_names, count.index)}-high-cpu-usage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "65"
  datapoints_to_alarm       = 2
  evaluation_periods        = 3
  insufficient_data_actions = []

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${element(var.service_names, count.index)}"
  }

  alarm_description = "This metric monitors high CPU utilization"
  alarm_actions     = ["${aws_appautoscaling_policy.scale_up_policies_cpu.*.arn[count.index]}"]
}

