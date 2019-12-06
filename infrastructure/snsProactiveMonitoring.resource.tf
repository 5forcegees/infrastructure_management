/* ==== BEGIN - Proactive Monitoring Varibles ==== */
variable "micro_sns_display_name" {
  default = {
    dev          = "DevMicro"
    test         = "TestMicro"
    test-account = "TestMicro"
    qa           = "QAMicro"
    prod         = "ProdMicro"
    dev-ft  = "DevFTMicro"
    test-ft = "TestFTMicro"
  }
}

variable "platform_sns_display_name" {
  default = {
    dev          = "DevMicroPlat"
    test         = "TestMicroPlat"
    test-account = "TestMicroPlat"
    qa           = "QAMicroPlat"
    prod         = "ProdMicroPlat"
    dev-ft  = "DevFTMicroPlat"
    test-ft = "TestFTMicroPlat"
  }
}

variable "noc_sns_display_name" {
  default = {
    dev          = "DevMicroNOC"
    test         = "TestMicroNOC"
    test-account = "TestMicroNOC"
    qa           = "QAMicroNOC"
    prod         = "ProdMicroNOC"
    dev-ft  = "DevFTMicroNOC"
    test-ft = "TestFTMicroNOC"
  }
}
/* ==== END - Proactive Monitoring Varibles ==== */

/* ==== BEGIN - SNS Topic Creation ==== */

resource "aws_sns_topic" "microservice_general_sns" {
  name = "ci-${var.env[terraform.workspace]}-microservices-general"
  display_name = "${var.micro_sns_display_name[terraform.workspace]}"
}

data "aws_ssm_parameter" "general_sns_sms_list" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/SNS/GeneralNotificationList"
}

resource "aws_sns_topic_subscription" "general_sns_subscriptions" {
  topic_arn = "${aws_sns_topic.microservice_general_sns.arn}"
  protocol  = "sms"
  endpoint  = "${element(split(",", data.aws_ssm_parameter.general_sns_sms_list.value),count.index)}"

  count = "${length(split(",", data.aws_ssm_parameter.general_sns_sms_list.value))}"
}

resource "aws_sns_topic" "microservice_platform_sns" {
  name = "ci-${var.env[terraform.workspace]}-microservices-platform"
  display_name = "${var.platform_sns_display_name[terraform.workspace]}"
}

data "aws_ssm_parameter" "platform_sns_sms_list" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/SNS/PlatformNotificationList"
}

resource "aws_sns_topic_subscription" "platform_sns_subscriptions" {
  topic_arn = "${aws_sns_topic.microservice_platform_sns.arn}"
  protocol  = "sms"
  endpoint  = "${element(split(",", data.aws_ssm_parameter.platform_sns_sms_list.value),count.index)}"

  count = "${length(split(",", data.aws_ssm_parameter.platform_sns_sms_list.value))}"
}

resource "aws_sns_topic" "microservice_noc_sns" {
  name = "ci-${var.env[terraform.workspace]}-microservices-noc"
  display_name = "${var.noc_sns_display_name[terraform.workspace]}"
}

data "aws_ssm_parameter" "noc_sns_sms_list" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/SNS/NOCNotificationList"
}

resource "aws_sns_topic_subscription" "noc_sns_subscriptions" {
  topic_arn = "${aws_sns_topic.microservice_noc_sns.arn}"
  protocol  = "sms"
  endpoint  = "${element(split(",", data.aws_ssm_parameter.noc_sns_sms_list.value),count.index)}"

  count = "${length(split(",", data.aws_ssm_parameter.noc_sns_sms_list.value))}"
}

output "general_sns_arn" {
  value = "${aws_sns_topic.microservice_general_sns.arn}"
}

output "platform_sns_arn" {
  value = "${aws_sns_topic.microservice_platform_sns.arn}"
}

output "noc_sns_arn" {
  value = "${aws_sns_topic.microservice_noc_sns.arn}"
}
/* ==== END - SNS Topic Creation ==== */

