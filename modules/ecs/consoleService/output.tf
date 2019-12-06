output "consoleServices" {
  value = "${aws_ecs_service.fargate_consoleService.*.name}"
}
