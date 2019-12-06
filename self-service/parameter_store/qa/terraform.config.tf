/* ==== save terraform state in S3 ==== */
terraform {
  backend "s3" {
    encrypt        = true
    acl            = "private"
    bucket         = "###CENSORED-S3-TERRAFORM-BUCKET###"
    region         = "us-west-2"
    key            = "workspace/qa/parameter_store.tfstate"
    dynamodb_table = "###CENSORED-S3-TERRAFORM-BUCKET###"
    skip_credentials_validation = true
  }
}

/* ==== Caller Identity ==== */
data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "State Bucket" {
  value = "###CENSORED-S3-TERRAFORM-BUCKET###/workspace/qa/parameter_store.tfstate"
}
