terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

provider "aws" {
  region  = "${var.region}"
  version = ">= 2.1.0"

  #2.1.0 needed for ecs elb graceperiod, is set in the local elb module
  #version = "~> 1.16"
}


locals {
  spg_app_name = "${data.terraform_remote_state.common.spg_app_name}"
  app_name = "${local.spg_app_name}"
  container_name = "${local.app_name}-${local.app_submodule}"
  app_submodule = "proxy"
  hmpps_asset_name_prefix = "${data.terraform_remote_state.common.hmpps_asset_name_prefix}"
  ecs_memory    = "${var.spg_crc_ecs_memory}" //TODO

  image_url             = "${var.image_url}"
  image_version         = "${var.image_version}"
  s3_bucket_config = "${var.s3_bucket_config}"
  data_volume_host_path = "/opt/spg/servicemix/data"
  data_volume_name      = "proxy"

}