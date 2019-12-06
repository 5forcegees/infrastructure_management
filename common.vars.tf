/* ==== common vars ==== */
variable "region" {
  default = "us-west-2"
}

variable "default_tags" {
  default = {
    "terraform"  = "true"
    "type"       = "ci"
    "costcenter" = "5326"
    "workorder"  = "92306049"
  }
}

variable "ecr_account_id" {
  default = "###CENSORED-DEV-ACCOUNT-NUMBER###"
}

/* === Workspace Variables === */
variable "env" {
  default = {
    dev          = "dev"
    test         = "test"
    test-account = "test"
    qa           = "qa"
    prod         = "prod"
    dev-ft  = "dev-ft"
    test-ft = "test-ft"
  }
}

variable "account_name" {
  default = {
    dev          = "nonprod"
    test         = "nonprod"
    test-account = "test"
    qa           = "preprod"
    prod         = "prod"
    dev-ft  = "nonprod"
    test-ft = "nonprod"
  }
}

variable "account_number" {
  default = {
    dev          = "###CENSORED-DEV-ACCOUNT-NUMBER###"
    test         = "###CENSORED-DEV-ACCOUNT-NUMBER###"
    test-account = "###CENSORED-TEST-ACCOUNT-NUMBER###"
    qa           = "###CENSORED-QA-ACCOUNT-NUMBER###"
    prod         = "941964952328"
    dev-ft  = "###CENSORED-DEV-ACCOUNT-NUMBER###"
    test-ft = "###CENSORED-DEV-ACCOUNT-NUMBER###"
  }
}

/* === IAM roles for execution of Terraform  === */
variable "workspace_iam_roles" {
  default = {
    dev          = "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    test         = "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    test-account = "arn:aws:iam::###CENSORED-TEST-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    qa           = "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    prod         = "arn:aws:iam::941964952328:role/ci-WebTFSBuildRole"
    dev-ft  = "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    test-ft = "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
  }
}

/* === AZs === */
data "aws_availability_zones" "available" {}

/* === VPCs === */
variable "vpc_id" {
  default = {
    dev          = "vpc-4d9fcf2b"
    test         = "vpc-4d9fcf2b"
    test-account = "vpc-09c2cd1f1f12f2d88"
    qa           = "vpc-b66da7d0"
    prod         = "vpc-9163a9f7"
    dev-ft  = "vpc-4d9fcf2b"
    test-ft = "vpc-4d9fcf2b"
  }
}

/* === Subnets === */
variable "subnet_ids" {
  default = {
    dev          = ["subnet-ea981ca2", "subnet-463c5b20", "subnet-e4a98abf"]
    test         = ["subnet-ea981ca2", "subnet-463c5b20", "subnet-e4a98abf"]
    test-account = ["subnet-0376e925cf4c90ab3", "subnet-084e83300874134be", "subnet-06cf8bbf0a5fbcb2c"]
    qa           = ["subnet-949e79f2", "subnet-f981bfb0", "subnet-12328c49"]
    prod         = ["subnet-93e502f5", "subnet-3e7e4777", "subnet-79328c22"]
    dev-ft  = ["subnet-ea981ca2", "subnet-463c5b20", "subnet-e4a98abf"]
    test-ft = ["subnet-ea981ca2", "subnet-463c5b20", "subnet-e4a98abf"]
  }
}

/* === OEI Security Groups (Legacy Windows Services) === */
variable "oei_server_sgs" {
  default = {
    dev          = []
    test         = ["sg-03ff3b47510140d20"]
    test-account = []
    qa           = ["sg-d479a7a5"]
    prod         = ["sg-0b23e9a155124fdb7"]
    dev-ft  = []
    test-ft = ["sg-03ff3b47510140d20"]
  }
}

/* === Key Names === */
variable "key_names" {
  default = {
    dev          = "nonprod-microservices-ecs"
    test         = "nonprod-microservices-ecs"
    test-account = "nonprod-microservices-ecs"
    qa           = "preprod-microservices-ecs"
    prod         = "prod-microservices-ecs"
    dev-ft  = "nonprod-microservices-ecs"
    test-ft = "nonprod-microservices-ecs"  
  }
}

/* === PAX Variables === */
variable "ecs_throttling_cleanup_time_days" {
  default = {
    dev          = "14"
    test         = "14"
    test-account = "14"
    qa           = "14"
    prod         = "14"
    dev-ft  = "14"
    test-ft = "14"
  }
}

variable "ecs_throttling_notify_timeout_mins" {
  default = {
    dev          = "10"
    test         = "10"
    test-account = "10"
    qa           = "10"
    prod         = "10"
    dev-ft  = "10"
    test-ft = "10"
  }
}

variable "ecs_throttling_sns_topic" {
  default = {
    dev          = "NONE"
    test         = "NONE"
    test-account = "NONE"
    qa           = "NONE"
    prod         = "NONE"
    dev-ft  = "NONE"
    test-ft = "NONE"
  }
}

