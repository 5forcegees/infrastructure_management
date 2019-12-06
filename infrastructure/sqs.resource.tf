/* ==== BEGIN - SQS Variables ==== */
variable "default_content_deduplication" {
  default = "false"
}

variable "default_delay_seconds" {
  default = 0
}

variable "default_fifo_queue" {
  default = false
}

variable "default_max_message_size" {
  default = 262144
}

variable "default_message_retention" {
  default = 345600
}

variable "default_dlq_message_retention" {
  default = 864000
}

variable "default_wait_time" {
  default = 20
}

variable "default_visibility_timeout" {
  default = 30
}

variable "default_platform_queue_age_threshold" {
  default = {
    dev          = "900"
    test         = "900"
    test-account = "900"
    qa           = "600"
    prod         = "600"
    dev-ft  = "900"
    test-ft = "900"
  }
}

variable "default_general_queue_age_threshold" {
  default = {
    dev          = "3600"
    test         = "3600"
    test-account = "3600"
    qa           = "3600"
    prod         = "3600"
    dev-ft  = "3600"
    test-ft = "3600"
  }
}

variable "default_noc_queue_age_threshold" {
  default = {
    dev          = "7200"
    test         = "7200"
    test-account = "7200"
    qa           = "7200"
    prod         = "7200"
    dev-ft  = "7200"
    test-ft = "7200"
  }
}

