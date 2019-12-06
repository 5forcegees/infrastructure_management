/* ==== BEGIN - ECS Execution Role Creation ==== */
resource "aws_iam_role" "ecs_execution_role" {
  name = "ci-${var.env[terraform.workspace]}-ecsTaskExecutionRole"
  force_detach_policies = true

  assume_role_policy = "${data.aws_iam_policy_document.ecs_execution_role_trust_relationship.json}" 
}

data "aws_iam_policy_document" "ecs_execution_role_trust_relationship" {
  policy_id = "ECSTaskTrustRelationship"

  statement {
    sid     = "ECSTaskTrust"
    effect  = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals = {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# attach VPC access execution policy to role
resource "aws_iam_role_policy_attachment" "execution-role" {
  role       = "${aws_iam_role.ecs_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "ecs_ecsTaskExecutionRole_arn" {
  value = "${aws_iam_role.ecs_execution_role.arn}"
}

output "ecs_ecsTaskExecutionRole_id" {
  value = "${aws_iam_role.ecs_execution_role.unique_id}"
}
/* ==== END - ECS Execution Role Creation ==== */
