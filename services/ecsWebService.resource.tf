/* ==== BEGIN - ECS Agent Varibles ==== */
variable "webService_names" {
  type    = "map"
  default = {
    dev-ft  = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
    test-ft = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
    dev     = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
    test    = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
    test-account = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
    qa      = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
    prod    = ["statement", "authentication", "deferral", "payment", "document", "budget-bill", "account", "installment", "outage", "address", "customer", "forms", "notification", "project", "device"]
  }
}

/* ==== BEGIN - ECS Service Maps ==== */
variable "webService_desired_count_map" {
  type = "map"

  default = {
    dev = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }

    test = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }

    test-account = {
      statement      = "1"
      authentication = "1"
      deferral       = "1"
      payment        = "1"
      budget-bill    = "1"
      document       = "1"
      account        = "1"
      installment    = "1"
      outage         = "1"
      address        = "1"
      customer       = "1"
      forms          = "1"
      notification   = "1"
      project        = "1"
      device         = "1"
    }

    qa = {
      statement      = 3
      authentication = 5
      deferral       = 3
      payment        = 3
      budget-bill    = 5
      document       = 3
      account        = 5
      installment    = 5
      outage         = 5
      address        = 3
      customer       = 5
      forms          = 3
      notification   = 3
      project        = 3
      device         = 5
    }

    prod = {
      statement      = 4
      authentication = 5
      deferral       = 3
      payment        = 3
      budget-bill    = 5
      document       = 3
      account        = 5
      installment    = 5
      outage         = 5
      address        = 3
      customer       = 5
      forms          = 3
      notification   = 3
      project        = 3
      device         = 5
    }

   dev-ft = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }
  
   test-ft = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }
  }
}

variable "webService_min_count_map" {
  type = "map"

  default = {
    dev = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }

    test = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }

    test-account = {
      statement      = "1"
      authentication = "1"
      deferral       = "1"
      payment        = "1"
      budget-bill    = "1"
      document       = "1"
      account        = "1"
      installment    = "1"
      outage         = "1"
      address        = "1"
      customer       = "1"
      forms          = "1"
      notification   = "1"
      project        = "1"
      device         = "1"
    }

    qa = {
      statement      = 3
      authentication = 5
      deferral       = 3
      payment        = 3
      budget-bill    = 5
      document       = 3
      account        = 5
      installment    = 5
      outage         = 5
      address        = 3
      customer       = 5
      forms          = 3
      notification   = 3
      project        = 3
      device         = 5
    }

    prod = {
      statement      = 4
      authentication = 5
      deferral       = 3
      payment        = 3
      budget-bill    = 5
      document       = 3
      account        = 5
      installment    = 5
      outage         = 5
      address        = 3
      customer       = 5
      forms          = 3
      notification   = 3
      project        = 3
      device         = 5
    }

    dev-ft = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }
 
    test-ft = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }
  }
}

variable "webService_max_count_map" {
  type = "map"

  default = {
    dev = {
      statement      = "10"
      authentication = "10"
      deferral       = "10"
      payment        = "10"
      budget-bill    = "10"
      document       = "10"
      account        = "10"
      installment    = "10"
      outage         = "10"
      address        = "10"
      customer       = "10"
      forms          = "10"
      notification   = "10"
      project        = "10"
      device         = "10"
    }

    test = {
      statement      = "10"
      authentication = "10"
      deferral       = "10"
      payment        = "10"
      budget-bill    = "10"
      document       = "10"
      account        = "10"
      installment    = "10"
      outage         = "10"
      address        = "10"
      customer       = "10"
      forms          = "10"
      notification   = "10"
      project        = "10"
      device         = "10"
    }

    test-account = {
      statement      = "10"
      authentication = "10"
      deferral       = "10"
      payment        = "10"
      budget-bill    = "10"
      document       = "10"
      account        = "10"
      installment    = "10"
      outage         = "10"
      address        = "10"
      customer       = "10"
      forms          = "10"
      notification   = "10"
      project        = "10"
      device         = "10"
    }

    qa = {
      statement      = 25
      authentication = 25
      deferral       = 25
      payment        = 25
      budget-bill    = 25
      document       = 25
      account        = 25
      installment    = 25
      outage         = 25
      address        = 25
      customer       = 25
      forms          = 25
      notification   = 25
      project        = 25
      device         = 25
    }

    prod = {
      statement      = 25
      authentication = 25
      deferral       = 25
      payment        = 25
      budget-bill    = 25
      document       = 25
      account        = 25
      installment    = 25
      outage         = 25
      address        = 25
      customer       = 25
      forms          = 25
      notification   = 25
      project        = 25
      device         = 25
    }

    dev-ft = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }

   test-ft = {
      statement      = 1
      authentication = 1
      deferral       = 1
      payment        = 1
      budget-bill    = 1
      document       = 1
      account        = 1
      installment    = 1
      outage         = 1
      address        = 1
      customer       = 1
      forms          = 1
      notification   = 1
      project        = 1
      device         = 1
    }
  }
}

