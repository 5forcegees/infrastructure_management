#Temporary varible to handle the different naming conventions of the Cognito user pools.
#Since we are importing them from a previous Terraform iteration of the enviornments, the environment listed in the name may not match the value of the current environment/workspace
#Use the values below to denote the difference.

#If it is a new cognito pool and environment, then the value should match the workspace.
#If the cognito pool is being imported, then use the existing value

variable "gateway_old_env" {
  default = {
    dev          = "dev2"
    test         = "test2"
    test-account = "test1"
    qa           = "qa"
    prod         = "prod"
    dev-ft  = "dev-ft"
    test-ft = "test-ft"
  }
}

variable "mobile_app_api_key_name" {
  default = {
    dev          = "mobile_app"
    test         = "mobile_app"
    test-account = "ci-test1-api-key"
    qa           = "mobile_app"
    prod         = "ci-prod-api-key"
    dev-ft  = "mobile_app"
    test-ft = "mobile_app"
  }
}

/* ==== BEGIN - API Gateway Creation ==== */
# pull the file template for initial gateway creation
data "template_file" "api_gateway_swagger" {
  template = "${file("../files/api_gateway.json")}"

  vars {
    account_number = "${var.account_number[terraform.workspace]}"
    env            = "${var.env[terraform.workspace]}"
  }
}

# Create rest api
resource "aws_api_gateway_rest_api" "ci_api_gw" {
  name        = "ci-${var.gateway_old_env[terraform.workspace]}-apigw"
  description = "CI API Gateway - ${var.gateway_old_env[terraform.workspace]}"
  body        = "${data.template_file.api_gateway_swagger.rendered}"

  lifecycle {
    ignore_changes = ["body", "name", "description"]
  }

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# deploy to the stage
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
  stage_name  = "${var.gateway_old_env[terraform.workspace]}"

  variables {
    # change below to trigger a stage deployment
    deployed_at = "1.0"
  }
}

output "api_gateway_invoke_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}

resource "aws_api_gateway_method_settings" "settings" {
  rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
  stage_name  = "${aws_api_gateway_deployment.deployment.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

# give the stage permission to access the private_404 lambda function
resource "aws_lambda_permission" "lambda_private_404_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${data.terraform_remote_state.infrastructure.lambda_private_404_function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.deployment.execution_arn}/*/*"
}

# give the stage permission to access the proxy lambda function on all resources and methods
resource "aws_lambda_permission" "lambda_proxy_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${data.terraform_remote_state.infrastructure.lambda_proxy_function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.deployment.execution_arn}/*/*"
}

# set up the api key
resource "aws_api_gateway_api_key" "mobile_app" {
  name = "${var.mobile_app_api_key_name[terraform.workspace]}"

  stage_key {
    rest_api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
    stage_name  = "${aws_api_gateway_deployment.deployment.stage_name}"
  }
}

# declare the usage plan to associate the api key to the stage
resource "aws_api_gateway_usage_plan" "usage_plan" {
  depends_on = ["aws_api_gateway_deployment.deployment"]

  name        = "ci-${var.gateway_old_env[terraform.workspace]}-usage-plan"
  description = "Usage plan for CI ${var.env[terraform.workspace]}"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.ci_api_gw.id}"
    stage  = "${aws_api_gateway_deployment.deployment.stage_name}"
  }

  quota_settings {
    limit  = "${var.quota_limit_per_day[terraform.workspace]}"
    period = "DAY"
  }

  throttle_settings {
    rate_limit  = "${var.throttling_rate_per_second[terraform.workspace]}"
    burst_limit = "${var.throttling_burst[terraform.workspace]}"
  }
}

resource "aws_api_gateway_usage_plan_key" "mobile_app_usage_plan" {
  key_id        = "${aws_api_gateway_api_key.mobile_app.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"

  lifecycle {
    ignore_changes = ["key_id"]
  }
}

/* ==== END - API Gateway Creation ==== */

