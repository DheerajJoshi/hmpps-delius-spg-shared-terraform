data "template_file" "po_configuration" {
  template = "${file("task_definitions/key_value_pair.tpl.json")}"
  count = "${length(var.PO_SPG_CONFIGURATION)}"

  vars {
    name = "${element(keys(var.PO_SPG_CONFIGURATION),count.index)}"
    value = "${element(values(var.PO_SPG_CONFIGURATION),count.index)}"
  }
}


data "template_file" "spg_env_configuration" {
  template = "${file("task_definitions/key_value_pair.tpl.json")}"
  count = "${length(var.SPG_ENV_VARS)}"

  vars {
    name = "${element(keys(var.SPG_ENV_VARS),count.index)}"
    value = "${element(values(var.SPG_ENV_VARS),count.index)}"
  }
}

data "template_file" "haproxy_cfg" {
  template = "${file("${path.module}/templates/haproxy.cfg.tpl")}"
}

data "template_file" "app_task_definition" {
  template = "${file("task_definitions/template.json")}"

  vars {
    po_configuration = "${join(",", data.template_file.po_configuration.*.rendered)}"
    spg_env_configuration = "${join(",", data.template_file.spg_env_configuration.*.rendered)}"

    hmpps_asset_name_prefix = "${local.hmpps_asset_name_prefix}"

    container_name = "${local.app_name}-${local.app_submodule}"
    ecs_memory = "${local.ecs_memory}"

    image_url             = "${local.image_url}"
    version               = "${local.image_version}"

    data_volume_host_path = "${local.data_volume_host_path}"
    data_volume_name      = "${local.data_volume_name}"

    log_volume_name      = "${local.log_volume_name}"
    log_volume_host_path = "${local.log_volume_host_path}"

    s3_bucket_config      = "${local.s3_bucket_config}"

    log_group_name        = "${module.create_loggroup.loggroup_name}"
    log_group_region      = "${var.region}"


    SPG_HOST_TYPE = "${local.SPG_HOST_TYPE}"
    SPG_GENERIC_BUILD_INV_DIR = "${local.SPG_GENERIC_BUILD_INV_DIR}"
    SPG_JAVA_MAX_MEM = "${local.SPG_JAVA_MAX_MEM}"
    SPG_ENVIRONMENT_CODE = "${local.SPG_ENVIRONMENT_CODE}"
    SPG_ENVIRONMENT_CN = "${local.SPG_ENVIRONMENT_CN}"
    SPG_AWS_REGION = "${local.SPG_AWS_REGION}"
    SPG_PROXY_FQDN = "${local.SPG_PROXY_FQDN}"
  }
}

data "template_file" "bootstrap_certs_cfg" {
  template = "${file("${path.module}/templates/bootstrap.cfg.tpl")}"

  vars {
    SPG_CERTIFICATE_BUCKET = "${var.PO_SPG_CONFIGURATION["SPG_CERTIFICATE_BUCKET"]}"
    SPG_CERTIFICATE_PATH = "${var.PO_SPG_CONFIGURATION["SPG_CERTIFICATE_PATH"]}"
    SPG_PROXY_FQDN = "${local.SPG_PROXY_FQDN}"
  }
}

