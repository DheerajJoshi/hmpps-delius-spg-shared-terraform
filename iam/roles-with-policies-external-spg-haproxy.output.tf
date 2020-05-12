####################################################
# IAM - Application specific
####################################################
# EXTERNAL

# ECS
output "iam_role_hap_ext_ecs_role_arn" {
  value = "${module.create-iam-ecs-role-hap-ext.iamrole_arn}"
}

output "iam_role_hap_ext_ecs_role_name" {
  value = "${module.create-iam-ecs-role-hap-ext.iamrole_name}"
}

# APP ROLE
output "iam_policy_hap_ext_app_role_arn" {
  value = "${module.create-iam-app-role-hap-ext.iamrole_arn}"
}

output "iam_policy_hap_ext_app_role_name" {
  value = "${module.create-iam-app-role-hap-ext.iamrole_name}"
}

# PROFILE
output "iam_policy_hap_ext_app_instance_profile_name" {
  value = "${module.create-iam-instance-profile-hap-ext.iam_instance_name}"
}