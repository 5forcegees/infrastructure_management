/* ==== BEGIN - S3 Variables ==== */
variable "legacy_bucket_name_prefix" {
  default = {
    dev     = "clientdev"
    dev-ft  = "client-dev-ft-"
    test-account = "client-test-account"
    test    = "client-test-"
    test-ft = "client-test-ft-"
    qa      = "clientqa"
    prod    = "client-prod-"
  }
}

variable "default_versioning_enabled" {
  default = "true"
}

/* ==== END - S3 Variables ==== */

/* ==== BEGIN - Assets Bucket Creation ==== */
module "assets" {
  source = "../modules/s3"

  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  bucket_name = "${var.legacy_bucket_name_prefix[terraform.workspace]}assets"

  versioning_enabled = "${var.default_versioning_enabled}"
}

/* ==== END - Assets Bucket Creation ==== */

/* ==== BEGIN - Correspondence Bucket Creation ==== */
module "correspondence" {
  source = "../modules/s3"

  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  bucket_name = "${var.legacy_bucket_name_prefix[terraform.workspace]}correspondence"

  versioning_enabled = "${var.default_versioning_enabled}"
}

output "s3_BucketName_Correspondence" {
  value = "${module.correspondence.bucket_name}"
}

/* ==== END - Correspondence Bucket Creation ==== */

/* ==== BEGIN - Statements Bucket ==== */
module "statements" {
  source = "../modules/s3"

  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  bucket_name = "${var.legacy_bucket_name_prefix[terraform.workspace]}statements"

  versioning_enabled = "${var.default_versioning_enabled}"
}


data "aws_iam_policy_document" "statements" {
  policy_id = "Policy1524619356576"

  statement {
    sid    = "Stmt1524619352569"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "${module.statements.arn}/*",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/AUTH-WebAppDev",
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-test-ecsTaskRole",
        "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:user/sa-aws-microsvc-qa",
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:user/transfer_file_user_mgrover",
        "arn:aws:iam::250469412150:user/client_com_service",
        "arn:aws:iam::143394471637:user/mgrover",
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:user/AWSDevUser",
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-dev-ecsTaskRole",
        "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-qa-ecsTaskRole",
        "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/sr-oei-etl-role"
      ]
    }
  }

  statement {
    sid    = "AllowBucketDiscovery"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketACL",
      "s3:PutLifecycleConfiguration",
      "s3:GetLifecycleConfiguration",
    ]

    resources = [
      "${module.statements.arn}",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-test-ecsTaskRole",
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:user/transfer_file_user_mgrover",
        "arn:aws:iam::250469412150:user/client_com_service",
        "arn:aws:iam::143394471637:user/mgrover",
        "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-dev-ecsTaskRole",
        "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-qa-ecsTaskRole",
        "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/sr-oei-etl-role" 
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${module.statements.bucket_name}"
  policy = "${data.aws_iam_policy_document.statements.json}"
}


output "s3_BucketName_Statements" {
  value = "${module.statements.bucket_name}"
}

/* ==== END - Statements Bucket Creation ==== */

/* ==== BEGIN - Batch Loader Bucket Creation ==== */
module "batch-loader" {
  source = "../modules/s3"

  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  bucket_name = "client-${var.env[terraform.workspace]}-batch-loader"

  versioning_enabled = "${var.default_versioning_enabled}"
}

data "aws_iam_policy_document" "file-available-topic-policy" {
  policy_id = "${module.batch-loader.bucket_name}"

  statement {
    sid    = "AllowSQSAccess"
    effect = "Allow"

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${module.loader-file-available.arn}",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition = {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${module.batch-loader.arn}",
      ]
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${module.batch-loader.bucket_name}"

  queue {
    id = "sqsNotify"

    queue_arn = "${module.loader-file-available.arn}"
    events    = ["s3:ObjectCreated:*"]
  }
}

/* ==== END - Batch Loader Bucket Creation ==== */

/* ==== BEGIN - Platform Bucket ==== */
module "platform_bucket" {
  source = "../modules/s3"

  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  bucket_name = "ci-${var.env[terraform.workspace]}-platform"

  versioning_enabled = "${var.default_versioning_enabled}"
}

output "s3_BucketName_platform" {
  value = "${module.platform_bucket.bucket_name}"
}

output "s3_BucketARN_platform" {
  value = "${module.platform_bucket.arn}"
}

/* ==== END - Platform Bucket Creation ==== */


/* === BEGIN - ALB Logging ==== */
module "alb_logs" {
  source = "../modules/s3"

  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  bucket_name = "ci-${var.env[terraform.workspace]}-alb-logs"

  versioning_enabled = "${var.default_versioning_enabled}"
}

data "aws_iam_policy_document" "alb_logging" {
  policy_id = "AWSConsole-AccessLogs-Policy"

  statement {
    sid     = "AllowALBLogging"
    effect  = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${module.alb_logs.arn}/microservices-alb/AWSLogs/${var.account_number[terraform.workspace]}/*",
      "${module.alb_logs.arn}/third-party-alb/AWSLogs/${var.account_number[terraform.workspace]}/*"
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::797873946194:root",
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "alb_bucket_policy" {
  bucket = "${module.alb_logs.bucket_name}"
  policy = "${data.aws_iam_policy_document.alb_logging.json}"
}

