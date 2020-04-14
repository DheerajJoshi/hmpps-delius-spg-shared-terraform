variable "app_name" {}
variable "container_definitions" {}
variable "data_volume_name" {}
variable "data_volume_host_path" {}
variable "log_volume_host_path" {}
variable "log_volume_name" {}
variable "hmpps_asset_name_prefix" {}
variable "execution_role_arn" {
  default = ""
}