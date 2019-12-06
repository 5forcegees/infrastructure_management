data "aws_iam_policy_document" "platform_policy" {

  policy_id = "Policy1524619356576"

  statement {
    sid    = "AllowBuildRoleRW"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "${data.terraform_remote_state.infrastructure.s3_BucketARN_platform}/*",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "${var.workspace_iam_roles[terraform.workspace]}"
      ]
    }
  }

  statement {
    sid    = "AllowNetworkingRoleWrite"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "${data.terraform_remote_state.infrastructure.s3_BucketARN_platform}/network-troubleshooting/results/*",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "${aws_iam_role.ecsTroubleshootingRole.arn}"
      ]
    }
  }
  
  statement {
    sid    = "AllowResultsRead"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
    ]

    resources = [
      "${data.terraform_remote_state.infrastructure.s3_BucketARN_platform}/network-troubleshooting/results/*",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "${aws_iam_role.ecsTroubleshootingRole.arn}",
        "${data.terraform_remote_state.infrastructure.ecs_task_role_id}"
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
      "${data.terraform_remote_state.infrastructure.s3_BucketARN_platform}",
    ]

    principals = {
      type = "AWS"

      identifiers = [
        "${var.workspace_iam_roles[terraform.workspace]}"
      ]
    }
  }
}


resource "aws_s3_bucket_policy" "platform_bucket_policy" {
  bucket = "${data.terraform_remote_state.infrastructure.s3_BucketName_platform}"
  policy = "${data.aws_iam_policy_document.platform_policy.json}"
}
