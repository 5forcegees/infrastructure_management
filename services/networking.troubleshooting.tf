resource "aws_iam_role" "ecsTroubleshootingRole" {
  name = "ci-${var.env[terraform.workspace]}-ecs-network-troubleshooting-role"
  force_detach_policies = true

  assume_role_policy = "${data.aws_iam_policy_document.ecs_network_troubleshooting_role_trust_relationship.json}"
}

data "aws_iam_policy_document" "ecs_network_troubleshooting_role_trust_relationship" {
  policy_id = "ECSandBuildRoleTrustRelationship"

  statement {
    sid     = "EC2Trust"
    effect  = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals = {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    principals = {
      type = "AWS"
      identifiers = ["arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole"]
    }
  }
}

# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "network_troubleshooting_role" {
  count = "${var.troubleshooting_enabled[terraform.workspace] == true ? 1 : 0 }"

  role       = "${aws_iam_role.ecsTroubleshootingRole.name}"
  policy_arn = "${aws_iam_policy.ci_network_troubleshooting_role_policy.arn}"
}

resource "aws_iam_policy" "ci_network_troubleshooting_role_policy" {
  count = "${var.troubleshooting_enabled[terraform.workspace] == true ? 1 : 0 }"

  name        = "ci-${terraform.workspace}-ecs-network-troubleshooting-role-policy"
  path        = "/"
  description = "Policy used by ECS tasks"

  policy = "${data.terraform_remote_state.infrastructure.ecs_task_role_policy_json}"
}

/* ==== Network Troubleshooting Variables ==== */
variable "troubleshooting_enabled" {
  default = {
    dev          = "false"
    test         = "false"
    test-account = "false"
    qa           = "false"
    prod         = "false"
    dev-ft       = "false"
    test-ft      = "false"
  }
}

data "aws_ssm_parameter" "ecs_ami_id" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux/recommended/image_id"
}

output "network_troubleshooting_ecs_ami_id" {
  value = "${var.troubleshooting_enabled[terraform.workspace] == true ? element(split(",", data.aws_ssm_parameter.ecs_ami_id.value), 0) : "Troubleshooting Disabled"}"
}

/* ==== BEGIN - EC2 Creation ==== */
data "aws_s3_bucket_object" "user_data" {
  bucket = "${data.terraform_remote_state.infrastructure.s3_BucketName_platform}"
  key = "network-troubleshooting/userData.sh"
}

resource "aws_iam_instance_profile" "network_troubleshooting" {
  count = "${var.troubleshooting_enabled[terraform.workspace] == true ? 1 : 0 }"

  name = "network_troubleshooting_instance_profile"
  role = "${aws_iam_role.ecsTroubleshootingRole.name}"
}

resource "aws_instance" "network_troubleshooting" {
  depends_on = ["aws_security_group.network-troubleshooting"]
  depends_on = ["aws_iam_instance_profile.network_troubleshooting"]

  count = "${var.troubleshooting_enabled[terraform.workspace] == true ? length(var.subnet_ids[terraform.workspace]) : 0 }"

  ami           = "${element(split(",", data.aws_ssm_parameter.ecs_ami_id.value), 0)}"
  instance_type = "t2.micro"
  key_name      = "${var.key_names[terraform.workspace]}"

  subnet_id = "${element(var.subnet_ids[terraform.workspace], count.index)}"

  vpc_security_group_ids = ["${data.terraform_remote_state.infrastructure.ecs_security_group_id}", "${aws_security_group.network-troubleshooting.id}"]

  user_data = "${data.aws_s3_bucket_object.user_data.body}"

  iam_instance_profile = "${aws_iam_instance_profile.network_troubleshooting.name}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-network-troubleshooting"
  ))}"
}

output "network_troubleshooting_ip_addresses" {
  value = "${compact(concat(aws_instance.network_troubleshooting.*.private_ip, list("")))}"
}

resource "aws_security_group" "network-troubleshooting" {
  name        = "ci-${var.env[terraform.workspace]}-sg-troubleshooting"
  description = "security group for ECS network troubleshooting"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"

  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-sg-ecs-troubleshooting"
  ))}"
}

resource "aws_security_group_rule" "ssh_to_ec2" {
  security_group_id = "${aws_security_group.network-troubleshooting.id}"
  cidr_blocks       = ["10.0.0.0/8"]
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "SSH to EC2 instances"
}
