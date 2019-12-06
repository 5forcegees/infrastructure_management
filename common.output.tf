/* ==== common output ==== */

/* ==== AWS Identity Output ==== */
data "aws_caller_identity" "current" {}

output "AccountID" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "CallerARN" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "AWSRegion" {
  value = "${var.region}"
}

output "EnvName" {
  value = "${var.env[terraform.workspace]}"
}

output "TerraformIAMRole" {
  value = "${var.workspace_iam_roles[terraform.workspace]}"
}
