#TODO: Conditional logic for SG rules
/* ==== BEGIN - ECS Security Group and Security Group Rules ==== */
resource "aws_security_group" "ecs" {
  name        = "ci-${var.env[terraform.workspace]}-sg-ecs"
  description = "security group for the ecs instances"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"

  lifecycle {
    ignore_changes = ["description"]
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-sg-ecs"
  ))}"
}

output "ecs_security_group_id" {
  value     = "${aws_security_group.ecs.id}"
  sensitive = true
}

resource "aws_security_group_rule" "ecs_egress_to_alb" {
  security_group_id        = "${aws_security_group.ecs.id}"
  source_security_group_id = "${aws_security_group.alb_sg.id}"
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Outbound to ALB"
}

resource "aws_security_group_rule" "ecs_egress_https_to_alb" {
  security_group_id        = "${aws_security_group.ecs.id}"
  source_security_group_id = "${aws_security_group.alb_sg.id}"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  description              = "Outbound HTTPS to ALB"
}

resource "aws_security_group_rule" "alb_ingress_to_ecs" {
  security_group_id        = "${aws_security_group.ecs.id}"
  source_security_group_id = "${aws_security_group.alb_sg.id}"
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  description              = "Inbound from ALB"
}

/* Security Group rule to allow all outbound from ECS instance(s). */
resource "aws_security_group_rule" "ecs_allow_all_outbound" {
  security_group_id = "${aws_security_group.ecs.id}"
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

/* If required, the CIDR block variable should match the IP range for the VPC */
resource "aws_security_group_rule" "build_server_ingress_to_ecs" {
  security_group_id = "${aws_security_group.ecs.id}"
  type              = "ingress"
  to_port           = 80
  protocol          = "-1"
  from_port         = 80
  cidr_blocks       = ["10.128.1.0/24"]
  description       = "Inbound from Ubuntu build server"
}

resource "aws_security_group_rule" "alb_egress_to_ecs" {
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${aws_security_group.ecs.id}"
  type                     = "egress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  description              = "Outbound to ECS"
}

resource "aws_security_group_rule" "ecs_ingress_to_alb" {
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${aws_security_group.ecs.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Inbound from ECS"
}

resource "aws_security_group_rule" "ecs_inbound_to_redis" {
  security_group_id        = "${aws_security_group.redis_sg.id}"
  source_security_group_id = "${aws_security_group.ecs.id}"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  description              = "Inbound from ECS"
}

/* ==== END - ECS Security Group and Security Group Rules ==== */

