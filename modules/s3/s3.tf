resource "aws_s3_bucket" "s3" {
  bucket = "${var.bucket_name}"

  acl    = "private"
  region = "${var.region}"

  versioning {
    enabled = "${var.versioning_enabled}"
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
