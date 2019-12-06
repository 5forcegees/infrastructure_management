/* ==== Redis Specific Variables ==== */
variable "create_redis" {
  default = {
    dev          = 0
    test         = 0
    test-account = 1
    qa           = 1
    prod         = 1
    dev-ft  = 0
    test-ft = 0
  }
}

variable "redis_url" {
  default = {
    dev          = "rediscache.iuy6pw.ng.0001.usw2.cache.amazonaws.com"
    test         = "rediscache.iuy6pw.ng.0001.usw2.cache.amazonaws.com"
    test-account = ""
    qa           = ""
    prod         = ""
    dev-ft  = "rediscache.iuy6pw.ng.0001.usw2.cache.amazonaws.com"
    test-ft = "rediscache.iuy6pw.ng.0001.usw2.cache.amazonaws.com"
  }
}

variable "internal_user_cidr_redis" {
  default = {
    dev          = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16","170.192.0.0/16"]
    test         = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16","170.192.0.0/16"]
    test-account = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16","170.192.0.0/16"]
    qa           = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16","170.192.0.0/16"]
    prod         = ["10.41.12.26/32","10.41.12.27/32","10.41.12.80/32","10.41.12.81/32"]
    dev-ft       = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16","170.192.0.0/16"]
    test-ft      = ["10.10.0.0/16", "10.11.0.0/16", "10.137.0.0/16","170.192.0.0/16"] 
  }
}


variable "redis_node_size" {
  default = {
    dev          = "cache.m3.medium"
    test         = "cache.m3.medium"
    test-account = "cache.m3.medium"
    qa           = "cache.m4.xlarge"
    prod         = "cache.m4.xlarge"
  }
}


variable "on_prem_legacy_servers" {
  default = {
    dev          = []
    test         = ["10.41.12.0/24", "10.41.12.24/30"]
    test-account = []
    qa           = ["10.41.12.0/24", "10.41.12.24/30"]
    prod         = ["172.31.19.151/32", "172.31.19.37/32", "172.31.11.52/32", "10.47.12.83/32", "170.192.152.158/32", "172.31.18.57/32", "172.31.18.32/32", "172.31.10.52/32", "10.47.12.82/32"]
    dev-ft       = []
    test-ft      = [] 
  }
}

variable "aws_dcdr_ec2_sg" {
  default = {
    dev          = []
    test         = []
    test-account = []
    qa           = ["sg-0773c8b5f1cfeb916", "sg-0669f463d17c11d84"]
    prod         = ["sg-0b0cc54ee18ff5fa8", "sg-0969f0bea46a13888"]
    dev-ft       = []
    test-ft      = []
  }
}


/* ==== BEGIN - Redis Creation ==== */
resource "aws_elasticache_replication_group" "redis_cache" {
  replication_group_id          = "ci-${var.env[terraform.workspace]}-redis-cache"
  replication_group_description = "${var.env[terraform.workspace]} redis cache"

  engine                = "redis"
  engine_version        = "3.2"
  node_type             = "${var.redis_node_size[terraform.workspace]}"
  number_cache_clusters = 3

  parameter_group_name = "${aws_elasticache_parameter_group.cache_params.name}"
  subnet_group_name    = "${aws_elasticache_subnet_group.redis_subnet_group.name}"
  security_group_ids   = ["${aws_security_group.redis_sg.id}"]

  automatic_failover_enabled = true
  maintenance_window         = "sat:09:30-sat:10:30"
  snapshot_window            = "08:00-09:00"
  count                      = "${var.create_redis[terraform.workspace]}"

  lifecycle {
    ignore_changes = ["engine_version"]
  }
}

output "redis_primary_endpoint_address" {
  value     = "${element(compact(concat(aws_elasticache_replication_group.redis_cache.*.primary_endpoint_address, list(var.redis_url[terraform.workspace]))), 0)}"
  sensitive = true
}

/* ==== END - Redis Creation ==== */

/* ==== BEGIN - Redis Security Group Creation ==== */
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "ci-${var.env[terraform.workspace]}-redis-subnet-group"
  subnet_ids = ["${var.subnet_ids[terraform.workspace]}"]
}

