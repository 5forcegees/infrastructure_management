/* ==== save terraform state in S3 ==== */
terraform {
  backend "s3" {
    encrypt              = true
    acl                  = "private"
    bucket               = "###CENSORED-S3-TERRAFORM-BUCKET###"
    region               = "us-west-2"
    key                  = "services.tfstate"
    dynamodb_table       = "###CENSORED-S3-TERRAFORM-BUCKET###"
    workspace_key_prefix = "workspace"
    skip_credentials_validation = true
  }
}

output "State Bucket" {
  value = "###CENSORED-S3-TERRAFORM-BUCKET###/workspace/${terraform.workspace}/service.tfstate"
}
