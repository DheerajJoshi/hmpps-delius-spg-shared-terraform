resource "aws_cloudwatch_log_metric_filter" "mpx_alert_filter_count_1" {
  name           = "${local.short_environment_name}-spgw-mpx-alert-filter"
  pattern        = "ALERT"
  log_group_name = "${local.mpx_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-spgw-mpx-alert-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "mpx_exception_filter_count_1" {
  name           = "${local.short_environment_name}-spgw-mpx-exception-filter"
  pattern        = "Exception"
  log_group_name = "${local.mpx_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-spgw-mpx-exception-count"
    namespace = "SPGW"
    value     = "1"
  }
}
