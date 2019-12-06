/* ==== general vars ==== */
variable "env" {}

variable "region" {}

variable "default_tags" {
  type = "map"
}

variable "log_group_name" {}
variable "log_group_retention" {}
variable "source_lambda_name" {}
variable "splunk_forwarder_lambda" {}
