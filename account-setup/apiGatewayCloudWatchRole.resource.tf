
resource "aws_iam_role" "api_gateway_cloudwatch_role" {
  name = "ci-apigateway-logs-${var.region}"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "APIGatewayTrustRelationship"
    }
  ]
}
EOF
}

# attach PushToCloudWatchLogs policy to role
resource "aws_iam_role_policy_attachment" "api_gateway_cloudwatch_role" {
  role       = "${aws_iam_role.api_gateway_cloudwatch_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "enable_cloudwatch_logging" {
  cloudwatch_role_arn = "${aws_iam_role.api_gateway_cloudwatch_role.arn}"
}

output "api_gateway_cloudwatch_arn" {
  value = "${aws_iam_role.api_gateway_cloudwatch_role.arn}"
}
