/* ==== ALB Specific Variables ==== */
variable "enable_alb_logging" {
  default = {
    dev          = false
    test         = false
    test-account = false
    qa           = true
    prod         = true
    dev-ft  = false
    test-ft = false 
  }
}

variable "legacy_target_instance1" {
  default = {
    dev          = ""
    test         = "i-08b931e1505fb1652"
    test-account = ""
    qa           = "i-0df206e37b5a447e5"
    prod         = "i-070131deb836ead2d"
    dev-ft  = ""
    test-ft = "i-08b931e1505fb1652"
  }
}

variable "legacy_target_instance2" {
  default = {
    dev          = ""
    test         = "i-0dbda6e659b16b7af"
    test-account = ""
    qa           = "i-05abc93a5c1795556"
    prod         = "i-0dac27ac7076c0fbc"
    dev-ft  = ""
    test-ft = "i-0dbda6e659b16b7af"
  }
}

variable "legacy_target_instance3" {
  default = {
    dev          = ""
    test         = ""
    test-account = ""
    qa           = "i-0f75acad72c5d3058"
    prod         = ""
    dev-ft  = ""
    test-ft = ""

  }
}

variable "legacy_target_instances_cidr" {
  default = {
    dev          = [""]
    test         = ["10.128.152.0/21", "10.128.40.0/21"]
    qa           = ["10.128.40.0/21"]
    prod         = ["10.128.104.0/21"]
    dev-ft  = [""]
    test-ft = ["10.128.152.0/21", "10.128.40.0/21"]
  }
}

variable "third_party_alb_url" {
  default = {
    dev          = "internal-ci-3rd-party-qa-alb-845329954.us-west-2.elb.amazonaws.com"
    test         = ""
    test-account = "internal-ci-3rd-party-qa-alb-845329954.us-west-2.elb.amazonaws.com"
    qa           = ""
    prod         = ""
    dev-ft  = "internal-ci-3rd-party-qa-alb-845329954.us-west-2.elb.amazonaws.com"
    test-ft = "internal-ci-3rd-party-test-alb-1719055820.us-west-2.elb.amazonaws.com"
  }
}

variable "alb_ssl_cert_arn" {
  default = {
    dev		 = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/05710987-2cc7-440e-bc6d-62003e418dda"
    test         = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/eba351e2-61b3-4ff1-a6b2-4e96532e15b8"
    test-account = "arn:aws:acm:us-west-2:###CENSORED-TEST-ACCOUNT-NUMBER###:certificate/29ada9ff-8ad8-4282-b200-a670ac6f91a1"
    qa		 = "arn:aws:acm:us-west-2:###CENSORED-QA-ACCOUNT-NUMBER###:certificate/4d7ac27c-2d3b-4808-a513-6ea6ae5123e1"
    prod         = "arn:aws:acm:us-west-2:941964952328:certificate/084a3254-cd05-444b-832e-aa2cbe327340"
    dev-ft  = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/2f424b04-660d-4fd6-8657-66e154ed6143"
    test-ft = "arn:aws:acm:us-west-2:###CENSORED-DEV-ACCOUNT-NUMBER###:certificate/211b1115-6af8-401e-81c4-aae0141a58f8"
  }
}

variable "sitecore_sgs" {
  default = {
    dev          = ["sg-c9caf5b5"]
    test         = ["###CENSORED-QA-ACCOUNT-NUMBER###/sg-036a057f"]
    test-account = ["###CENSORED-QA-ACCOUNT-NUMBER###/sg-036a057f"]
    qa           = ["sg-036a057f", "sg-d1a08daf"]
    prod         = ["sg-014a45eb35dbe2515", "sg-0d85d0162bb2df2b0", "sg-03f232380d375c8ca", "sg-0674d64114a5f7419"]
    dev-ft  = ["sg-c9caf5b5"]
    test-ft = ["###CENSORED-QA-ACCOUNT-NUMBER###/sg-036a057f"]
  }
}

