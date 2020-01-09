resource "aws_cloudwatch_metric_alarm" "spgw_mpx_alert_warning" {
  alarm_name = "${local.short_environment_name}__spgw__mpx-audit-alert__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${local.short_environment_name}-spgw-mpx-alert-count"
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
}

resource "aws_cloudwatch_metric_alarm" "spgw_mpx_exception_warning" {
  alarm_name = "${local.short_environment_name}__spgw__mpx-log-exception__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${local.short_environment_name}-spgw-mpx-exception-count"
  namespace           = "SPGW"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"

  treat_missing_data = "notBreaching"

  alarm_description = <<EOF
Exception encountered in application log <https://eu-west-2.console.aws.amazon.com/cloudwatch/home?region=eu-west-2#logEventViewer:group=${local.mpx_log_group_name};filter=Exception|${local.mpx_log_group_name}>

For metric: <https://eu-west-2.console.aws.amazon.com/cloudwatch/home?region=eu-west-2#alarmsV2:alarm/${local.short_environment_name}__spgw__mpx-log-exception__warning|mpx-log-exception__warning>

EOF

  alarm_actions = ["${aws_sns_topic.alarm_notification.arn}"]

  ok_actions = ["${aws_sns_topic.alarm_notification.arn}"]
}
