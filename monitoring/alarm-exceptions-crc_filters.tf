resource "aws_cloudwatch_log_metric_filter" "crc_alert_filter_count_1" {
  name           = "${local.short_environment_name}-spgw-crc-alert-filter"
  pattern        = "ALERT"
  log_group_name = "${local.crc_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-spgw-crc-alert-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "crc_exception_filter_count_1" {
  name           = "${local.short_environment_name}-spgw-crc-exception-filter"
  pattern        = "Exception"
  log_group_name = "${local.crc_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-spgw-crc-exception-count"
    namespace = "SPGW"
    value     = "1"
  }
}
