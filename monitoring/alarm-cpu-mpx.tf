resource "aws_cloudwatch_metric_alarm" "spgw_mpx_cpu_alert" {
  alarm_name = "${local.short_environment_name}__spgw__mpx-cpu__critical"

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

  ok_actions = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_mpx.ecs_spg_autoscale_name}"
  }
}

