resource "aws_cloudwatch_metric_alarm" "iso_lb_unhealthy_hosts_greater_than_zero" {
  alarm_name          = "${local.short_environment_name}__spgw__iso-nlb-unhealthy__alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Some hosts are unhealthy"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    TargetGroup  = "${local.iso_lb_target_group_arn_suffix}"
    LoadBalancer = "${local.iso_lb_arn_suffix}"
  }
}

resource "aws_cloudwatch_metric_alarm" "iso_lb_healthy_hosts_less_than_one" {
  alarm_name          = "${local.short_environment_name}__spgw__iso-nlb-healthy__critical"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "No Healthy Hosts!!!"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    TargetGroup  = "${local.iso_lb_target_group_arn_suffix}"
    LoadBalancer = "${local.iso_lb_arn_suffix}"
  }
}