#TODO: Validate SAP CIDRS
#TODO: Currently allowing HTTP and HTTPS, HTTP should be removed
variable "sap_cidr" {
  default = {
    dev          = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24"]
    test         = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24"]
    test-account = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24"]
    qa           = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24","10.141.50.0/24", "10.141.64.0/24"]
    prod         = []
    dev-ft  = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24"]
    test-ft = ["10.41.0.0/16", "10.41.50.0/24", "10.41.22.0/24"] 
  }
}

variable "client_domain_cidr" {
  default = {
    dev          = ["170.192.0.0/16"]
    test         = ["170.192.0.0/16"]
    test-account = ["170.192.0.0/16"] 
    qa           = ["170.192.0.0/16"]
    prod         = []
    dev-ft  = ["170.192.0.0/16"]
    test-ft = ["170.192.0.0/16"]
  }
}

variable "perf_test_cidr" {
  default = {
    dev          = []
    test         = ["170.192.216.120/32", "10.141.249.0/24"]
    test-account = ["170.192.216.120/32", "10.141.249.0/24"]
    qa           = ["170.192.216.120/32", "10.141.249.0/24"]
    prod         = []
    dev-ft  = []
    test-ft = ["170.192.216.120/32", "10.141.249.0/24"]
  }
}

variable "internal_user_cidr" {
  default = {
    dev          = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16"]
    test         = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16"]
    test-account = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16"]
    qa           = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16"]
    prod         = ["10.141.0.20/32","10.141.0.84/32","10.41.0.20/32","10.41.0.84/32"]
    dev-ft  = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16"]
    test-ft = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16"]
  }
}

variable "vpc_cidr" {
  default = {
    dev          = ["10.128.152.0/21"]
    test         = ["10.128.152.0/21"]
    test-account = []
    qa           = []
    prod         = []
    dev-ft  = ["10.128.152.0/21"]
    test-ft = ["10.128.152.0/21"]
  }
}

#Only providing HTTPS access for these CIDRS
variable "pi_sap_cidr" {
  default = {
    dev          = ["10.141.50.0/24", "10.141.64.0/24", "10.141.64.185/32", "10.141.64.183/32", "10.141.53.57/32", "10.141.53.61/32"]
    test         = ["10.141.50.0/24", "10.141.64.0/24", "10.141.64.185/32", "10.141.64.183/32", "10.141.53.57/32", "10.141.53.61/32"]
    test-account = ["10.141.50.0/24", "10.141.64.0/24", "10.141.64.185/32", "10.141.64.183/32", "10.141.53.57/32", "10.141.53.61/32"]
    qa           = ["10.141.64.93/32", "10.141.64.135/32", "10.141.64.91/32", "10.141.64.139/32", "10.141.64.94/32", "10.141.64.213/32", "10.141.53.57/32", "10.141.53.61/32", "10.141.64.185/32", "10.141.64.183/32"]
    prod         = ["10.141.22.136/32","10.141.22.97/32","10.141.22.216/32","10.141.22.214/32","10.141.22.98/32","10.141.22.96/32","10.141.22.95/32","10.141.22.104/32"]
    dev-ft  = ["10.141.50.0/24", "10.141.64.0/24", "10.141.64.185/32", "10.141.64.183/32", "10.141.53.57/32", "10.141.53.61/32"]
    test-ft = ["10.141.50.0/24", "10.141.64.0/24", "10.141.64.185/32", "10.141.64.183/32", "10.141.53.57/32", "10.141.53.61/32"]
  }
}


#TODO: Validate SAP CIDRS
variable "client_admin_cidr" {
  default = {
    dev          = []
    test         = ["10.141.12.29/32"] 
    test-account = ["10.141.12.29/32"] 
    qa           = ["10.141.12.29/32"]
    prod         = ["10.141.12.28/32"]
    dev-ft  = []
    test-ft = ["10.141.12.29/32"]
  }
}

