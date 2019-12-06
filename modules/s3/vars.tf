/* ==== general vars ==== */
variable "region" {}

variable "default_tags" {
  type = "map"
}

/* ==== s3 vars ==== */
variable "bucket_name" {}

variable "versioning_enabled" {}
