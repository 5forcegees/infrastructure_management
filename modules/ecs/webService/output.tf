output "webServices" {
  value = "${aws_ecs_service.fargate_webService.*.name}"
}

output "webServices_tg" {
  value = "${aws_alb_target_group.alb_tg.*.arn_suffix}"
} 
