terraform {
  backend "s3" {
    encrypt              = true
    acl                  = "private"
    bucket               = "###CENSORED-S3-TERRAFORM-BUCKET###"
    region               = "us-west-2"
    key                  = "workspace/test/parameter_store.tfstate"
    dynamodb_table       = "###CENSORED-S3-TERRAFORM-BUCKET###"
    workspace_key_prefix = "workspace"
    skip_credentials_validation = true
  }
}

output "State Bucket" {
  value = "###CENSORED-S3-TERRAFORM-BUCKET###/workspace/test/parameter_store.tfstate"
}
