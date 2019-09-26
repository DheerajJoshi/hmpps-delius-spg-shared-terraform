# Common variables
## remote states
variable "remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
}

variable "region" {
  description = "The AWS region."
}

variable is_production {
  type=bool
}


variable psn_facing_ips  {
  type="list"
}
variable internet_facing_ips {
  type="list"
}


//
//variable "eng-remote_state_bucket_name" {
//  description = "Terraform remote state bucket name"
//}
//
//
//variable "environment_identifier" {
//  description = "resource label or name"
//}
//
//variable "short_environment_identifier" {
//  description = "short resource label or name"
//}
//
//variable "short_environment_name" {
//  type = "string"
//}
//
//variable "project_name_abbreviated" {
//  type="string"
//}
//
//
//
//
//
//variable "eng_remote_state_bucket_name" {
//  description = "Terraform remote state bucket name for engineering (non prod) platform vpc"
//}
//
//variable "eng_role_arn" {
//  description = "arn to use for engineering platform terraform"
//}
//
//
//variable "lb_account_id" {}
//
//variable "role_arn" {}
//
//variable "route53_hosted_zone_id" {}
//
//variable "spg_app_name" {}
//
//variable "cloudwatch_log_retention" {}
//
//
//variable "tags" {
//  type = "map"
//}
