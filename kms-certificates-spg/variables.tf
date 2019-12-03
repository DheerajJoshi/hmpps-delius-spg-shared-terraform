# region
variable "region" {}

variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}

variable "tags" {
  type = "map"
}

variable "short_environment_identifier" {
  description = "short resource label or name"
}