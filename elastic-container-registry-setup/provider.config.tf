provider "aws" {
  version = "~> 1.40.0"
  region = "us-west-2"

  assume_role {
    role_arn     = "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    session_name = "UpdateECR"
  }

  endpoints {
    sts = "###CENSORED-STS-VPC-ENDPOINT###"
  }
}