variable "rcm_onprem_servers" {
  default = {
    dev          = []
    test         = []
    test-account = []
    qa           = []
    prod         = ["172.31.10.56/32","172.31.10.57/32","172.31.10.58/32","172.31.10.59/32","172.31.10.60/32","10.47.12.17/32","10.47.12.81/32","172.31.18.77/32","172.31.18.78/32","172.31.18.79/32","172.31.18.80/32","172.31.18.81/32","170.192.152.158/32"]
    dev-ft  = []
    test-ft = []
  }
}

variable "vivr_sg" {
  default = {
    dev          = []
    test         = ["sg-0f206e70e39fb2d2b"]
    test-account = []
    qa           = []
    prod         = []
    dev-ft  = []
    test-ft = ["sg-0f206e70e39fb2d2b"]
  }
}

variable "jacada_app_sgs" {
	default = {
		dev		= []
		dev-ft	= []
		test	= []
		test-ft	= []
		qa		= ["sg-02781b0c7cda878b9"]
		prod	= []
	}
}

variable "aws_dcdr_ec2_sgs" {
	default = {
		dev		= []
		dev-ft	= []
		test	= []
		test-ft	= []
		qa		= ["sg-0773c8b5f1cfeb916"]
		prod	= ["sg-0b0cc54ee18ff5fa8"]
	}
}

/* ==== BEGIN - ALB Creation ==== */
#TODO: Add conditional logic for security group rules
resource "aws_alb" "alb" {
  depends_on = ["aws_s3_bucket_policy.alb_bucket_policy"]

  name               = "ci-${var.env[terraform.workspace]}-alb"
  internal           = "true"
  security_groups    = ["${aws_security_group.alb_sg.id}"]
  subnets            = ["${var.subnet_ids[terraform.workspace]}"]
  load_balancer_type = "application"
  idle_timeout       = 110

  access_logs {
    bucket  = "${module.alb_logs.bucket_name}"
    prefix  = "microservices-alb"
    enabled = "${var.enable_alb_logging[terraform.workspace]}"
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-alb"
  ))}"
}

# Create default target group
resource "aws_alb_target_group" "tg" {
  name                 = "ci-${var.env[terraform.workspace]}-alb-default-tg"
  port                 = 5000
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id[terraform.workspace]}"
  deregistration_delay = 60

  health_check = {
    path    = "/healthcheck"
    matcher = 200
    unhealthy_threshold = 2
    timeout = 3
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-alb-default-tg"
  ))}"
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.tg.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "listener_ssl" {
  count = "${length(var.alb_ssl_cert_arn[terraform.workspace])>0 ? 1 : 0}"

  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.alb_ssl_cert_arn[terraform.workspace]}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.tg.arn}"
  }
}

output "alb_listener_arn" {
  value = "${aws_alb_listener.listener.arn}"
}

output "alb_listener_ssl_arn" {
  value = "${aws_alb_listener.listener_ssl.arn}"
}

output "alb_suffix" {
  value = "${aws_alb.alb.arn_suffix}"
}

output "alb_dns" {
  value = "${aws_alb.alb.dns_name}"
}

/* ==== END - ALB Creation ==== */

/* ==== BEGIN - ALB Security Group Creation ==== */
resource "aws_security_group" "alb_sg" {
  name        = "ci-${var.env[terraform.workspace]}-sg-alb"
  description = "security group for alb"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-sg-alb"
  ))}"
}

/* RCM Should only connect via HTTPS -- removing HTTP (80) rule */
resource "aws_security_group_rule" "inbound_from_rcm_https" {
  security_group_id  = "${aws_security_group.alb_sg.id}"
  cidr_blocks        = "${var.rcm_onprem_servers[terraform.workspace]}"
  type               = "ingress"
  from_port          = 443
  to_port            = 443
  protocol           = "tcp"
  description        = "Inbound from RCM onprem"

  count              = "${length(var.rcm_onprem_servers[terraform.workspace]) >=1 ? 1 : 0}"
}

