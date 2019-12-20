resource "aws_cloudwatch_log_metric_filter" "crc_alert_filter_count_1" {
  name           = "${local.short_environment_name}__spgw__crc-alert-filter"
  pattern        = "ALERT"
  log_group_name = "${local.crc_log_group_name}"

  metric_transformation {
    name      = "crc-alert-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_crc_alert_warning" {
  alarm_name = "${local.short_environment_name}__spgw__crc-alert__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "crc-alert-count"
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
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_crc.ecs_spg_autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}

resource "aws_cloudwatch_log_metric_filter" "crc_exception_filter_count_1" {
  name           = "${local.short_environment_name}__spgw__crc-exception-filter"
  pattern        = "Exception"
  log_group_name = "${local.crc_log_group_name}"

  metric_transformation {
    name      = "crc-exception-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "spgw_crc_exception_warning" {
  alarm_name = "${local.short_environment_name}__spgw__crc-exception__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "crc-exception-count"
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
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_crc.ecs_spg_autoscale_name}" //TODO sync output variable name style with crc & mpx in the new year
  }
}
