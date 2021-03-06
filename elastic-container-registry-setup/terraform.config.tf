terraform {
  backend "s3" {
    encrypt              = true
    acl                  = "private"
    bucket               = "###CENSORED-S3-TERRAFORM-BUCKET###"
    region               = "us-west-2"
    key                  = "workspace/ecr.tfstate"
    dynamodb_table       = "###CENSORED-S3-TERRAFORM-BUCKET###"
    role_arn             = "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"
    workspace_key_prefix = "workspace"
  }
}

output "StateBucket" {
  value = "###CENSORED-S3-TERRAFORM-BUCKET###/workspace/ecr.tfstate"
}
