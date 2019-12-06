resource "aws_cloudwatch_dashboard" "ecs-monitoring-dashboard" {
   dashboard_name = "Microservices-Container-Monitor-${title(var.env[terraform.workspace])}"

   dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "stacked": true,
        "metrics": [
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "forms"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "forms"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "account"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "account"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "statement"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "statement"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "installment"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "installment"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "customer"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "customer"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "payment"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "payment"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "document"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "document"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "device"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "device"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "authentication"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "authentication"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "project"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "project"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "budget-bill"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "budget-bill"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "notification"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "notification"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "deferral"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "deferral"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "address"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "address"
            }
          ],
          [
            "AWS/ApplicationELB",
            "HealthyHostCount",
            "TargetGroup",
            "${element(module.ecs_webService.webServices_tg, index(var.webService_names[terraform.workspace], "outage"))}",
            "LoadBalancer",
            "${data.terraform_remote_state.infrastructure.alb_suffix}",
            {
              "stat": "Minimum",
              "label": "outage"
            }
          ]
        ],
        "region": "${var.region}",
        "start": "-P3D",
        "end": "P0D",
        "title": "Container Count (Healthy ELB Targets) - ${title(var.env[terraform.workspace])}"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "forms",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "account",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "statement",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "commgateway-prefUp-mb",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "installment",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "customer",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "payment",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "document",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "commgateway-message-intercept",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "device",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "commgateway-service-relay",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "commgateway-prefUp-sap",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "authentication",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "project",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "budget-bill",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "notification",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "deferral",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "address",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "MemoryUtilization",
            "ServiceName",
            "outage",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ]
        ],
        "region": "${var.region}",
        "start": "-P3D",
        "end": "P0D",
        "title": "Maximum Memory Utilization - ${title(var.env[terraform.workspace])}"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "stacked": false,
        "metrics": [
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "forms",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "account",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "statement",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "commgateway-prefUp-mb",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "installment",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "customer",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "payment",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "document",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "commgateway-message-intercept",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "device",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "commgateway-service-relay",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "commgateway-prefUp-sap",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "authentication",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "project",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "budget-bill",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "notification",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "deferral",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "address",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ],
          [
            "AWS/ECS",
            "CPUUtilization",
            "ServiceName",
            "outage",
            "ClusterName",
            "${data.terraform_remote_state.infrastructure.ecs_cluster_name}",
            {
              "stat": "Maximum",
              "period": 60
            }
          ]
        ],
        "region": "${var.region}",
        "start": "-P3D",
        "end": "P0D",
        "title": "Maximum CPU Utilization - ${title(var.env[terraform.workspace])}"
      }
    }
  ]
} 
EOF
}