resource "aws_security_group" "redis_sg" {
  name        = "ci-${var.env[terraform.workspace]}-redis-sg"
  description = "Allow to/from ECS and client"
  vpc_id      = "${var.vpc_id[terraform.workspace]}"
  tags = "${merge(var.default_tags, map(
    "Name", "ci-${var.env[terraform.workspace]}-redis-sg"
  ))}"
}


resource "aws_security_group_rule" "aws_oei_servers_to_redis" {
  security_group_id = "${aws_security_group.redis_sg.id}"
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  description       = "Inbound from OEI"

  source_security_group_id = "${element(var.oei_server_sgs[terraform.workspace], count.index)}"

  count = "${length(var.oei_server_sgs[terraform.workspace])}"
}


resource "aws_security_group_rule" "client_inbound_to_redis" {
  security_group_id = "${aws_security_group.redis_sg.id}"
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = "${var.internal_user_cidr_redis[terraform.workspace]}"

  count = "${length(var.internal_user_cidr_redis[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound from client"
}


resource "aws_security_group_rule" "client_inbound_to_redis_from_legacy_servers" {
  security_group_id = "${aws_security_group.redis_sg.id}"
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = "${var.on_prem_legacy_servers[terraform.workspace]}"

  count = "${length(var.on_prem_legacy_servers[terraform.workspace]) >= 1 ? 1 : 0}"
  description       = "Inbound from Legacy Servers"
}

resource "aws_security_group_rule" "aws_dcdr_ec2_inbound_to_redis" {
  security_group_id = "${aws_security_group.redis_sg.id}"
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = "${element(var.aws_dcdr_ec2_sg[terraform.workspace], count.index)}"

  count = "${length(var.aws_dcdr_ec2_sg[terraform.workspace])}"
  description       = "Inbound from AWS DCDR EC2s"
}

output "redis_sg_id" {
  value     = "${aws_security_group.redis_sg.id}"
  sensitive = true
}

/* ==== END - Redis Security Group Creation ==== */

/* === BEGIN - Redis Parameter Group Creation ==== */
resource "aws_elasticache_parameter_group" "cache_params" {
  name   = "ci-${var.env[terraform.workspace]}-redis-parameters"
  family = "redis3.2"

  parameter {
    name  = "repl-backlog-ttl"
    value = "3600"
  }

  parameter {
    name  = "tcp-keepalive"
    value = "300"
  }

  parameter {
    name  = "maxmemory-policy"
    value = "volatile-lru"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-hard-limit"
    value = "33554432"
  }

  parameter {
    name  = "min-slaves-to-write"
    value = "0"
  }

  parameter {
    name  = "cluster-require-full-coverage"
    value = "no"
  }

  parameter {
    name  = "reserved-memory-percent"
    value = "25"
  }

  parameter {
    name  = "slowlog-log-slower-than"
    value = "10000"
  }

  parameter {
    name  = "hll-sparse-max-bytes"
    value = "3000"
  }

  parameter {
    name  = "hash-max-ziplist-value"
    value = "64"
  }

  parameter {
    name  = "cluster-enabled"
    value = "no"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-soft-limit"
    value = "0"
  }

  parameter {
    name  = "maxmemory-samples"
    value = "3"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-limit"
    value = "8388608"
  }

  parameter {
    name  = "zset-max-ziplist-value"
    value = "64"
  }

  parameter {
    name  = "set-max-intset-entries"
    value = "512"
  }

  parameter {
    name  = "min-slaves-max-lag"
    value = "10"
  }

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  parameter {
    name  = "repl-backlog-size"
    value = "1048576"
  }

  parameter {
    name  = "close-on-slave-write"
    value = "yes"
  }

  parameter {
    name  = "databases"
    value = "16"
  }

  parameter {
    name  = "hash-max-ziplist-entries"
    value = "512"
  }

  parameter {
    name  = "zset-max-ziplist-entries"
    value = "128"
  }

  parameter {
    name  = "list-compress-depth"
    value = "0"
  }

  parameter {
    name  = "timeout"
    value = "0"
  }

  parameter {
    name  = "slowlog-max-len"
    value = "128"
  }

  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-seconds"
    value = "60"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-soft-seconds"
    value = "0"
  }

  parameter {
    name  = "client-output-buffer-limit-normal-hard-limit"
    value = "0"
  }
}
