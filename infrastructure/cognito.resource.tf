#Temporary varible to handle the different naming conventions of the Cognito user pools.
#Since we are importing them from a previous Terraform iteration of the enviornments, the environment listed in the name may not match the value of the current environment/workspace
#Use the values below to denote the difference. 
#If it is a new cognito pool and environment, then the value should match the workspace.
#If the cognito pool is being imported, then use the existing value

variable "cognito_pool_old_env" {
  default = {
    dev          = "dev2"
    test         = "test"
    test-account = "test1"
    qa           = "qa"
    prod         = "prod"
    dev-ft  = "dev-ft"
    test-ft = "test-ft"
  }
}

/* ==== BEGIN - Cognito Creation ==== */
# create pool
resource "aws_cognito_user_pool" "user_pool" {
  name                     = "ci-${var.cognito_pool_old_env[terraform.workspace]}-cognitoUserPool"
  auto_verified_attributes = ["email"]

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.cognito_pool_old_env[terraform.workspace]}-cognitoUserPool"
  ))}"


  admin_create_user_config = {
    allow_admin_create_user_only = "False"
    unused_account_validity_days = 7

    invite_message_template = {
      email_message = "Your username is {username} and temporary password is {####}. "
      email_subject = "Your temporary password"
      sms_message   = "Your username is {username} and temporary password is {####}. "
    }
  }

  password_policy = {
    minimum_length    = 8
    require_lowercase = 1
    require_uppercase = 1
    require_symbols   = 1
    require_numbers   = 1
  }

  verification_message_template = {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Your verification code is {####}. "
    email_subject        = "Your verification code"
  }

  lifecycle {
    ignore_changes = ["schema"]
  }

  schema = {
    name                = "bp"
    attribute_data_type = "String"
    mutable             = true
  }

  schema = {
    attribute_data_type = "String"
    name                = "email"
    mutable             = false
    required            = true
  }

  schema = {
    attribute_data_type = "String"
    name                = "ImpersonationRole"
    mutable             = true
  }

  schema = {
    attribute_data_type = "String"
    name                = "AgentId"
    mutable             = true
  }

  schema = {
    attribute_data_type = "String"
    name                = "AllowGuestSignIn"
    mutable             = true
  }

  lambda_config = {
    pre_sign_up                    = "${aws_lambda_function.autoConfirm.arn}"
    define_auth_challenge          = "${aws_lambda_function.defineAuth.arn}"
    verify_auth_challenge_response = "${aws_lambda_function.verifyAuth.arn}"
    create_auth_challenge          = "${aws_lambda_function.createAuth.arn}"
  }
}

output "lambda config" {
  value = "\n pre_sign_up = ${aws_lambda_function.autoConfirm.arn}\n define_auth_challenge = ${aws_lambda_function.defineAuth.arn}\n verify_auth_challenge_response = ${aws_lambda_function.verifyAuth.arn} \n create_auth_challenge = ${aws_lambda_function.createAuth.arn}"
}

#create client for managing the user pool
resource "aws_cognito_user_pool_client" "client" {
  name = "ci-${var.cognito_pool_old_env[terraform.workspace]}-userPoolClient"

  user_pool_id = "${aws_cognito_user_pool.user_pool.id}"

  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
  write_attributes    = ["email", "custom:bp"]
}

output "cognito_user_pool_client_id" {
  value = "${aws_cognito_user_pool_client.client.id}"
}

resource "aws_cognito_user_pool_client" "client_impersonation" {
  name = "ci-${var.cognito_pool_old_env[terraform.workspace]}-userPoolClient-Impersonation"

  user_pool_id = "${aws_cognito_user_pool.user_pool.id}"

  write_attributes = ["custom:bp", "phone_number", "custom:ImpersonationRole","custom:AgentId", "email"]
}

output "cognito_user_pool_client_impersonation_id" {
  value = "${aws_cognito_user_pool_client.client_impersonation.id}"
}

/* ==== BEGIN - Cognito Pool Lambda Function Creation ==== */
# for each of the lambda functions in the aws_cognito_user_pool.user_pool.lambda_config
# a policy must be added to the lambda function to allow the cognito resource to access the function
resource "aws_lambda_permission" "allow_cognito_define" {
  statement_id  = "ci-${var.env[terraform.workspace]}-allowDefine"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.defineAuth.function_name}"
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = "${aws_cognito_user_pool.user_pool.arn}"
}

resource "aws_lambda_permission" "allow_cognito_verify" {
  statement_id  = "ci-${var.env[terraform.workspace]}-allowVerify"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.verifyAuth.function_name}"
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = "${aws_cognito_user_pool.user_pool.arn}"
}

resource "aws_lambda_permission" "allow_cognito_create" {
  statement_id  = "ci-${var.env[terraform.workspace]}-allowCreate"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.createAuth.function_name}"
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = "${aws_cognito_user_pool.user_pool.arn}"
}

resource "aws_lambda_permission" "allow_cognito_auto_confirm" {
  statement_id  = "ci-${var.env[terraform.workspace]}-allowAutoConfirm"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.autoConfirm.function_name}"
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = "${aws_cognito_user_pool.user_pool.arn}"
}

output "cognito_user_pool" {
  value = "${aws_cognito_user_pool.user_pool.name}"
}

output "cognito_user_pool_arn" {
  value = "${aws_cognito_user_pool.user_pool.arn}"
}

output "cognito_user_pool_id" {
  value = "${aws_cognito_user_pool.user_pool.id}"
}

/* ===== END - Cognito Pool Creation ==== */