resource "aws_security_group_rule" "inbound_from_vivr_http" {
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${element(var.vivr_sg[terraform.workspace], count.index)}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Inbound from VIVR"

  count = "${length(var.vivr_sg[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "inbound_from_vivr_https" {
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${element(var.vivr_sg[terraform.workspace], count.index)}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  description              = "Inbound from VIVR"

  count = "${length(var.vivr_sg[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "alb_allow_private_outbound" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  description       = "Outbound to Internal CIDR Block"
  cidr_blocks       = ["10.0.0.0/8"]
}


resource "aws_security_group_rule" "lambda_ingress_to_alb" {
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${aws_security_group.lambda_proxy.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Inbound from Lambda Proxy"
}

resource "aws_security_group_rule" "lambda_https_ingress_to_alb" {
  security_group_id        = "${aws_security_group.alb_sg.id}"
  source_security_group_id = "${aws_security_group.lambda_proxy.id}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  description              = "Inbound HTTPS from Lambda Proxy"
}

/* Security Group rule to allow inbound traffic from the AWS VPC to the ALB. */
resource "aws_security_group_rule" "alb_from_vpc" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  to_port           = 80
  protocol          = "-1"
  from_port         = 80
  cidr_blocks       = "${var.vpc_cidr[terraform.workspace]}"

  count = "${length(var.vpc_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound from VPC"
}

resource "aws_security_group_rule" "sap_ingress_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from SAP/PI"
  cidr_blocks       = "${var.sap_cidr[terraform.workspace]}"

  count = "${length(var.sap_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "sap_https_ingress_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound HTTPS from SAP/PI"
  cidr_blocks       = "${var.sap_cidr[terraform.workspace]}"

  count = "${length(var.sap_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
}


resource "aws_security_group_rule" "test_client_admin_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from Test Server Containing client Admin tool for CSRs"
  cidr_blocks       = "${var.client_admin_cidr[terraform.workspace]}"

  count = "${length(var.client_admin_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "test_client_admin_https_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound HTTPS from Test Server Containing client Admin tool for CSRs"
  cidr_blocks       = "${var.client_admin_cidr[terraform.workspace]}"

  count = "${length(var.client_admin_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "client_domain_ingress_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = "${var.client_domain_cidr[terraform.workspace]}"

  count = "${length(var.client_domain_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound from client domain"
}

resource "aws_security_group_rule" "client_domain_ingress_https_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = "${var.client_domain_cidr[terraform.workspace]}"

  count = "${length(var.client_domain_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound HTTPS from client domain"
}

/* TODO: Modify to use new Build Server SG */
resource "aws_security_group_rule" "alb_all_from_build_server" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  to_port           = 443
  protocol          = "-1"
  from_port         = 443
  cidr_blocks       = ["10.128.1.0/24"]
  description       = "Inbound HTTPS from Ubuntu build server"
}

resource "aws_security_group_rule" "alb_all_from_perf_test_servers" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  to_port           = 443
  protocol          = "-1"
  from_port         = 443
  cidr_blocks       = "${var.perf_test_cidr[terraform.workspace]}"

  count = "${length(var.perf_test_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound HTTPS from Perf Test Servers"
}


/* Security Group rule to allow inbound traffic from VDI to Application Load Balancer (ALB). */
resource "aws_security_group_rule" "alb_from_vdi" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = "${var.internal_user_cidr[terraform.workspace]}"

  count = "${length(var.internal_user_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound from VDI"
}

/* Security Group rule to allow inbound traffic from VDI to Application Load Balancer (ALB). */
resource "aws_security_group_rule" "alb_https_from_vdi" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = "${var.internal_user_cidr[terraform.workspace]}"

  count = "${length(var.internal_user_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound HTTPS from VDI"
}


/* Security Group rule to allow PI QX1 system to connect to Microservices */
/* SAP PI Should only connect via HTTPS -- removing HTTP (80) rule */
resource "aws_security_group_rule" "alb_https_from_PI_QX1" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = "${var.pi_sap_cidr[terraform.workspace]}"

  count = "${length(var.pi_sap_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound HTTPS from PI QX1 system (PI/SAP)"
}


