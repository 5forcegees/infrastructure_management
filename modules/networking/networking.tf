resource "aws_security_group" "alb" {
  name        = "ci-${var.env[terraform.workspace]}-sg-alb"
  description = "security group for alb"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-sg-alb"
  ))}"
}

resource "aws_security_group" "lambda_proxy" {
  name        = "ci-${var.env[terraform.workspace]}-sg-lambda-proxy"
  description = "security group for the lambda proxy function"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-sg-lambda-proxy"
  ))}"
}

resource "aws_security_group" "ecs" {
  name        = "ci-${var.env[terraform.workspace]}-sg-ecs"
  description = "security group for the ecs instances"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-sg-ecs"
  ))}"
}

resource "aws_security_group_rule" "lambda_to_alb" {
  security_group_id        = "${aws_security_group.lambda_proxy.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Outbound to ALB"
}

resource "aws_security_group_rule" "lambda_to_dns_tcp" {
  security_group_id = "${aws_security_group.lambda_proxy.id}"

  #source_security_group_id = "${aws_security_group.alb.id}"
  type        = "egress"
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  description = "Outbound to DNS via TCP"
  cidr_blocks = ["10.128.244.10/32"]
}

resource "aws_security_group_rule" "lambda_to_dns_udp" {
  security_group_id = "${aws_security_group.lambda_proxy.id}"
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  description       = "Outbound to DNS via UDP"
  cidr_blocks       = ["10.128.244.10/32"]
}

resource "aws_security_group_rule" "alb_from_lambda" {
  security_group_id        = "${aws_security_group.alb.id}"
  source_security_group_id = "${aws_security_group.lambda_proxy.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Inbound from Lambda Proxy"
}

resource "aws_security_group_rule" "alb_to_ecs" {
  security_group_id        = "${aws_security_group.alb.id}"
  source_security_group_id = "${aws_security_group.ecs.id}"
  type                     = "egress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  description              = "Outbound to ECS"
}

resource "aws_security_group_rule" "ecs_from_alb" {
  security_group_id        = "${aws_security_group.ecs.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  description              = "Inbound from ALB"
}

resource "aws_security_group_rule" "alb_from_ecs" {
  security_group_id        = "${aws_security_group.alb.id}"
  source_security_group_id = "${aws_security_group.ecs.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Inbound from ECS"
}

resource "aws_security_group_rule" "alb_ingress_to_ecs" {
  security_group_id        = "${aws_security_group.ecs.id}"
  source_security_group_id = "${aws_security_group.alb.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Outbound to ALB"
}

resource "aws_security_group_rule" "sap_ingress_to_alb" {
  security_group_id = "${aws_security_group.alb.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from SAP/PI"
  cidr_blocks       = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24"]
}
