############################################
# CREATE ECS TASK DEFINTIONS
############################################

data "aws_ecs_task_definition" "app_task_definition" {
  task_definition = "${module.app_task_definition.task_definition_family}"
  depends_on      = ["module.app_task_definition"]
}

module "app_task_definition" {
  source   = "ecs_task"
  app_name = "${local.container_name}"
  hmpps_asset_name_prefix = "${local.hmpps_asset_name_prefix}"

  container_definitions = "${data.template_file.app_task_definition.rendered}"

  data_volume_host_path = "${local.data_volume_host_path}"
  data_volume_name      = "${local.data_volume_name}"

  log_volume_host_path = "${local.log_volume_host_path}"
  log_volume_name      = "${local.log_volume_name}"
}


