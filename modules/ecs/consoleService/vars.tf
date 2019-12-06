variable "env" {}
variable "region" {}

variable "account_id" {}
variable "ecs_task_role_arn" {}
variable "ecs_execution_role_arn" {}

variable "cluster_name" {}

variable "ecs_service_names" {
  type = "list"
}

variable "desired_count_map" {
  type = "map"
}

variable "security_groups" {
  type = "list"
}

variable "assign_public_ip" {}

variable "subnets" {
  type = "list"
}
