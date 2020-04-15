# region
variable "region" {}

variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}


variable "s3_bucket_config" {}

variable "asg_instance_type_haproxy" {default = "t2.small"}
variable "cloudwatch_log_retention" {}


variable spg_haproxy_asg_desired {
  default="1"
}

variable spg_haproxy_asg_max {
  default="1"
}
variable spg_haproxy_asg_min {
  default="1"
}


variable spg_haproxy_service_desired_count {
  #1 = assumes desired ecs memory = max
  default="1"
}

variable spg_haproxy_ecs_memory {}

variable image_url {
  default = "895523100917.dkr.ecr.eu-west-2.amazonaws.com/hmpps/haproxy"
}

variable image_version {
  default = "latest"
}

variable bastion_inventory {}

variable "tags" {
  type = "map"
}

variable PO_SPG_CONFIGURATION {
  description ="map of PO configs"
  type="map"
}

variable SPG_ENV_VARS {
  description ="map of SPG environment vars"
  type="map"
  default = {
    SPG_NO_ENV_VARS_SET = true
  }
}

variable "deployment_minimum_healthy_percent" {
  default = "50"
}

variable "esc_container_stop_timeout" {
  default = "310s"
}

variable SPG_GENERIC_BUILD_INV_DIR {}

variable SPG_ISO_JAVA_MAX_MEM {}

variable SPG_PROXY_FQDN {}
variable SPG_MPX_FQDN {}
variable SPG_ENVIRONMENT_CODE {}
variable SPG_ENVIRONMENT_CN {}

