resource "aws_cloudwatch_log_metric_filter" "mpx_alert_filter_count_1" {
  name           = "${local.short_environment_name}__spgw__mpx-alert-filter"
  pattern        = "ALERT"
  log_group_name = "${local.mpx_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-mpx-alert-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_mpx_alert_warning" {
  alarm_name = "${local.short_environment_name}__spgw__mpx-alert__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "mpx-alert-count"
  namespace           = "SPGW"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"

  treat_missing_data = "notBreaching"

  alarm_description = <<EOF
ALERT encountered
EOF

  alarm_actions = ["${aws_sns_topic.alarm_notification.arn}"]

  ok_actions = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_mpx.ecs_spg_autoscale_name}" //TODO sync output variable name style with mpx & mpx in the new year
  }
}






resource "aws_cloudwatch_log_metric_filter" "mpx_exception_filter_count_1" {
  name           = "${local.short_environment_name}__spgw__mpx-exception-filter"
  pattern        = "Exception"
  log_group_name = "${local.mpx_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-mpx-exception-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_mpx_exception_warning" {
  alarm_name = "${local.short_environment_name}__spgw__mpx-exception__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "mpx-exception-count"
  namespace           = "SPGW"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"

  treat_missing_data = "notBreaching"

  alarm_description = <<EOF
Exception encountered
EOF

  alarm_actions = ["${aws_sns_topic.alarm_notification.arn}"]

  ok_actions = ["${aws_sns_topic.alarm_notification.arn}"]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_mpx.ecs_spg_autoscale_name}" //TODO sync output variable name style with mpx & mpx in the new year
  }
}
