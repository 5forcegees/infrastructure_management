variable "nonEcsLogGroups" {
  type="map"
  default = {
    dev-ft  = ["notification-wcf", "batch-loader"]
    test-ft = ["notification-wcf", "batch-loader"]
    dev     = ["notification-wcf", "batch-loader"]
    test    = ["notification-wcf", "batch-loader"]
    test-account = ["notification-wcf", "batch-loader"]
    qa      = ["notification-wcf", "batch-loader"]
    prod    = ["notification-wcf", "batch-loader"]
  }
}

/* ==== BEGIN - CloudWatch non-ECS Logging ==== */
module "webService_cloudwatch_logging_extra" {
  source = "../modules/cloudwatch/logging"

  env          = "${var.env[terraform.workspace]}"
  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  names                       = "${formatlist("%s-%s", "${var.env[terraform.workspace]}", "${var.nonEcsLogGroups[terraform.workspace]}")}"
  splunk_forwarder_lambda_arn = "${data.terraform_remote_state.infrastructure.lambda_splunkForwarder_arn}"
  log_group_retention         = "${var.log_group_retention[terraform.workspace]}"
}

/* ==== END - non-ECS Log Groups Creation ==== */

