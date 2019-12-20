resource "aws_cloudwatch_metric_alarm" "spgw_mpx_alert_warning" {
  alarm_name = "${local.short_environment_name}__spgw-mpx__auditalert__warning"

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
  alarm_name = "${local.short_environment_name}__spgw-mpx__logexception__warning"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "${local.short_environment_name}-spgw-mpx-exception-count"
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

}