variable "webService_min_mem_map" {
  type = "map"

  default = {
    dev = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }

    test = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }

    test-account = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }

    qa = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }

    prod = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }

    dev-ft = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }

   test-ft = {
      statement      = 30
      authentication = 30
      deferral       = 30
      payment        = 30
      budget-bill    = 30
      document       = 30
      account        = 30
      installment    = 30
      outage         = 30
      address        = 30
      customer       = 30
      forms          = 30
      notification   = 30
      project        = 30
      device         = 30
    }
  }
}

variable "webService_max_mem_map" {
  type = "map"

  default = {
    dev = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }

    test = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }

    test-account = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }

    qa = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }

    prod = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }

    dev-ft = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }

   test-ft = {
      statement      = 65
      authentication = 55
      deferral       = 65
      payment        = 65
      budget-bill    = 65
      document       = 65
      account        = 55
      installment    = 65
      outage         = 65
      address        = 65
      customer       = 55
      forms          = 65
      notification   = 65
      project        = 65
      device         = 65
    }
  }
}

variable "webService_sqs_threshold" {
  type = "map"

  default = {
    dev = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }

    test = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }

    test-account = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }

    qa = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }
    
    prod = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }

    dev-ft = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }

   test-ft = {
      statement      = 350
      authentication = 350
      deferral       = 350
      payment        = 350
      budget-bill    = 350
      document       = 350
      account        = 350
      installment    = 350
      outage         = 350
      address        = 350
      customer       = 350
      forms          = 350
      notification   = 350
      project        = 350
      device         = 350
    }
  }
}


/* ==== BEGIN - ALB Listern Rules ==== */
/* beware of overlapping rules, see http://awowttfap01v01:8080/tfs/WebAndMobile/Microservices/Microservices%20Team/_wiki?pagePath=%2FPlatform%2FALB-Routing-strategy */
  variable "alb_listener_rules" {
  type = "list"

  default = [
    "statement,/v1.0/account/*/statement*,40",
    "deferral,/v1.0/account/*/deferral*,41",
    "budget-bill,/v1.0/account/*/budget-bill*,42",
    "installment,/v1.0/account/*/installment*,43",
    "document,/v1.0/account/*/document*,44",
    "payment,/v1.0/account/*/payment*,45",
    "outage,/v1.0/outage*,90",
    "document,/v1.0/document*,91",
    "authentication,/v1.0/authentication*,92",
    "account,/v1.0/account*,93",
    "address,/v1.0/address*,95",
    "customer,/v1.0/customer*,96",
    "forms,/v1.0/forms*,98",
    "notification,/v1.0/notification*,99",
    "project,/v1.0/project*,100",
    "device,/v1.0/device*,101",
    "device,/v1.0/installation*,102",
    "statement,/v1.0/statement*,103",
    "deferral,/swagger/deferral*,1001",
    "payment,/swagger/payment*,1002",
    "statement,/swagger/statement*,1003",
    "authentication,/swagger/authentication*,1004",
    "document,/swagger/document*,1005",
    "budget-bill,/swagger/budget-bill*,1006",
    "account,/swagger/account*,1007",
    "installment,/swagger/installment*,1008",
    "outage,/swagger/outage*,1010",
    "address,/swagger/address*,1011",
    "customer,/swagger/customer*,1012",
    "forms,/swagger/forms*,1013",
    "notification,/swagger/notification*,1014",
    "project,/swagger/project*,1015",
    "device,/swagger/device*,1016",
    "account,/v1.0/private/account*,1101",
    "customer,/v1.0/private/customer*,1102",
    "installment,/v1.0/private/installment*,1103",
    "budget-bill,/v1.0/private/budget-bill*,1104",
    "device,/v1.0/private/device*,1105",
  ]
}

