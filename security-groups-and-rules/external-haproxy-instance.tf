# Applicance (HaProxy or SPG-ISO)
resource "aws_security_group" "external_haproxy_instance" {
  name        = "${local.common_name}-external-haproxy-instance"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"
  description = "SPG ISO / HaProxy Instance SG"
  tags        = "${merge(var.tags, map("Name", "${var.environment_name}-${var.spg_app_name}-external-haproxy-instance", "Type", "WEB"))}"

  lifecycle {
    create_before_destroy = true
  }
}



###################
# EGRESS
###################


#-------------------------------------------------------------
### port 8181 (soap/rest/hawtio) (for when ISO is only doing TLS termination (ie its haproxy) and mpx-hybrid is unsigning)
#-------------------------------------------------------------
resource "aws_security_group_rule" "external_instance_8181_egress" {
  security_group_id        = "${aws_security_group.external_haproxy_instance.id}"
  description              = "to mpx LB"
  type                     = "egress"
  source_security_group_id = "${aws_security_group.internal_mpx_loadbalancer.id}" //todo what's this
  from_port                = 8181
  to_port                  = 8181
  protocol                 = "tcp"
}



#-------------------------------------------------------------
### port 8989 (unsigned soap from iso to mpx) (for when ISO is doing TLS termination + unsigning)
#-------------------------------------------------------------
resource "aws_security_group_rule" "external_instance_egress_httpunsigned" {
  security_group_id        = "${aws_security_group.external_haproxy_instance.id}"
  description              = "to mpx LB"
  type                     = "egress"
  source_security_group_id = "${aws_security_group.internal_mpx_loadbalancer.id}"
  from_port                = 8989
  to_port                  = 8989
  protocol                 = "tcp"
}