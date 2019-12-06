/* ==== BEGIN - Third Party Gateway Creation ==== */
# Create rest api
resource "aws_api_gateway_rest_api" "ci_api_gw" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  name        = "ci-3rd-party-${var.env[terraform.workspace]}-apigw"
  description = "CI third party API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "proxy" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  path_part   = "{proxy+}"
  parent_id   = "${aws_api_gateway_rest_api.ci_api_gw.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
}

resource "aws_api_gateway_method" "proxy_method" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  rest_api_id      = "${aws_api_gateway_rest_api.ci_api_gw.id}"
  resource_id      = "${aws_api_gateway_resource.proxy.id}"
  http_method      = "ANY"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method_settings" "settings" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
  stage_name  = "${aws_api_gateway_deployment.deployment.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_integration" "proxy_method_integration" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  rest_api_id             = "${aws_api_gateway_rest_api.ci_api_gw.id}"
  resource_id             = "${aws_api_gateway_resource.proxy.id}"
  http_method             = "${aws_api_gateway_method.proxy_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.third-party-apigw-proxy.invoke_arn}"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = ["aws_api_gateway_integration.proxy_method_integration"]

  count = "${var.requires_third_party_gw[terraform.workspace]}"

  rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
  stage_name  = "${var.env[terraform.workspace]}"

  variables {
    # change below to trigger a stage deployment
    deployed_at = "1.1"
  }
}

resource "aws_api_gateway_api_key" "message_broadcast" {
  name = "message_broadcast"

  count = "${var.requires_third_party_gw[terraform.workspace]}"

  stage_key {
    rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
    stage_name  = "${aws_api_gateway_deployment.deployment.stage_name}"
  }
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  depends_on = ["aws_api_gateway_deployment.deployment"]

  count = "${var.requires_third_party_gw[terraform.workspace]}"

  name        = "ci-3rd-party-${var.env[terraform.workspace]}-usage-plan"
  description = "Usage plan for CI third party ${var.env[terraform.workspace]}"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
    stage  = "${var.env[terraform.workspace]}"
  }

  quota_settings {
    limit  = "5000"
    period = "DAY"
  }

  throttle_settings {
    rate_limit  = "10"
    burst_limit = "5"
  }
}

resource "aws_api_gateway_usage_plan_key" "message_broadcast_usage_plan" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  key_id        = "${aws_api_gateway_api_key.message_broadcast.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
}

