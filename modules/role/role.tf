# Create role
resource "aws_iam_role" "role" {
  name = "${var.role_name}"
  force_detach_policies = true

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "${var.role_service_type}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
