variable "lb_name" {}

variable "internal" {
  default = "true"
}

variable "enable_deletion_protection" {
  default = "false"
}

variable "s3_bucket_name" {}

variable "logs_enabled" {
  default = "true"
}

variable "tags" {
  type = "map"
}


variable public_subnet_ids {
  type = "list"
}
