resource "aws_cloudwatch_metric_alarm" "spgw_crc_cpu" {
  alarm_name = "${local.short_environment_name}__spgw-crc-cpu__delius-aws-ops-alerts"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "spgw crc cpu utilization"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_crc.ecs_spg_autoscale_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_mpx_cpu" {
  alarm_name = "${local.short_environment_name}__spgw-mpx-cpu__aws-ndelius-internal-support"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "spgw crc cpu utilization"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_mpx.ecs_spg_autoscale_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_iso_cpu" {
  alarm_name = "${local.short_environment_name}__spgw-iso-cpu__delius-aws-ops-alerts"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "spgw crc cpu utilization"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_iso.autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}
