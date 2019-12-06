/* ==== create s3 to remotely store .tfstate in ==== */
variable "bucket_name" {
  default = "###CENSORED-S3-TERRAFORM-BUCKET###"
}

resource "aws_s3_bucket" "s3" {
  bucket = "${var.bucket_name}"

  acl    = "private"
  region = "${var.region}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = ""
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = "${merge(var.default_tags, map(
    "Name", "${var.bucket_name}"
  ))}"
}
