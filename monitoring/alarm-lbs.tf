resource "aws_cloudwatch_metric_alarm" "mpx_lb_unhealthy_hosts" {
  alarm_name          = "${local.short_environment_name}__spgw__mpx-lb-unhealthy-hosts-count__alert"
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

resource "aws_cloudwatch_metric_alarm" "mpx_lb_healthy_hosts" {
  alarm_name          = "${local.short_environment_name}__spgw__mpx-lb-healthy-hosts-count__critical"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "No Healthy Hosts!!!"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    LoadBalancerName = "${local.mpx_lb_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "mpx_lb_latency" {
  alarm_name          = "${local.short_environment_name}__spgw__mpx-lb-latency__warning"
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
  alarm_name          = "${local.short_environment_name}__spgw__mpx-lb-spill-over-count__warning"
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




resource "aws_cloudwatch_metric_alarm" "iso_lb_unhealthy_hosts" {
  alarm_name          = "${local.short_environment_name}__spgw__iso-nlb-unhealthy__alert"
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

resource "aws_cloudwatch_metric_alarm" "iso_lb_healthy_hosts" {
  alarm_name          = "${local.short_environment_name}__spgw__iso-nlb-healthy__critical"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "This metric monitors iso_lb_healthy_instances"
  alarm_actions       = ["${aws_sns_topic.alarm_notification.arn}"]
  treat_missing_data  = "notBreaching"

  dimensions {
    TargetGroup  = "${local.iso_lb_target_group_arn_suffix}"
    LoadBalancer = "${local.iso_lb_arn_suffix}"
  }
}
