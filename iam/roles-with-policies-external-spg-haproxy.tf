#-------------------------------------------------------------
### EXTERNAL IAM POLICES FOR ECS SERVICES
#-------------------------------------------------------------

data "template_file" "iam_policy_haproxy_ecs_ext" {
  template = "${file(local.ecs_role_policy_file)}"

  vars {
    aws_lb_arn = "*"
  }
}

module "create-iam-ecs-role-haproxy-ext" {
  source     = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git?ref=master//modules//iam//role"
  rolename   = "${local.common_name}-haproxy-ext-ecs-svc"
  policyfile = "${local.ecs_module_default_assume_role_policy_file}"
}

module "create-iam-ecs-policy-haproxy-ext" {
  source     = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git?ref=master//modules//iam//rolepolicy"
  policyfile = "${data.template_file.iam_policy_haproxy_ecs_ext.rendered}"
  rolename   = "${module.create-iam-ecs-role-haproxy-ext.iamrole_name}"
}



module "create-iam-app-role-haproxy-ext" {
  source     = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git?ref=master//modules//iam//role"
  rolename   = "${local.common_name}-haproxy-ext-ec2"
  policyfile = "${local.ec2_iam_module_default_assume_role_policy_file}"
}

module "create-iam-instance-profile-haproxy-ext" {
  source = "git::https://github.com/ministryofjustice/hmpps-terraform-modules.git?ref=master//modules//iam//instance_profile"
  role   = "${module.create-iam-app-role-haproxy-ext.iamrole_name}"
}