resource "aws_security_group_rule" "sitecore_inbound_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from Sitecore"

  source_security_group_id = "${element(var.sitecore_sgs[terraform.workspace], count.index)}"

  count = "${length(var.sitecore_sgs[terraform.workspace])}"
}

resource "aws_security_group_rule" "sitecore_inbound_https_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound from Sitecore"

  source_security_group_id = "${element(var.sitecore_sgs[terraform.workspace], count.index)}"

  count = "${length(var.sitecore_sgs[terraform.workspace])}"
}


resource "aws_security_group_rule" "aws_oei_servers_http_to_alb" {
  count = "${length(var.oei_server_sgs[terraform.workspace])}"

  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from OEI"

  source_security_group_id = "${element(var.oei_server_sgs[terraform.workspace], count.index)}"
}

resource "aws_security_group_rule" "aws_oei_servers_https_to_alb" {
  count = "${length(var.oei_server_sgs[terraform.workspace])}"

  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "HTTPS Inbound from OEI"

  source_security_group_id = "${element(var.oei_server_sgs[terraform.workspace], count.index)}"
}

resource "aws_security_group_rule" "jacada_app_inbound_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from Jacada App Security Group"

  source_security_group_id = "${element(var.jacada_app_sgs[terraform.workspace], count.index)}"

  count = "${length(var.jacada_app_sgs[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "jacada_app_inbound_https_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound from Jacada App Security Group"

  source_security_group_id = "${element(var.jacada_app_sgs[terraform.workspace], count.index)}"

  count = "${length(var.jacada_app_sgs[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "aws_dcdr_ec2_to_alb" {
  security_group_id = "${aws_security_group.alb_sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound from AWS DCDR EC2 Security Group"

  source_security_group_id = "${element(var.aws_dcdr_ec2_sgs[terraform.workspace], count.index)}"

  count = "${length(var.aws_dcdr_ec2_sgs[terraform.workspace]) >= 1 ? 1 : 0}"
}

output "alb_sg_id" {
  value     = "${aws_security_group.alb_sg.id}"
  sensitive = true
}

/* ==== END - ALB Security Group Creation ==== */

/* ==== BEGIN - Third Party ALB ==== */
### create alb

resource "aws_alb" "third-party-alb" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"
  depends_on = ["aws_s3_bucket_policy.alb_bucket_policy"]

  name               = "ci-3rd-party-${var.env[terraform.workspace]}-alb"
  internal           = "true"
  security_groups    = ["${aws_security_group.third-party-alb-sg.id}"]
  subnets            = ["${var.subnet_ids[terraform.workspace]}"]
  load_balancer_type = "application"
  idle_timeout       =  110

  access_logs {
    bucket  = "${module.alb_logs.bucket_name}"
    prefix  = "third-party-alb"
    enabled = "${var.enable_alb_logging[terraform.workspace]}"
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-3rd-party-${var.env[terraform.workspace]}-alb"
  ))}"
}

# Create default target group
resource "aws_alb_target_group" "third-party-tg" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  name                 = "ci-3rd-party-${var.env[terraform.workspace]}-alb-default-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id[terraform.workspace]}"
  deregistration_delay = 60

  health_check = {
    path    = "/healthcheck"
    matcher = 200
  }

  tags = "${merge(var.default_tags, map(
    "Name", "ci-3rd-party-${var.env[terraform.workspace]}-alb-default-tg"
  ))}"
}

resource "aws_lb_target_group_attachment" "legacy_service_1" {
  count = "${length(var.legacy_target_instance1[terraform.workspace]) == 0 ? 0 : var.requires_third_party_gw[terraform.workspace]}"

  target_group_arn = "${aws_alb_target_group.third-party-tg.arn}"
  target_id        = "${var.legacy_target_instance1[terraform.workspace]}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "legacy_service_2" {
  count = "${length(var.legacy_target_instance2[terraform.workspace]) == 0 ? 0 : var.requires_third_party_gw[terraform.workspace]}"

  target_group_arn = "${aws_alb_target_group.third-party-tg.arn}"
  target_id        = "${var.legacy_target_instance2[terraform.workspace]}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "legacy_service_3" {
  count = "${length(var.legacy_target_instance3[terraform.workspace]) == 0 ? 0 : var.requires_third_party_gw[terraform.workspace]}"

  target_group_arn = "${aws_alb_target_group.third-party-tg.arn}"
  target_id        = "${var.legacy_target_instance3[terraform.workspace]}"
  port             = 80
}

