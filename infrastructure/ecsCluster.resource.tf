/* ==== BEGIN - ECS Cluster Creation ==== */
resource "aws_ecs_cluster" "cluster" {
  name = "ci-${var.env[terraform.workspace]}-cluster"
}

output "ecs_cluster_arn" {
  value = "${aws_ecs_cluster.cluster.arn}"
}

output "ecs_cluster_name" {
  value = "${aws_ecs_cluster.cluster.name}"
}

/* ==== END - ECS Cluster Creation ==== */

