

resource "aws_cloudwatch_metric_alarm" "spgw_mpx_cpu" {
  alarm_name = "${local.short_environment_name}__spgw-mpx-cpu__delius-aws-ops-alerts"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "spgw mpx cpu utilization"
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
  alarm_description   = "spgw iso cpu is high!\nSometimes POs take their systems offline (and out of hours), this would cause this scenario but would be an ok situation\nhttps://dsdmoj.atlassian.net/wiki/spaces/DAM/pages/1578893538/Monitoring+and+Alerting"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_iso.autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}
