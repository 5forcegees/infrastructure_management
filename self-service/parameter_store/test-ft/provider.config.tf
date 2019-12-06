/* ==== load aws ==== */
provider "aws" {
  version = "~> 1.43.0"

  region = "${var.region}"

  assume_role {
    session_name = "terraform_setup_parameter_store"
    role_arn     = "arn:aws:iam::${var.account_number}:role/ci-WebTFSBuildRole"
  }

  endpoints {
    sts = "###CENSORED-STS-VPC-ENDPOINT###"
  }
}
