//####################################################
//# SECURITY GROUPS - Application specific
//####################################################
//output "security_groups_sg_internal_lb_id" {
//  value = "${module.security_groups.security_groups_sg_internal_lb_id}"
//}
//
//output "security_groups_sg_internal_instance_id" {
//  value = "${module.security_groups.security_groups_sg_internal_instance_id}"
//}
//
//#output "security_groups_sg_rds_id" {
//#  value = "${module.security_groups.security_groups_sg_rds_id}"
//#}
//
//output "security_groups_sg_external_lb_id" {
//  value = "${module.security_groups.security_groups_sg_external_lb_id}"
//}
//
//output "security_groups_sg_external_instance_id" {
//  value = "${module.security_groups.security_groups_sg_external_instance_id}"
//}

# SECURITY GROUPS

output "security_groups_sg_internal_lb_id" {
  value = "${local.internal_lb_sg_id}"
}

output "security_groups_sg_internal_instance_id" {
  value = "${local.internal_inst_sg_id}"
}

#output "security_groups_sg_rds_id" {
#  value = "${local.db_sg_id}"
#}

output "security_groups_sg_external_lb_id" {
  value = "${local.external_lb_sg_id}"
}

output "security_groups_sg_external_instance_id" {
  value = "${local.external_inst_sg_id}"
}
