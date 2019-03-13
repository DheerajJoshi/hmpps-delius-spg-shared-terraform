resource "aws_ecs_service" "environment" {
  name                               = "${var.servicename}-ecs-svc"
  cluster                            = "${var.clustername}"
  task_definition                    = "${var.task_definition_family}:${max("${var.task_definition_revision}", "${var.current_task_definition_version}")}"
  desired_count                      = "${var.service_desired_count}"
  iam_role                           = "${var.ecs_service_role}"
  deployment_minimum_healthy_percent = "${var.deployment_minimum_healthy_percent}"
  health_check_grace_period_seconds  = "${var.health_check_grace_period_seconds}"

  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name   = "${var.containername}"
    container_port   = "${var.containerport}"
  }
}
