/* ==== BEGIN - ECS Task Role Creation ==== */
resource "aws_iam_role" "ecsTaskRole" {
  name = "ci-${var.env[terraform.workspace]}-ecsTaskRole"
  force_detach_policies = true

  assume_role_policy = "${data.aws_iam_policy_document.ecs_task_role_trust_relationship.json}"
}

data "aws_iam_policy_document" "ecs_task_role_trust_relationship" {
  policy_id = "ECSandBuildRoleTrustRelationship"

  statement {
    sid     = "ECSTrust"
    effect  = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals = {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com","ec2.amazonaws.com"]
    }
    principals = {
      type = "AWS"
      identifiers = ["arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"]
    }
  }
}

output "ecs_task_role_arn" {
  value = "${aws_iam_role.ecsTaskRole.arn}"
}

output "ecs_task_role_name" {
  value = "${aws_iam_role.ecsTaskRole.name}"
}

output "ecs_task_role_id" {
  value = "${aws_iam_role.ecsTaskRole.unique_id}"
}


# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "task-role" {
  role       = "${aws_iam_role.ecsTaskRole.name}"
  policy_arn = "${aws_iam_policy.ci-ecs-task-role-policy.arn}"
}

resource "aws_iam_policy" "ci-ecs-task-role-policy" {
  name        = "ci-${terraform.workspace}-ecs-task-role-policy"
  path        = "/"
  description = "Policy for ECS tasks"

  policy = "${data.aws_iam_policy_document.ecs_task_role_policy.json}" 
}

data "aws_iam_policy_document" "ecs_task_role_policy" {
  policy_id = "ci-${terraform.workspace}-ecs-task-role-policy"

  statement {
    sid = "S3"
    effect = "Allow"
    actions = [
      "s3:List*",
      "s3:Get*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid = "CloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid = "SQS"
    effect = "Allow"
    actions = [
      "sqs:Get*",
      "sqs:List*",
      "sqs:ReceiveMessage",
      "sqs:ChangeMessageVisibility*",
      "sqs:DeleteMessage*",
      "sqs:PurgeQueue",
      "sqs:SendMessage*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid = "ParameterStore"
    effect = "Allow"
    actions = [
      "ssm:GetParameter*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid = "SNS"
    effect = "Allow"
    actions = [
      "sns:Publish",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid = "Cognito"
    effect = "Allow"
    actions = [
      "cognito-idp:*",
    ]
    resources = [
      "*",
    ]
  }
}

/* ==== END - ECS Task Role Creation ==== */

