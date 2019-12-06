# the config file here doesn't have a backend because it builds the backend
# then the infrastructure and services use this backend for state storage and locking
provider "aws" {
  version = "~> 1.40.0"
  
  region = "us-west-2"

  assume_role {
    role_arn     = "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    session_name = "CreateStateStorageAndLocking"
  }

  endpoints {
    sts = "###CENSORED-STS-VPC-ENDPOINT###"
  }
}