variable "ecs_throttling_spark_bot" {
  default = {
    dev          = "###CENSORED-CISCO-TEAMS-BOT-ID###"
    test-account = "###CENSORED-CISCO-TEAMS-BOT-ID###"
    test         = "###CENSORED-CISCO-TEAMS-BOT-ID###"
    qa           = "###CENSORED-CISCO-TEAMS-BOT-ID###"
    prod         = "###CENSORED-CISCO-TEAMS-BOT-ID###"
    dev-ft  = "###CENSORED-CISCO-TEAMS-BOT-ID###"
    test-ft = "###CENSORED-CISCO-TEAMS-BOT-ID###"
  }
}

variable "ecs_throttling_spark_room" {
  default = {
    dev          = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
    test         = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
    test-account = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
    qa           = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
    prod         = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
    dev-ft  = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
    test-ft = "###CENSORED-CISCO-TEAMS-ROOM-ID###"
  }
}

variable "ecs_throttling_spark_room_details" {
  default = {
    dev          = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
    test         = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
    test-account = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
    qa           = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
    prod         = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
    dev-ft  = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
    test-ft = "###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###"
  }
}

variable "ecs_throttling_fail_thresh" {
  default = {
    dev          = "5"
    test         = "5"
    test-account = "5"
    qa           = "5"
    prod         = "5"
    dev-ft  = "5"
    test-ft = "5"
  }
}

variable "ecs_throttling_fail_time_thresh" {
  default = {
    dev          = "10"
    test         = "10"
    test-account = "10"
    qa           = "10"
    prod         = "10"
    dev-ft  = "10"
    test-ft = "10"
  }
}

variable "ecs_throttling_fail_notify_timeout" {
  default = {
    dev          = "10"
    test         = "10"
    test-account = "10"
    qa           = "10"
    prod         = "10"
    dev-ft  = "10"
    test-ft = "10"
  }
}

variable "log_group_retention" {
  default = {
    dev          = "7"
    test         = "7"
    test-account = "7"
    qa           = "14"
    prod         = "14"
    dev-ft  = "7"
    test-ft = "7"
  }
}

variable "enable_pax" {
  default = {
    dev          = 1
    test         = 1
    test-account = 0
    qa           = 1
    prod         = 1
    dev-ft  = 1
    test-ft = 1
  }
}

variable "allow_cloudwatch_events_needed" {
  default = {
    dev          = 1
    test         = 1
    test-account = 1
    qa           = 1
    prod         = 1
    dev-ft  = 1
    test-ft = 1
  }
}

# this will make the services/api_gateway use a proxy testlate for initial creation.  should be followed up with tfs whitelist creation and deployment
variable "use_api_gw_testlate" {
  default = {
    dev          = 0
    test         = 1
    test-account = 1
    qa           = 1
    prod         = 1
    dev-ft  = 0
    test-ft = 1
  }
}

variable "quota_limit_per_day" {
  default = {
    dev          = 100000
    test         = 100000
    test-account = 100000
    qa           = 100000
    prod         = 100000
    dev-ft  = 100000
    test-ft = 100000
  }
}

variable "throttling_rate_per_second" {
  default = {
    dev          = 1000
    test         = 1000
    test-account = 1000
    qa           = 1000
    prod         = 1000
    dev-ft  = 1000
    test-ft = 1000
  }
}

variable "throttling_burst" {
  default = {
    dev          = 500
    test         = 500
    test-account = 500
    qa           = 500
    prod         = 500
    dev-ft  = 500
    test-ft = 500
  }
}

variable "metrics_enabled" {
  default = {
    dev          = true
    test         = true
    test-account = true
    qa           = true
    prod         = true
    dev-ft  = true
    test-ft = true
  }
}

variable "logging_level" {
  default = {
    dev          = "INFO"
    test         = "INFO"
    test-account = "INFO"
    qa           = "INFO"
    prod         = "INFO"
    dev-ft  = "INFO"
    test-ft = "INFO"
  }
}

variable "data_trace_enabled" {
  default = {
    dev          = true
    test         = true
    test-account = true
    qa           = true
    prod         = true
    dev-ft  = true
    test-ft = true
  }
}


variable "requires_third_party_gw" {
  default = {
    dev          = 0
    test         = 1 
    test-account = 0
    qa           = 1
    prod         = 1
    dev-ft  = 0
    test-ft = 0
  }
}

variable "requires_cloudfront_token" {
  default = {
    poc          = 0
    dev          = 1
    test         = 0
    test-account = 0
    qa           = 0
    prod         = 0
    dev-ft  = 1
    test-ft = 0
  }
}

variable "int_svc_cert_arn" {
  default = {
    dev          = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/83453b59-11b8-44f1-83b0-9a79ed9b0787"
    test         = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/938d39a7-11a4-4208-aa46-794bd928507d"
    test-account = "arn:aws:acm:us-west-2:###CENSORED-TEST-ACCOUNT-NUMBER###:certificate/54aed216-2af2-4bd5-90a6-624c67d20ac3"
    qa           = "arn:aws:acm:us-west-2:###CENSORED-QA-ACCOUNT-NUMBER###:certificate/fff6ac80-ae98-47d6-b15f-d330985754c0"
    prod         = "arn:aws:acm:us-west-2:941964952328:certificate/71d4fb99-2147-4326-8295-024d76fb1152"
    dev-ft       = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/83453b59-11b8-44f1-83b0-9a79ed9b0787"
    test-ft      = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/938d39a7-11a4-4208-aa46-794bd928507d"
  }
}
