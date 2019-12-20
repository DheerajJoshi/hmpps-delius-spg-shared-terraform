resource "aws_cloudwatch_log_metric_filter" "iso_alert_filter_count_1" {
  name           = "${local.short_environment_name}-spgw-iso-alert-filter"
  pattern        = "ALERT"
  log_group_name = "${local.iso_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-spgw-iso-alert-count"
    namespace = "SPGW"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "iso_exception_filter_count_1" {
  name           = "${local.short_environment_name}-spgw-iso-exception-filter"
  pattern        = "Exception"
  log_group_name = "${local.iso_log_group_name}"

  metric_transformation {
    name      = "${local.short_environment_name}-spgw-iso-exception-count"
    namespace = "SPGW"
    value     = "1"
  }
}
