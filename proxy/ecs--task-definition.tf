############################################
# CREATE ECS TASK DEFINTIONS
############################################

data "aws_ecs_task_definition" "app_task_definition" {
  task_definition = "${module.app_task_definition.task_definition_family}"
  depends_on      = ["module.app_task_definition"]
}

data "template_file" "app_task_definition" {
  template = "${file("task_definitions/template.json")}"

  vars {
    hmpps_asset_name_prefix = "${local.hmpps_asset_name_prefix}"

    container_name = "${local.app_name}-${local.app_submodule}"
    ecs_memory = "${local.ecs_memory}"

    image_url             = "${local.image_url}"
    version               = "${local.image_version}"

    data_volume_host_path = "${local.data_volume_host_path}"
    data_volume_name      = "${local.data_volume_name}"

    s3_bucket_config = "${local.s3_bucket_config}"
  }
}

module "app_task_definition" {
  source   = "..//modules//ecs_task"
  app_name = "${local.container_name}"
  hmpps_asset_name_prefix = "${local.hmpps_asset_name_prefix}"

  container_name        = "${local.container_name}"
  container_definitions = "${data.template_file.app_task_definition.rendered}"

  data_volume_host_path = "${local.data_volume_host_path}"
  data_volume_name      = "${local.data_volume_name}"

}
