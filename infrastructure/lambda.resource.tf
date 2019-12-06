/* ==== BEGIN Lambda - Third Party ==== */

/* ==== Setup Lambda Packages ==== */
data "archive_file" "lambda_proxy" {
  type        = "zip"
  source_file = "../files/apigw-proxy.js"
  output_path = "../files/ci-3rd-party-apigw-proxy.zip"
}

### create lambda proxy role 

resource "aws_iam_role" "lambda_proxy_role" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  name = "ci-3rd-party-lambdaVPCProxy"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda-proxy-role-vpc-policy" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  role       = "${aws_iam_role.lambda_proxy_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda-proxy-role-default-policy" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  role       = "${aws_iam_role.lambda_proxy_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

### create security group
resource "aws_security_group" "third-party-lambda-proxy" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  name        = "ci-3rd-party-sg-lambda-proxy"
  description = "security group for the third party lambda proxy function"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-3rd-party-sg-lambda-proxy"
  ))}"
}

resource "aws_security_group_rule" "lambda_to_alb" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id        = "${aws_security_group.third-party-lambda-proxy.id}"
  source_security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Outbound to ALB"
}

resource "aws_security_group_rule" "third_party_allow_private_outbound" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-lambda-proxy.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  description       = "Outbound to Client"
  cidr_blocks       = ["10.0.0.0/8"]
}


# give the stage permission to access the proxy lambda function on all resources and methods
resource "aws_lambda_permission" "lambda_proxy_permission" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.third-party-apigw-proxy.id}"
  principal     = "apigateway.amazonaws.com"

  # The slash * slash * portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_deployment.deployment.execution_arn}/*/*"
}

/* ==== Create Lambda Function -  ==== */
resource "aws_lambda_function" "third-party-apigw-proxy" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  filename         = "${data.archive_file.lambda_proxy.output_path}"
  function_name    = "ci-3rd-party-${var.env[terraform.workspace]}-apigw-proxy"
  role             = "${aws_iam_role.lambda_proxy_role.arn}"
  handler          = "apigw-proxy.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.lambda_proxy.output_base64sha256}"
  timeout          = 120

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-third-party-apigw-proxy"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]
    security_group_ids = ["${aws_security_group.third-party-lambda-proxy.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.third-party-alb.dns_name}"
      custom_cloudfront_token_key = "${data.aws_ssm_parameter.ThirdPartyTokenKey.value}",
      custom_cloudfront_token_value = "${data.aws_ssm_parameter.ThirdPartyTokenValue.value}"
    }
  }
}

data "aws_ssm_parameter" "TokenKey" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/CloudfrontAPIGateway/TokenKey"
}

data "aws_ssm_parameter" "TokenValue" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/CloudfrontAPIGateway/TokenValue"
}

data "aws_ssm_parameter" "ThirdPartyTokenKey" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/CloudfrontAPIGateway/ThirdPartyTokenKey"
  count = "${var.requires_third_party_gw[terraform.workspace]}"
}

data "aws_ssm_parameter" "ThirdPartyTokenValue" {
  name  = "/CI/MS/${var.env[terraform.workspace]}/CloudfrontAPIGateway/ThirdPartyTokenValue"
  count = "${var.requires_third_party_gw[terraform.workspace]}"
}

/* ==== END Lambda - Third Party ==== */

/* ==== BEGIN Lambda - API Gateway Proxy ==== */
data "archive_file" "lambda_apigw_proxy" {
  type        = "zip"
  source_file = "../files/apigw-proxy.js"
  output_path = "../files/apigw-proxy.zip"
}

