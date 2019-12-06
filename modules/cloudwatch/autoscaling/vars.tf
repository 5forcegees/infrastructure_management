/* ==== general vars ==== */
variable "env" {}

variable "region" {}

/* ==== Log Group vars ==== */
variable "cluster_name" {}

variable "service_names" {
  type = "list"
}

variable "max_count_map" {
  type = "map"
}

variable "min_count_map" {
  type = "map"
}

variable "max_mem_map" {
  type = "map"
}

variable "min_mem_map" {
  type = "map"
}

variable "sqs_threshold" {
  type = "map"
}

variable "requiresCPUScaling" {}
variable "requiresMemScaling" {}
variable "requiresSQSScaling" {}
