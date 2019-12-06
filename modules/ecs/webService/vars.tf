variable "env" {}
variable "region" {}

variable "account_id" {}
variable "ecs_task_role_arn" {}
variable "ecs_execution_role_arn" {}

variable "cluster_name" {}
variable "cluster_arn" {}

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

variable "alb_listener_rules" {
  type = "list"
}

variable "vpc_id" {}

variable "default_tags" {
  type = "map"
}

variable "alb_listener_arn" {}
variable "alb_listener_ssl_arn" {}
variable "alb_arn_suffix" {}