resource "aws_lambda_function" "apigw_proxy" {
  filename         = "${data.archive_file.lambda_apigw_proxy.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-apigw-proxy"
  role             = "${aws_iam_role.lambda_vpc_proxy_role.arn}"
  handler          = "apigw-proxy.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.lambda_apigw_proxy.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-apigw-proxy"),
    map("AWS_Product_Type", "lambda"))}"

  timeout = 120

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]
    security_group_ids = ["${aws_security_group.lambda_proxy.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.alb.dns_name}"
      custom_cloudfront_token_key = "${data.aws_ssm_parameter.TokenKey.value}",
      custom_cloudfront_token_value = "${data.aws_ssm_parameter.TokenValue.value}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

/* ==== APIGW PROXY CURRENTLY CONTAINS PW IN LOGS ==== */
/* ==== TODO: Only uncomment when remediated ====*/
/*
module "apigw_proxy_logging" {
  source = "../modules/cloudwatch/logging-lambda"

  env           = "${var.env[terraform.workspace]}"
  region        = "${var.region}"
  default_tags  = "${var.default_tags}"

  log_group_name          = "/aws/lambda/${aws_lambda_function.apigw_proxy.function_name}"
  source_lambda_name      = "apigw_proxy"
  splunk_forwarder_lambda = "${aws_lambda_function.splunkForwarder.arn}"
  log_group_retention     = "${var.log_group_retention[terraform.workspace]}"
}
*/

/* ==== BEGIN Lambda - API Proxy IAM ==== */
resource "aws_iam_role" "lambda_vpc_proxy_role" {
  name = "ci-${var.env[terraform.workspace]}-lambdaVPCProxyRole"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaTrust"
    }
  ]
}
EOF
}

# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "vpc_access_to_lambdaVPCProxy" {
  role       = "${aws_iam_role.lambda_vpc_proxy_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# attach basic execution policy to role
resource "aws_iam_role_policy_attachment" "basic_execution_to_lambdaVPCProxy" {
  role       = "${aws_iam_role.lambda_vpc_proxy_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#TODO: Add conditional logic for security group rules
/* ==== BEGIN - Lambda Proxy Security Group ==== */
resource "aws_security_group" "lambda_proxy" {
  name        = "ci-${var.env[terraform.workspace]}-sg-lambda-proxy"
  description = "security group for the lambda proxy function"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-sg-lambda-proxy-${var.env[terraform.workspace]}"),
    map("AWS_Product_Type", "sg"))}"
}

resource "aws_security_group_rule" "lambda_egress_to_alb" {
  security_group_id        = "${aws_security_group.lambda_proxy.id}"
  source_security_group_id = "${aws_security_group.alb_sg.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Outbound to ALB"
}

resource "aws_security_group_rule" "lambda_proxy_allow_private_outbound" {
  security_group_id = "${aws_security_group.lambda_proxy.id}"

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  description       = "Outbound to Client"
  cidr_blocks       = ["10.0.0.0/8"]
}


output "lambda_proxy_function_name" {
  value = "${aws_lambda_function.apigw_proxy.function_name}"
}

/* ==== END Lambda - API Gateway Proxy ==== */

/* ==== BEGIN Cognito Trigger Role - shared by lambda functions that interact with Cognito ==== */

resource "aws_iam_role" "lambda_cognito_trigger_role" {
  name = "ci-${var.env[terraform.workspace]}-lambdaCognitoTrigger"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaTrust"
    }
  ]
}
EOF
}

# attach basic execution policy to role
resource "aws_iam_role_policy_attachment" "basic_execution_to_lambda_cognito_role" {
  role       = "${aws_iam_role.lambda_cognito_trigger_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "vpc_access_to_lambdaCognitoTrigger" {
  role       = "${aws_iam_role.lambda_cognito_trigger_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

/* ==== END Cognito Trigger Role ==== */

/* ==== BEGIN Lambda - Private Routes 404 ==== */
data "archive_file" "private_404" {
  type        = "zip"
  source_file = "../files/private_routes.js"
  output_path = "../files/private_routes.zip"
}

resource "aws_lambda_function" "private_route" {
  filename         = "${data.archive_file.private_404.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-private-404"
  role             = "${aws_iam_role.private_route_role.arn}"
  handler          = "private_routes.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.private_404.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-private-404"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]
    security_group_ids = ["${aws_security_group.lambda_proxy.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.alb.dns_name}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

/* ==== BEGIN - Private Route IAM ==== */
resource "aws_iam_role" "private_route_role" {
  name = "ci-${var.env[terraform.workspace]}-private_route_role"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaTrust"
    }
  ]
}
EOF
}

