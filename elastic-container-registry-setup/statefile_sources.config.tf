/* ==== pull data from Dev remote state ==== */
data "terraform_remote_state" "dev_infrastructure" {
  backend = "s3"

  config {
    bucket   = "###CENSORED-S3-TERRAFORM-BUCKET###"
    key      = "/workspace/dev/infrastructure.tfstate"
    region   = "${var.region}"
  }
}

/* ==== pull data from Test remote state ==== */
data "terraform_remote_state" "test_ft_infrastructure" {
  backend = "s3"

  config {
    bucket   = "###CENSORED-S3-TERRAFORM-BUCKET###"
    key      = "/workspace/test-ft/infrastructure.tfstate"
    region   = "${var.region}"
    role_arn = "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
  }
}

/* ==== pull data from QA remote state ==== */
data "terraform_remote_state" "qa_infrastructure" {
  backend = "s3"

  config {
    bucket   = "###CENSORED-S3-TERRAFORM-BUCKET###"
    key      = "/workspace/qa/infrastructure.tfstate"
    region   = "${var.region}"
  }
}

/* ==== pull data from Prod remote state ==== */
data "terraform_remote_state" "prod_infrastructure" {
  backend = "s3"

  config {
    bucket   = "###CENSORED-S3-TERRAFORM-BUCKET###"
    key      = "/workspace/prod/infrastructure.tfstate"
    region   = "${var.region}"
  }
}