/* ==== END - ECS Agent Variables ==== */

/* ==== BEGIN - ECS Service Creation ==== */

/* ==== BEGIN - ECS Service ==== */
module "ecs_webService" {
  source = "../modules/ecs/webService"

  env        = "${var.env[terraform.workspace]}"
  region     = "${var.region}"
  subnets    = "${var.subnet_ids[terraform.workspace]}"
  account_id = "${var.account_number[terraform.workspace]}"

  ecs_task_role_arn      = "${data.terraform_remote_state.infrastructure.ecs_task_role_arn}"
  ecs_execution_role_arn = "${data.terraform_remote_state.infrastructure.ecs_ecsTaskExecutionRole_arn}"

  ecs_service_names = "${var.webService_names[terraform.workspace]}"

  cluster_name = "${data.terraform_remote_state.infrastructure.ecs_cluster_name}"
  cluster_arn  = "${data.terraform_remote_state.infrastructure.ecs_cluster_arn}"

  desired_count_map = "${var.webService_desired_count_map[terraform.workspace]}"

  security_groups  = ["${data.terraform_remote_state.infrastructure.ecs_security_group_id}"]
  assign_public_ip = false

  default_tags = "${var.default_tags}"

  vpc_id = "${var.vpc_id[terraform.workspace]}"

  alb_listener_rules = "${var.alb_listener_rules}"
  alb_listener_arn   = "${data.terraform_remote_state.infrastructure.alb_listener_arn}"
  alb_listener_ssl_arn   = "${data.terraform_remote_state.infrastructure.alb_listener_ssl_arn}"
  alb_arn_suffix     = "${data.terraform_remote_state.infrastructure.alb_suffix}"
}

/* ==== BEGIN - CloudWatch Service Logging ==== */
module "webService_cloudwatch_logging_legacy" {
  source = "../modules/cloudwatch/logging"

  env          = "${var.env[terraform.workspace]}"
  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  names                       = "${formatlist("%s-%s", "${var.env[terraform.workspace]}", "${var.webService_names[terraform.workspace]}")}"
  splunk_forwarder_lambda_arn = "${data.terraform_remote_state.infrastructure.lambda_splunkForwarder_arn}"
  log_group_retention         = "${var.log_group_retention[terraform.workspace]}"
}

/* ==== BEGIN - CloudWatch Autoscaling ==== */
module "webService_cloudwatch_autoscaling" {
  source = "../modules/cloudwatch/autoscaling"

  env    = "${var.env[terraform.workspace]}"
  region = "${var.region}"

  service_names = "${module.ecs_webService.webServices}"
  cluster_name  = "${data.terraform_remote_state.infrastructure.ecs_cluster_name}"

  min_count_map = "${var.webService_min_count_map[terraform.workspace]}"
  max_count_map = "${var.webService_max_count_map[terraform.workspace]}"

  min_mem_map   = "${var.webService_min_mem_map[terraform.workspace]}"
  max_mem_map   = "${var.webService_max_mem_map[terraform.workspace]}"

  sqs_threshold = "${var.webService_sqs_threshold[terraform.workspace]}"

  requiresCPUScaling = false
  requiresMemScaling = true
  requiresSQSScaling = false
}

/* ==== END - ECS Service Creation ==== */

