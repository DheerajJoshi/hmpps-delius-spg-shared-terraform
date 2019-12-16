resource "aws_cloudwatch_metric_alarm" "spgw_crc_cpu" {
  alarm_name                = "delius-aws-ops-alerts_${local.short_environment_name}_spgw-crc-alarm-test"
//  comparison_operator       = "GreaterThanOrEqualToThreshold"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This is a test metric monitoring cpu utilization"
  alarm_actions             = [ "${aws_sns_topic.alarm_notification.arn}" ]

  dimensions {
    AutoScalingGroupName = "${data.terraform_remote_state.ecs_crc.ecs_spg_autoscale_name}"
  }
}