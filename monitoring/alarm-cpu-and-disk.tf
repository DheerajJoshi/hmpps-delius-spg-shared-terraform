

resource "aws_cloudwatch_metric_alarm" "spgw_mpx_cpu_alert" {
  alarm_name = "${local.short_environment_name}__spgw__mpx-cpu__alert"

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

resource "aws_cloudwatch_metric_alarm" "spgw_iso_cpu_warning" {
  alarm_name = "${local.short_environment_name}__spgw__iso-cpu__warning"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = <<EOF
spgw iso cpu is fairly high!
Sometimes POs take their systems offline (and out of hours), this would cause this scenario but would be an ok situation
https://dsdmoj.atlassian.net/wiki/spaces/DAM/pages/1578893538/Monitoring+and+Alerting
EOF
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_iso.autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_iso_cpu_alert" {
  alarm_name = "${local.short_environment_name}__spgw__iso-cpu__alert"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = <<EOF
spgw iso cpu is high!
Sometimes POs take their systems offline (and out of hours), this would cause this scenario but would be an ok situation
https://dsdmoj.atlassian.net/wiki/spaces/DAM/pages/1578893538/Monitoring+and+Alerting
EOF
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_iso.autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}


resource "aws_cloudwatch_metric_alarm" "spgw_iso_cpu_critical" {
  alarm_name = "${local.short_environment_name}__spgw__iso-cpu__critical"

  //  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = <<EOF
spgw iso cpu is high!
Sometimes POs take their systems offline (and out of hours), this would cause this scenario but would be an ok situation
https://dsdmoj.atlassian.net/wiki/spaces/DAM/pages/1578893538/Monitoring+and+Alerting
EOF
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_iso.autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}