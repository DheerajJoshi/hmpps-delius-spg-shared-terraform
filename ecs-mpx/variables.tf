# region
variable "region" {}

variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}


variable "s3_bucket_config" {}
variable "spg_build_inv_dir" {}

variable "asg_instance_type_mpx" {default = "t2.medium"}
variable "cloudwatch_log_retention" {}





variable SPG_MPX_HOST_TYPE {}
variable SPG_GENERIC_BUILD_INV_DIR {}
variable SPG_MPX_JAVA_MAX_MEM {
  default="1500"
}
variable SPG_ENVIRONMENT_CODE {}

variable SPG_DELIUS_MQ_URL {}

variable SPG_GATEWAY_MQ_URL {
  default     = "localhost:61616"
  description = "SPG messaging broker url"
}

variable SPG_GATEWAY_MQ_URL_SOURCE {
  default     = "data"
  description = "variable.SPG_GATEWAY_MQ_URL | data.terraform.remote_state.amazonmq.amazon_mq_broker_connect_url"
}

variable SPG_DOCUMENT_REST_SERVICE_ADMIN_URL {}
variable SPG_DOCUMENT_REST_SERVICE_PUBLIC_URL {}

variable SPG_ISO_FQDN {}
variable SPG_MPX_FQDN {}
variable SPG_CRC_FQDN {}


variable spg_mpx_ecs_memory {
  default="2048"
}

//variable spg_mpx_ecs_cpu_units {
//}


variable image_url {
  default = "895523100917.dkr.ecr.eu-west-2.amazonaws.com/hmpps/spg"
}

variable image_version {
  default = "latest"
}


variable "tags" {
  type = "map"
}

variable PO_SPG_CONFIGURATION {
  description ="map of PO configs"
  type="map"
}