# region
variable "region" {}

variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}

variable "asg_instance_type_crc" {default = "t2.small"}
variable "cloudwatch_log_retention" {}

variable "s3_bucket_config" {}
variable "spg_build_inv_dir" {}



variable "tags" {
  type = "map"
}

