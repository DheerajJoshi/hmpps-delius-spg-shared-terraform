variable "environment_identifier" {}

variable "spg_app_name" {}

variable "ec2_policy_file" {}

variable "ecs_policy_file" {}

variable "ecs_role_policy_file" {}

variable "ec2_role_policy_file" {}

variable "ec2_internal_policy_file" {}

variable "tags" {
  type = "map"
}

variable "s3-config-bucket" {}

variable "depends_on" {
  default = []
  type    = "list"
}
