/* ==== pull data from remote state ==== */
data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config {
    bucket = "###CENSORED-S3-TERRAFORM-BUCKET###"
    key    = "/workspace/test-account/infrastructure.tfstate"
    region = "us-west-2"
  }
}
