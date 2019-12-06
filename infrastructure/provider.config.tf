provider "aws" {
  version = "~> 1.43.0"
  
  region = "us-west-2"

  assume_role {
    role_arn     = "${var.workspace_iam_roles[terraform.workspace]}"
    session_name = "UpdateInfrastructure-${terraform.workspace}"
  }

  endpoints {
    sts = "###CENSORED-STS-VPC-ENDPOINT###"
  }
}
