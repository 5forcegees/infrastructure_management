/* ==== BEGIN - Notification - Preference Update SNS Topic Creation ==== */
module "notification-preference-update-topic" {
  source = "../modules/sns/topic"

  name = "ci-notification-preference-update-${var.env[terraform.workspace]}"

  application_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate        = 0
  lambda_success_feedback_sample_rate      = 0
  sqs_success_feedback_sample_rate         = 0
}

data "aws_iam_policy_document" "prefUp-sap-topic-policy" {
  policy_id = "${module.notification-preference-update-topic.sns_arn}"

  statement {
    sid    = "AllowSQSAccess"
    effect = "Allow"

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${module.commgateway-prefUp-sap.arn}",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${module.notification-preference-update-topic.sns_arn}",
      ]
    }
  }
}

data "aws_iam_policy_document" "prefUp-mb-topic-policy" {
  policy_id = "${module.notification-preference-update-topic.sns_arn}"

  statement {
    sid    = "AllowSQSAccess"
    effect = "Allow"

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${module.commgateway-prefUp-mb.arn}",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${module.notification-preference-update-topic.sns_arn}",
      ]
    }
  }
}

output "sns_notification_preference_update" {
  value = "${module.notification-preference-update-topic.sns_arn}"
}

/* ==== END - Notification - Preference Update SNS Topic Creation ==== */

/* ==== BEGIN - Commgateway - Service Relay SNS Topic Creation ==== */
module "commgateway-service-relay-topic" {
  source = "../modules/sns/topic"

  name = "ci-commgateway-service-relay-${var.env[terraform.workspace]}"

  application_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate        = 0
  lambda_success_feedback_sample_rate      = 0
  sqs_success_feedback_sample_rate         = 0
}

data "aws_iam_policy_document" "commgateway-service-relay-topic-policy" {
  policy_id = "${module.commgateway-service-relay-topic.sns_arn}"

  statement {
    sid    = "AllowSQSAccess"
    effect = "Allow"

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${module.commgateway-service-relay.arn}",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${module.commgateway-service-relay-topic.sns_arn}",
      ]
    }
  }
}

output "sns_commgateway_servicerelay" {
  value = "${module.commgateway-service-relay-topic.sns_arn}"
}

/* ==== END - Commgateway - Service Relay SNS Topic Creation ==== */

/* ==== BEGIN - Notification - Send Notification SNS Topic Creation ==== */
module "notification-send-notification-topic" {
  source = "../modules/sns/topic"

  name = "ci-notification-send-notification-${var.env[terraform.workspace]}"

  application_success_feedback_sample_rate = 0
  http_success_feedback_sample_rate        = 0
  lambda_success_feedback_sample_rate      = 0
  sqs_success_feedback_sample_rate         = 0
}

data "aws_iam_policy_document" "notification-send-notification-topic" {
  policy_id = "${module.notification-send-notification-topic.sns_arn}"

  statement {
    sid    = "AllowSQSAccess"
    effect = "Allow"

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${module.commgateway-message-intercept.arn}",
    ]

    principals = {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${module.notification-send-notification-topic.sns_arn}",
      ]
    }
  }
}

output "sns_notification_send_notification" {
  value = "${module.notification-send-notification-topic.sns_arn}"
}

/* ==== END - Notification - Send Notification SNS Topic Creation ==== */

/* ==== BEGIN - PrefUp SNS Subscription Creation ==== */
module "commgateway-prefUp-sap-subscription" {
  source = "../modules/sns/subscription/"

  topic_arn     = "${module.notification-preference-update-topic.sns_arn}"
  protocol      = "sqs"
  endpoint      = "${module.commgateway-prefUp-sap.arn}"
  filter_policy = "{\n  \"source-system\": [{\"anything-but\":\"sap\"}]\n}"
}

module "commgateway-prefUp-mb-subscription" {
  source = "../modules/sns/subscription/"

  topic_arn     = "${module.notification-preference-update-topic.sns_arn}"
  protocol      = "sqs"
  endpoint      = "${module.commgateway-prefUp-mb.arn}"
  filter_policy = "{\n  \"source-system\": [{\"anything-but\":\"messagebroadcast\"}]\n}"
}

module "commgateway-service-relay-subscription" {
  source = "../modules/sns/subscription/"

  topic_arn     = "${module.commgateway-service-relay-topic.sns_arn}"
  protocol      = "sqs"
  endpoint      = "${module.commgateway-service-relay.arn}"
  filter_policy = ""
}

module "commgateway-message-intercept-subscription" {
  source = "../modules/sns/subscription/"

  topic_arn     = "${module.notification-send-notification-topic.sns_arn}"
  protocol      = "sqs"
  endpoint      = "${module.commgateway-message-intercept.arn}"
  filter_policy = "{\n  \"subcategory\": [\"BB-1-01\", \"BB-1-03\", \"PA-1-01\", \"PA-1-02\",\"START-01-001\",\"START-01-002\",\"START-01-007\",\"START-01-008\",\"START-01-009\",\"START-01-009-01\",\"START-01-010\",\"START-01-011\",\"START-01-012\",\"STOP-01-001\",\"STOP-01-002\",\"STOP-01-005\",\"STOP-01-006\",\"STOP-01-008\",\"MOVE-01-001\"]\n}"
}

/* ==== END - PrefUp SNS Subscription Creation ==== */