variable "default_platform_sns_enabled" {
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

variable "default_general_sns_enabled" {
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

variable "default_noc_sns_enabled" {
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

/* ==== END - SQS Variables ==== */

/* ==== BEGIN - Commgateway SQS Queue Creation ==== */
module "commgateway-prefUp-sap" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-prefUp-sap-${var.env[terraform.workspace]}"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

resource "aws_sqs_queue_policy" "commgateway-prefUp-sap-policy" {
  depends_on = ["module.commgateway-prefUp-sap"]

  queue_url = "${module.commgateway-prefUp-sap.url}"
  policy    = "${data.aws_iam_policy_document.prefUp-sap-topic-policy.json}"
}

module "commgateway-prefUp-sap-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.commgateway-prefUp-sap.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_commgateway_prefUp_sap" {
  value = "${module.commgateway-prefUp-sap.name}"
}

module "commgateway-prefUp-sap-dlq" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-prefUp-sap-${var.env[terraform.workspace]}_dlq"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_dlq_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "commgateway-prefUp-mb" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-prefUp-mb-${var.env[terraform.workspace]}"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "commgateway-prefUp-mb-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.commgateway-prefUp-mb.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

resource "aws_sqs_queue_policy" "commgateway-prefUp-mb-policy" {
  
  depends_on = ["module.commgateway-prefUp-mb"]

  queue_url = "${module.commgateway-prefUp-mb.url}"
  policy    = "${data.aws_iam_policy_document.prefUp-mb-topic-policy.json}"
}

output "sqs_commgateway_prefUp_mb" {
  value = "${module.commgateway-prefUp-mb.name}"
}

module "commgateway-prefUp-mb-dlq" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-prefUp-mb-${var.env[terraform.workspace]}_dlq"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_dlq_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "commgateway-service-relay" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-service-relay-${var.env[terraform.workspace]}"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "commgateway-service-relay-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.commgateway-service-relay.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

resource "aws_sqs_queue_policy" "commgateway-service-relay-policy" {
  depends_on = ["module.commgateway-service-relay"]

  queue_url = "${module.commgateway-service-relay.url}"
  policy    = "${data.aws_iam_policy_document.commgateway-service-relay-topic-policy.json}"
}

output "sqs_commgateway_service_relay" {
  value = "${module.commgateway-service-relay.name}"
}

module "commgateway-service-relay-dlq" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-service-relay-${var.env[terraform.workspace]}_dlq"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_dlq_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "commgateway-message-intercept" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-message-intercept-${var.env[terraform.workspace]}"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "commgateway-message-intercept-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.commgateway-message-intercept.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

resource "aws_sqs_queue_policy" "commgateway-message-intercept-policy" {
  depends_on = ["module.commgateway-message-intercept"]

  queue_url = "${module.commgateway-message-intercept.url}"
  policy    = "${data.aws_iam_policy_document.notification-send-notification-topic.json}"
}

output "sqs_commgateway_message_intercept" {
  value = "${module.commgateway-message-intercept.name}"
}

module "commgateway-message-intercept_dlq" {
  source = "../modules/sqs"

  queue_name = "ci-commgateway-message-intercept-${var.env[terraform.workspace]}_dlq"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_dlq_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

/* ==== END - Commgateway SQS Queue Creation ==== */

/* ==== BEGIN - Microservices SQS Queue Creation ==== */
module "loader-file-available" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-file-available"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-file-available-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.loader-file-available.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

resource "aws_sqs_queue_policy" "file-available-policy" {
  queue_url = "${module.loader-file-available.url}"
  policy    = "${data.aws_iam_policy_document.file-available-topic-policy.json}"
}

module "loader-statement" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-statement"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-statement-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.loader-statement.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_loader_statement" {
  value = "${module.loader-statement.url}"
}

module "loader-account" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-account"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-account-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.loader-account.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_loader_account" {
  value = "${module.loader-account.url}"
}

module "loader-device" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-device"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-device-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.loader-device.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_loader_device" {
  value = "${module.loader-device.url}"
}

module "loader-payment" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-payment"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-payment-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"
  
  queue_name = "${module.loader-payment.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_loader_payment" {
  value = "${module.loader-payment.url}"
}

module "loader-customer" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-customer"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-customer-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.loader-customer.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_loader_customer" {
  value = "${module.loader-customer.url}"
}

module "loader-budgetbill" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-loader-budgetbill"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "loader-budgetbill-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.loader-budgetbill.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_loader_budgetbill" {
  value = "${module.loader-budgetbill.url}"
}

/* ==== END - Microservices SQS Queue Creation ==== */

/* ==== BEGIN - OEI SQS Queue Creation ==== */
module "oei-email-msg" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-oei-email-msg-queue.fifo"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "true"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "oei-email-msg-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.oei-email-msg.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

module "oei-sms-msg" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-oei-sms-msg-queue.fifo"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "true"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "oei-sms-msg-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.oei-sms-msg.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

module "oei-voice-msg" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-oei-voice-msg-queue.fifo"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "true"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "oei-voice-msg-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"

  queue_name = "${module.oei-voice-msg.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

/* ==== END - OEI SQS Queue Creation ==== */

/* ==== BEGIN - Outage SQS Queue Creation ==== */
module "outage-reportoutage" {
  source = "../modules/sqs"

  queue_name = "ci-${var.env[terraform.workspace]}-outage-reportoutage"

  content_deduplication = "${var.default_content_deduplication}"
  delay_seconds         = "${var.default_delay_seconds}"
  fifo_queue            = "${var.default_fifo_queue}"
  max_message_size      = "${var.default_max_message_size}"
  message_retention     = "${var.default_message_retention}"
  wait_time             = "${var.default_wait_time}"
  visibility_timeout    = "${var.default_visibility_timeout}"
}

module "outage-reportoutage-monitoring"{
  source = "../modules/cloudwatch/sqs-proactive-monitoring"


  queue_name = "${module.outage-reportoutage.name}"
  requiresPlatformNotification = "${var.default_platform_sns_enabled[terraform.workspace]}"
  requiresGeneralNotification = "${var.default_general_sns_enabled[terraform.workspace]}"
  requiresNOCNotification = "${var.default_noc_sns_enabled[terraform.workspace]}"

  platformQueueAgeThreshold = "${var.default_platform_queue_age_threshold[terraform.workspace]}"
  generalQueueAgeThreshold = "${var.default_general_queue_age_threshold[terraform.workspace]}"
  nocQueueAgeThreshold = "${var.default_noc_queue_age_threshold[terraform.workspace]}"

  platformSNSArn = "${aws_sns_topic.microservice_platform_sns.arn}"
  generalSNSArn = "${aws_sns_topic.microservice_general_sns.arn}"
  nocSNSArn = "${aws_sns_topic.microservice_noc_sns.arn}"

}

output "sqs_outage_reportoutage" {
  value = "${module.outage-reportoutage.url}"
}

/* ==== END - Outage SQS Queue Creation ==== */

