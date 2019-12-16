resource "aws_cloudwatch_metric_alarm" "mpx_lb_unhealthy_hosts" {
  alarm_name          = "${local.short_environment_name}__spgw-mpx-lb-unhealthy-hosts-count__delius-aws-ops-alerts"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors mpx lb unhealthy host count"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    LoadBalancerName = "${local.mpx_lb_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "mpx_lb_latency" {
  alarm_name          = "${local.short_environment_name}__spgw-mpx-lb-latency__delius-aws-ops-alerts"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "Latency"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "5"
  alarm_description   = "This metric monitors mpx lb Latency"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]
  treat_missing_data  = "notBreaching"

  dimensions {
    LoadBalancerName = "${local.mpx_lb_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "mpx_lb_spillovercount" {
  alarm_name          = "${local.short_environment_name}__spgw-mpx-lb-spill-over-count__delius-aws-ops-alerts"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "SpilloverCount"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric monitors mpx_lb_spillovercount"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]
  treat_missing_data  = "notBreaching"

  dimensions {
    LoadBalancerName = "${local.mpx_lb_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "iso_lb_unhealthy_instances" {
  alarm_name          = "${local.short_environment_name}__spgw-iso-nlb__delius-aws-ops-alerts"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric monitors iso_lb_unhealthy_instances"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]
  treat_missing_data  = "notBreaching"

  dimensions {
    TargetGroup  = "${local.iso_lb_target_group_arn_suffix}"
    LoadBalancer = "${local.iso_lb_arn_suffix}"
  }
}
