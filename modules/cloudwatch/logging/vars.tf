/* ==== general vars ==== */
variable "env" {}

variable "region" {}

variable "default_tags" {
  type = "map"
}

/* ==== Log Group vars ==== */
variable "names" {
  type = "list"
}

variable "log_group_retention" {}
variable "splunk_forwarder_lambda_arn" {}