resource "aws_alb_listener" "third-party-listener" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  load_balancer_arn = "${aws_alb.third-party-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.third-party-tg.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "third_party_listener_ssl" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  load_balancer_arn = "${aws_alb.third-party-alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.int_svc_cert_arn[terraform.workspace]}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.third-party-tg.arn}"
  }
}



### Create Security Group ###
resource "aws_security_group" "third-party-alb-sg" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  name        = "ci-3rd-party-sg-alb"
  description = "security group for third party alb"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-3rd-party-sg-alb"
  ))}"
}

resource "aws_security_group_rule" "third_party_alb_from_lambda" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id        = "${aws_security_group.third-party-alb-sg.id}"
  source_security_group_id = "${aws_security_group.third-party-lambda-proxy.id}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  description              = "Inbound from Lambda Proxy"
}

resource "aws_security_group_rule" "third_party_alb_from_internal" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from client"
  cidr_blocks       = "${var.internal_user_cidr[terraform.workspace]}"

  count = "${length(var.internal_user_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
}

resource "aws_security_group_rule" "ecs_microservices_to_third_party_alb" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from ECS Microservices"
  source_security_group_id = "${aws_security_group.ecs.id}"
}

resource "aws_security_group_rule" "aws_oei_servers_to_third_party_alb" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Inbound from OEI"

  source_security_group_id = "${element(var.oei_server_sgs[terraform.workspace], count.index)}"
}

resource "aws_security_group_rule" "third_party_alb_to_ec2" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "egress"
  cidr_blocks       = "${var.legacy_target_instances_cidr[terraform.workspace]}"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  description       = "Outbound to legacy service on EC2"
}

resource "aws_security_group_rule" "third_party_alb_from_lambda_https" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id        = "${aws_security_group.third-party-alb-sg.id}"
  source_security_group_id = "${aws_security_group.third-party-lambda-proxy.id}"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  description              = "Inbound from Lambda Proxy"
}


resource "aws_security_group_rule" "third_party_alb_from_internal_https" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound from client"
  cidr_blocks       = "${var.internal_user_cidr[terraform.workspace]}"

  count = "${length(var.internal_user_cidr[terraform.workspace]) >= 1 ? 1 : 0}"
}


resource "aws_security_group_rule" "ecs_microservices_to_third_party_alb_https" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound from ECS Microservices"
  source_security_group_id = "${aws_security_group.ecs.id}"
}

resource "aws_security_group_rule" "aws_oei_servers_to_third_party_alb_https" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Inbound from OEI"

  source_security_group_id = "${element(var.oei_server_sgs[terraform.workspace], count.index)}"
}

resource "aws_security_group_rule" "third_party_alb_https_from_PI_QX1" {
  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = "${var.pi_sap_cidr[terraform.workspace]}"

  count = "${(var.requires_third_party_gw[terraform.workspace]*length(var.pi_sap_cidr[terraform.workspace])) >= 1 ? 1 : 0}"
  description       = "Inbound HTTPS from PI QX1 system (PI/SAP)"
}

resource "aws_security_group_rule" "third_party_alb_to_ec2_https" {
  count = "${var.requires_third_party_gw[terraform.workspace]}"

  security_group_id = "${aws_security_group.third-party-alb-sg.id}"
  type              = "egress"
  cidr_blocks       = "${var.legacy_target_instances_cidr[terraform.workspace]}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  description       = "Outbound to legacy service on EC2"
}


output "third_party_alb_dns" {
  value = "${element(compact(concat(aws_alb.third-party-alb.*.dns_name, list(var.third_party_alb_url[terraform.workspace]))), 0)}"

  sensitive = true
}

/* ==== END - Third Party ALB ==== */

