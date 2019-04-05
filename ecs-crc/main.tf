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

####################################################
# Locals
####################################################

locals {
  ########################################################################################################
  #Common (lots of duplication here, needs further refactoring)
  ########################################################################################################
  tags = "${var.tags}"

  short_environment_name = "${data.terraform_remote_state.common.short_environment_name}"
  app_hostnames          = "${data.terraform_remote_state.common.app_hostnames}"
  project_name_abbreviated = "${data.terraform_remote_state.common.project_name_abbreviated}"

  hmpps_asset_name_prefix = "${data.terraform_remote_state.common.hmpps_asset_name_prefix}"
  common_name            = "${local.hmpps_asset_name_prefix}-${local.app_hostnames["external"]}-${local.app_submodule}"

  spg_app_name           = "${data.terraform_remote_state.common.spg_app_name}"
  app_name               = "${local.spg_app_name}"
  app_submodule          = "crc"
  application_endpoint   = "${local.app_hostnames["external"]}"
  environment_identifier = "${data.terraform_remote_state.common.environment_identifier}"

  ########################################################################################################
  #Network common (protocol needs to match between front end and back end)
  ########################################################################################################
  backend_app_port = "8181"

  backend_app_protocol = "HTTP"

  ########################################################################################################
  #Target group and listeners
  ########################################################################################################
  vpc_id = "${data.terraform_remote_state.common.vpc_id}"

  target_type = "instance"

  ########################################################################################################
  #Classic Loadbalancer
  ########################################################################################################
  access_logs_bucket = "${data.terraform_remote_state.common.common_s3_lb_logs_bucket}"

  private_subnet_ids = ["${data.terraform_remote_state.common.private_subnet_ids}"]
  public_subnet_ids  = ["${data.terraform_remote_state.common.public_subnet_ids}"]

  connection_draining         = false
  connection_draining_timeout = 300

  backend_timeout        = "60"
  external_domain        = "${data.terraform_remote_state.common.external_domain}"
  public_zone_id         = "${data.terraform_remote_state.common.public_zone_id}"
  int_lb_security_groups = "${local.sg_map_ids["internal_lb_sg_id"]}"

  listener = [
    {
      instance_port     = "61616"
      instance_protocol = "TCP"
      lb_port           = "61616"
      lb_protocol       = "TCP"
    },
    {
      instance_port     = "8181"
      instance_protocol = "HTTP"
      lb_port           = "8181"
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = "8989"
      instance_protocol = "HTTP"
      lb_port           = "8989"
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = "9001"
      instance_protocol = "TCP"
      lb_port           = "9001"
      lb_protocol       = "TCP"
    },
  ]

  health_check = [
    {
      target            = "HTTP:8181/cxf/"
      interval          = 60
      healthy_threshold = 2

      #set to 10 to allow spg 10 mins to spin up
      unhealthy_threshold = 10
      timeout             = 5
    },
  ]

  ########################################################################################################
  #                                   ECS service
  ########################################################################################################

  ########################################################################################################
  #ecs service -  log group
  ########################################################################################################
  cloudwatch_log_retention = "${var.cloudwatch_log_retention}"
  ########################################################################################################
  #ecs service - app service
  ########################################################################################################
  ecs_service_role = "${data.terraform_remote_state.iam.iam_role_ext_ecs_role_arn}"
  service_desired_count = "1"
  sg_map_ids            = "${data.terraform_remote_state.common.sg_map_ids}"
  instance_security_groups = [
    "${local.sg_map_ids["external_inst_sg_id"]}", //for iso
    "${local.sg_map_ids["internal_inst_sg_id"]}", //for mpx
    "${local.sg_map_ids["bastion_in_sg_id"]}",
    "${local.sg_map_ids["outbound_sg_id"]}",
  ]
  ########################################################################################################
  #ecs service block device
  ########################################################################################################
  ebs_device_name = "/dev/xvdb"
  ebs_encrypted   = "true"
  ebs_volume_size = "50"
  ebs_volume_type = "standard"
  volume_size = "50"
  ########################################################################################################
  #ecs launch config
  ########################################################################################################
  ami_id = "${data.aws_ami.amazon_ami.id}"
  instance_profile            = "${data.terraform_remote_state.iam.iam_policy_ext_app_instance_profile_name}"
  instance_type               = "t2.medium"
  ssh_deployer_key            = "${data.terraform_remote_state.common.common_ssh_deployer_key}"
  associate_public_ip_address = true
  ########################################################################################################
  #ecs asg
  ########################################################################################################
  asg_desired = "1"
  asg_max = "1"
  asg_min = "1"

  ########################################################################################################
  #ecs task definition
  ########################################################################################################

  image_url             = "${data.terraform_remote_state.ecr.ecr_repository_url}"
  image_version         = "latest"
  backend_ecs_cpu_units = "256"
  backend_ecs_memory    = "2048"
  #regular config bucket - not sure what this is used for yet
  config-bucket = "${data.terraform_remote_state.common.common_s3-config-bucket}"
  #vars for docker app
  #s3 bucket for ANISBLE jobs (derived from env properties
  s3_bucket_config = "${var.s3_bucket_config}"
  spg_build_inv_dir = "${var.spg_build_inv_dir}"
  #vars for docker container
  kibana_host           = "NOTUSED(yet)"
  data_volume_host_path = "/opt/spg"
  data_volume_name      = "spg"
  user_data             = "../user_data/spg_user_data.sh"

  //  account_id                     = "${data.terraform_remote_state.common.common_account_id}"
  //  alb_backend_port               = "9001"
  //  alb_http_port                  = "80"
  //  alb_https_port                 = "443"
  //  backend_app_template_file      = "template.json"
  //  backend_check_app_path         = "/cxf/"
  //  backend_check_interval         = "120"
  //  backend_ecs_desired_count      = "1"
  //  backend_healthy_threshold      = "2"
  //  backend_maxConnections         = "500"
  //  backend_maxConnectionsPerRoute = "200"
  //  backend_return_code            = "200,302"
  //  backend_timeoutInSeconds       = "60"
  //  backend_timeoutRetries         = "10"
  //  backend_unhealthy_threshold    = "10"
  //  certificate_arn                = ["${data.aws_acm_certificate.cert.arn}"]
  //  cidr_block                     = "${data.terraform_remote_state.common.vpc_cidr_block}"

  //  deregistration_delay           = "90"
  //  health_check = "${local.health_check}"
  //  internal_domain                = "${data.terraform_remote_state.common.internal_domain}"
  //  keys_dir                       = "/opt/spg"
  //  listener = "${local.listener}"
  //  monitoring_server_internal_url = "tmpdoesnotexist"                                                                    # "${data.terraform_remote_state.common.monitoring_server_internal_url}"
  //  private_subnet_map             = "${data.terraform_remote_state.common.private_subnet_map}"
  //  private_zone_id                = "${data.terraform_remote_state.common.private_zone_id}"
  //  public_cidr_block              = ["${data.terraform_remote_state.common.db_cidr_block}"]
  //  region                         = "${var.region}"

  //  ext_lb_security_groups         = ["${data.terraform_remote_state.security-groups.security_groups_sg_external_lb_id}"]

  # "${data.terraform_remote_state.common.monitoring_server_client_sg_id}",
}