# attach basic execution policy to role
resource "aws_iam_role_policy_attachment" "basic_execution_to_private_route_role" {
  role       = "${aws_iam_role.private_route_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "vpc_access_to_private_route_role" {
  role       = "${aws_iam_role.private_route_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

module "private_route_logging" {
  source = "../modules/cloudwatch/logging-lambda"

  env                 = "${var.env[terraform.workspace]}"
  region              = "${var.region}"
  default_tags        = "${var.default_tags}"

  log_group_name          = "/aws/lambda/${aws_lambda_function.private_route.function_name}"
  source_lambda_name      = "private_route"
  splunk_forwarder_lambda = "${aws_lambda_function.splunkForwarder.arn}"
  log_group_retention     = "${var.log_group_retention[terraform.workspace]}"
}

output "lambda_private_404_function_name" {
  value = "${aws_lambda_function.private_route.function_name}"
}

/* ==== END Lambda - Private Routes 404 ==== */

/* ==== BEGIN Lambda - verifyAuth ==== */
data "archive_file" "lambda_verifyAuth" {
  type        = "zip"
  source_file = "../files/verifyAuth.js"
  output_path = "../files/verifyAuth.zip"
}

resource "aws_lambda_function" "verifyAuth" {
  filename         = "${data.archive_file.lambda_verifyAuth.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-verifyAuth"
  role             = "${aws_iam_role.lambda_cognito_trigger_role.arn}"
  handler          = "verifyAuth.handler"
  runtime          = "nodejs6.10"
  timeout          = 10
  source_code_hash = "${data.archive_file.lambda_verifyAuth.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-verifyAuth"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]

    security_group_ids = ["${aws_security_group.ecs.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.alb.dns_name}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

#Removing Logging due to sensitive data (email, bp)
/*
module "verifyAuth_logging" {
  source = "../modules/cloudwatch/logging-lambda"

  env                 = "${var.env[terraform.workspace]}"
  region              = "${var.region}"
  default_tags        = "${var.default_tags}"

  log_group_name          = "/aws/lambda/ci-${var.env[terraform.workspace]}-verifyAuth"
  source_lambda_name      = "verifyAuth"

  splunk_forwarder_lambda = "${aws_lambda_function.splunkForwarder.arn}"
  log_group_retention     = "${var.log_group_retention[terraform.workspace]}"
}
*/

/* ==== END Lambda - verifyAuth ==== */

/* ==== BEGIN Lambda - createAuth ==== */
data "archive_file" "lambda_createAuth" {
  type        = "zip"
  source_file = "../files/createAuth.js"
  output_path = "../files/createAuth.zip"
}

resource "aws_lambda_function" "createAuth" {
  filename         = "${data.archive_file.lambda_createAuth.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-createAuth"
  role             = "${aws_iam_role.lambda_cognito_trigger_role.arn}"
  handler          = "createAuth.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.lambda_createAuth.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-createAuth"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]

    security_group_ids = ["${aws_security_group.alb_sg.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.alb.dns_name}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

#Removing Logging due to sensitive data (email, bp)
/*
module "createAuth_logging" {
  source = "../modules/cloudwatch/logging-lambda"

  env          = "${var.env[terraform.workspace]}"
  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  log_group_name          = "/aws/lambda/ci-${var.env[terraform.workspace]}-createAuth"
  source_lambda_name      = "createAuth"

  splunk_forwarder_lambda = "${aws_lambda_function.splunkForwarder.arn}"
  log_group_retention     = "${var.log_group_retention[terraform.workspace]}"
}
*/

/* ==== END Lambda - createAuth ==== */

/* ==== BEGIN Lambda - defineAuth ==== */
data "archive_file" "lambda_defineAuth" {
  type        = "zip"
  source_file = "../files/defineAuth.js"
  output_path = "../files/defineAuth.zip"
}

resource "aws_lambda_function" "defineAuth" {
  filename         = "${data.archive_file.lambda_defineAuth.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-defineAuth"
  role             = "${aws_iam_role.lambda_cognito_trigger_role.arn}"
  handler          = "defineAuth.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.lambda_defineAuth.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-defineAuth"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]

    security_group_ids = ["${aws_security_group.alb_sg.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.alb.dns_name}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

#Removing Logging due to sensitive data (email, bp)
/*
module "defineAuth_logging" {
  source = "../modules/cloudwatch/logging-lambda"

  env                 = "${var.env[terraform.workspace]}"
  region       = "${var.region}"
  default_tags = "${var.default_tags}"

  log_group_name          = "/aws/lambda/ci-${var.env[terraform.workspace]}-defineAuth"
  source_lambda_name      = "defineAuth"

  splunk_forwarder_lambda = "${aws_lambda_function.splunkForwarder.arn}"
  log_group_retention     = "${var.log_group_retention[terraform.workspace]}"
}
*/

/* ==== END Lambda - defineAuth ==== */

/* ==== BEGIN Lambda - autoConfirm ==== */
data "archive_file" "lambda_autoConfirm" {
  type        = "zip"
  source_file = "../files/autoConfirm.js"
  output_path = "../files/autoConfirm.zip"
}

resource "aws_lambda_function" "autoConfirm" {
  filename         = "${data.archive_file.lambda_autoConfirm.output_path}"

  function_name    = "ci-${var.env[terraform.workspace]}-autoConfirm"
  role             = "${aws_iam_role.lambda_cognito_trigger_role.arn}"
  handler          = "autoConfirm.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.lambda_autoConfirm.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-autoConfirm"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]

    security_group_ids = ["${aws_security_group.alb_sg.id}"]
  }

  environment {
    variables = {
      ALB_URL = "${aws_alb.alb.dns_name}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

module "autoConfirm_logging" {
  source = "../modules/cloudwatch/logging-lambda"

  env                 = "${var.env[terraform.workspace]}"
  region              = "${var.region}"
  default_tags        = "${var.default_tags}"

  log_group_name          = "/aws/lambda/ci-${var.env[terraform.workspace]}-autoConfirm"
  source_lambda_name      = "autoConfirm"

  splunk_forwarder_lambda = "${aws_lambda_function.splunkForwarder.arn}"
  log_group_retention     = "${var.log_group_retention[terraform.workspace]}"
}

/* ==== END Lambda - autoConfirm ==== */

/* ==== BEGIN Lambda - Splunk Log Forwarder ==== */
data "aws_ssm_parameter" "splunk_hec_token" {
  name = "/CI/MS/${var.env[terraform.workspace]}/Platform/Splunk/HEC_Token"
}

data "aws_ssm_parameter" "splunk_hec_url" {
  name = "/CI/MS/${var.env[terraform.workspace]}/Platform/Splunk/HEC_URL"
}

data "archive_file" "splunk_forwarder" {
  type        = "zip"
  source_file = "../files/splunk_log_forwarder.js"
  output_path = "../files/splunk_log_forwarder.zip"
}

resource "aws_lambda_function" "splunkForwarder" {
  filename         = "${data.archive_file.splunk_forwarder.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-splunk-log-forwarder"
  role             = "${aws_iam_role.lambda_splunk_forwarding_role.arn}"
  handler          = "splunk_log_forwarder.handler"
  runtime          = "nodejs6.10"
  source_code_hash = "${data.archive_file.splunk_forwarder.output_base64sha256}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-splunk-log-forwarder"),
    map("AWS_Product_Type", "lambda"))}"

  vpc_config {
    subnet_ids         = ["${var.subnet_ids[terraform.workspace]}"]
    security_group_ids = ["${aws_security_group.alb_sg.id}"]
  }

  environment {
    variables = {
      SPLUNK_HEC_TOKEN = "${data.aws_ssm_parameter.splunk_hec_token.value}"
      SPLUNK_HEC_URL   = "${data.aws_ssm_parameter.splunk_hec_url.value}"
    }
  }
}

/* ==== BEGIN - Splunk Log Forwarder IAM ==== */
resource "aws_iam_role" "lambda_splunk_forwarding_role" {
  name = "ci-${var.env[terraform.workspace]}-splunkForwardingRole"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaTrust"
    }
  ]
}
EOF
}

# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "vpc_access_to_splunkForwardingRole" {
  role       = "${aws_iam_role.lambda_splunk_forwarding_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Attach default lambda policy to role
resource "aws_iam_role_policy_attachment" "basic_execution_to_splunkForwardingRole" {
  role       = "${aws_iam_role.lambda_splunk_forwarding_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

output "lambda_splunkForwarder_arn" {
  value = "${aws_lambda_function.splunkForwarder.arn}"
}

output "lambda_splunkForwarder_name" {
  value = "${aws_lambda_function.splunkForwarder.function_name}"
}

/* ==== BEGIN Lambda - PAX ECS Throttling ==== */
data "archive_file" "lambda_ecs_throttling" {
  type        = "zip"
  source_file = "../files/ecs_throttling.py"
  output_path = "../files/ecs_throttling.zip"
}

resource "aws_lambda_function" "ecs_throttling_lambda" {
  filename         = "${data.archive_file.lambda_ecs_throttling.output_path}"
  function_name    = "ci-${var.env[terraform.workspace]}-ecs-throttling"
  role             = "${aws_iam_role.ecs_throttling_role.arn}"
  handler          = "ecs_throttling.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${data.archive_file.lambda_ecs_throttling.output_base64sha256}"
  timeout          = 10

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-ecs-throttling"),
    map("AWS_Product_Type", "lambda"))}"

  environment {
    variables = {
      CLEANUP_TIME_DAYS                      = "${var.ecs_throttling_cleanup_time_days[terraform.workspace]}"
      ENV_NAME                               = "${var.env[terraform.workspace]}"
      FAILURE_THROTTLING_NOTIFY_TIMEOUT_MINS = "${var.ecs_throttling_fail_notify_timeout[terraform.workspace]}"
      FAILURE_THROTTLING_SNS                 = "${var.ecs_throttling_sns_topic[terraform.workspace]}"
      FAILURE_THROTTLING_SPARK_BOT           = "${var.ecs_throttling_spark_bot[terraform.workspace]}"
      FAILURE_THROTTLING_SPARK_ROOM          = "${var.ecs_throttling_spark_room[terraform.workspace]}"
      FAILURE_THROTTLING_SPARK_ROOM_DETAILS  = "${var.ecs_throttling_spark_room_details[terraform.workspace]}"
      MAX_FAIL_THRESH                        = "${var.ecs_throttling_fail_thresh[terraform.workspace]}"
      MAX_FAIL_TIME_MINS                     = "${var.ecs_throttling_fail_time_thresh[terraform.workspace]}"
    }
  }
}

/* ==== create ecs throttling role ==== */
resource "aws_iam_role" "ecs_throttling_role" {
  name = "ci-${var.env[terraform.workspace]}-ecsThrottlingRole"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaTrust"
    }
  ]
}
EOF
}

# attach basic execution policy to role
resource "aws_iam_role_policy_attachment" "basic_execution_to_ecs_throttling_lambda" {
  role       = "${aws_iam_role.ecs_throttling_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "throttling_specific_perms_to_ecs_throttling_lambda" {
  role       = "${aws_iam_role.ecs_throttling_role.name}"
  policy_arn = "${aws_iam_policy.ci-ecs-throttling-role-policy.arn}"
}

resource "aws_iam_policy" "ci-ecs-throttling-role-policy" {
  name        = "ci-${var.env[terraform.workspace]}-ecs-throttling-role-policy"
  path        = "/"
  description = "Policy for ECS Throttling Role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowDynamoDBRW",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:GetRecords",
                "dynamodb:PutItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CloudwatchLogs",
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Sid": "PublishSNS",
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": "*"
        },
 	{
            "Sid": "GetParameters",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

/* ==== END Lambda - PAX ECS Throttling ==== */

