# region
variable "region" {}

variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}


variable "s3_bucket_config" {}
variable "spg_build_inv_dir" {}

variable "cloudwatch_log_retention" {}


variable "tags" {
  type = "map"
}

