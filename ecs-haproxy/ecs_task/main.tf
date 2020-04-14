resource "aws_ecs_task_definition" "environment" {
  family = "${var.hmpps_asset_name_prefix}-${var.app_name}-task-definition"
  container_definitions = "${var.container_definitions}"
  execution_role_arn = "${var.execution_role_arn}"

  volume {
    name = "${var.data_volume_name}"
    host_path = "${var.data_volume_host_path}"
  }

  volume {
    name = "${var.log_volume_name}"
    host_path = "${var.log_volume_host_path}"
  }
}
