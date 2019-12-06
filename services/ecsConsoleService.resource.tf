/* ==== BEGIN - ECS Agent Varibles ==== */
variable "console_service_names" {
  type    = "map"
  default = {
    dev-ft  = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
    test-ft = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
    dev     = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
    test    = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
    test-account = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
    qa      = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
    prod    = ["commgateway-prefUp-sap", "commgateway-prefUp-mb", "commgateway-service-relay", "commgateway-message-intercept"]
  }
}

/* ==== BEGIN - ECS Service Maps ==== */
variable "consoleService_desired_count_map" {
  type = "map"

  default = {
    dev = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test-account = {
      commgateway-prefUp-sap        = 0
      commgateway-prefUp-mb         = 0
      commgateway-service-relay     = 0
      commgateway-message-intercept = 0
    }

    qa = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    prod = {
      commgateway-prefUp-sap        = 2
      commgateway-prefUp-mb         = 2
      commgateway-service-relay     = 2
      commgateway-message-intercept = 2
    }

    dev-ft = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test-ft = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }
  }
}

variable "consoleService_min_count_map" {
  type = "map"

  default = {
    dev = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test-account = {
      commgateway-prefUp-sap        = 0
      commgateway-prefUp-mb         = 0
      commgateway-service-relay     = 0
      commgateway-message-intercept = 0
    }

    qa = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    prod = {
      commgateway-prefUp-sap        = 2
      commgateway-prefUp-mb         = 2
      commgateway-service-relay     = 2
      commgateway-message-intercept = 2
    }

    dev-ft = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test-ft = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }
  }
}

variable "consoleService_max_count_map" {
  type = "map"

  default = {
    dev = {
      commgateway-prefUp-sap        = 10
      commgateway-prefUp-mb         = 10
      commgateway-service-relay     = 10
      commgateway-message-intercept = 10
    }

    test = {
      commgateway-prefUp-sap        = 10
      commgateway-prefUp-mb         = 10
      commgateway-service-relay     = 10
      commgateway-message-intercept = 10
    }

    test-account = {
      commgateway-prefUp-sap        = 10
      commgateway-prefUp-mb         = 10
      commgateway-service-relay     = 10
      commgateway-message-intercept = 10
    }

    qa = {
      commgateway-prefUp-sap        = 10
      commgateway-prefUp-mb         = 10
      commgateway-service-relay     = 10
      commgateway-message-intercept = 10
    }

    prod = {
      commgateway-prefUp-sap        = 20
      commgateway-prefUp-mb         = 20
      commgateway-service-relay     = 20
      commgateway-message-intercept = 20
    }

    dev-ft = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }

    test-ft = {
      commgateway-prefUp-sap        = 1
      commgateway-prefUp-mb         = 1
      commgateway-service-relay     = 1
      commgateway-message-intercept = 1
    }
  }
}

variable "consoleService_min_mem_map" {
  type = "map"

  default = {
    dev = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }

    test = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }

    test-account = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }

    qa = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }

    prod = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }

    dev-ft = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }

    test-ft = {
      commgateway-prefUp-sap        = 30
      commgateway-prefUp-mb         = 30
      commgateway-service-relay     = 30
      commgateway-message-intercept = 30
    }
  }
}

variable "consoleService_max_mem_map" {
  type = "map"

  default = {
    dev = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }

    test = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }

    test-account = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }

    qa = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }

    prod = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }

    dev-ft = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }

    test-ft = {
      commgateway-prefUp-sap        = 65
      commgateway-prefUp-mb         = 65
      commgateway-service-relay     = 65
      commgateway-message-intercept = 65
    }
  }
}

variable "consoleService_sqs_threshold" {
  type = "map"

  default = {
    dev = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }

    test = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }

    test-account = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }

    qa = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }

    prod = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }

    dev-ft = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }

    test-ft = {
      commgateway-prefUp-sap        = 750
      commgateway-prefUp-mb         = 350
      commgateway-service-relay     = 350
      commgateway-message-intercept = 350
    }
  }
}


/* ==== END - ECS Agent Variables ==== */

/* ==== BEGIN - ECS Agent Creation ==== */

/* ==== BEGIN - ECS Service ==== */
module "ecs_consoleService" {
  source = "../modules/ecs/consoleService"

  env        = "${var.env[terraform.workspace]}"
  region     = "${var.region}"
  subnets    = "${var.subnet_ids[terraform.workspace]}"
  account_id = "${var.account_number[terraform.workspace]}"

  ecs_task_role_arn      = "${data.terraform_remote_state.infrastructure.ecs_task_role_arn}"
  ecs_execution_role_arn = "${data.terraform_remote_state.infrastructure.ecs_ecsTaskExecutionRole_arn}"

  ecs_service_names = "${var.console_service_names[terraform.workspace]}"

  cluster_name      = "${data.terraform_remote_state.infrastructure.ecs_cluster_arn}"
  desired_count_map = "${var.consoleService_desired_count_map[terraform.workspace]}"

  security_groups  = ["${data.terraform_remote_state.infrastructure.ecs_security_group_id}"]
  assign_public_ip = false
}

/* ==== BEGIN - CloudWatch Logging ==== */
module "consoleService_cloudwatch_logging_legacy" {
  source = "../modules/cloudwatch/logging"

  env          = "${var.env[terraform.workspace]}"
  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  names                       = "${formatlist("%s-%s", "${var.env[terraform.workspace]}", "${var.console_service_names[terraform.workspace]}")}"
  splunk_forwarder_lambda_arn = "${data.terraform_remote_state.infrastructure.lambda_splunkForwarder_arn}"
  log_group_retention         = "${var.log_group_retention[terraform.workspace]}"
}

/* ==== BEGIN - CloudWatch Autoscaling ==== */
module "consoleService_cloudwatch_autoscaling" {
  source = "../modules/cloudwatch/autoscaling"

  env    = "${var.env[terraform.workspace]}"
  region = "${var.region}"

  service_names = "${module.ecs_consoleService.consoleServices}"
  cluster_name  = "${data.terraform_remote_state.infrastructure.ecs_cluster_name}"

  min_count_map = "${var.consoleService_min_count_map[terraform.workspace]}"
  max_count_map = "${var.consoleService_max_count_map[terraform.workspace]}"

  min_mem_map   = "${var.consoleService_min_mem_map[terraform.workspace]}"
  max_mem_map   = "${var.consoleService_max_mem_map[terraform.workspace]}"

  sqs_threshold =  "${var.consoleService_sqs_threshold[terraform.workspace]}"

  requiresCPUScaling = false
  requiresMemScaling = true
  requiresSQSScaling = true
}

/* ==== END - ECS Agent Creation ==== */

