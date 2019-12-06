terraform {
  backend "s3" {
    encrypt              = true
    acl                  = "private"
    bucket               = "###CENSORED-S3-TERRAFORM-BUCKET###"
    region               = "us-west-2"
    key                  = "infrastructure.tfstate"
    dynamodb_table       = "###CENSORED-S3-TERRAFORM-BUCKET###"
    workspace_key_prefix = "workspace"
    skip_credentials_validation = true
  }
}

output "StateBucket" {
  value = "###CENSORED-S3-TERRAFORM-BUCKET###/workspace/${terraform.workspace}/infrastructure.tfstate"
}
