module "networking_base_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  tenant      = var.org
  name        = "aws" # to be overwritten by actual AWS resource type (e.g., vpc for AWS VPC)
  namespace   = var.app_id
  environment = var.environment
  attributes  = [local.region_code]
  label_order = ["tenant", "name", "namespace", "environment", "attributes"]
}

module "networking_vpc_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name    = "vpc"
  context = module.networking_base_label.context
}

module "networking_rtb_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name    = "rtb"
  context = module.networking_base_label.context
}

module "networking_dop_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name    = "dop"
  context = module.networking_base_label.context
}

module "networking_subnet_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  for_each    = { for subnet in local.subnet_configs : "${var.app_id}-${subnet.key}-${subnet.az}" => subnet }
  tenant      = var.org
  name        = "snet"
  namespace   = format("%s-%s", var.app_id, each.value.key)
  environment = var.environment
  attributes  = [join("", [local.region_code, substr(each.value.az, -1, 1)])]
  label_order = ["tenant", "name", "namespace", "environment", "attributes"]
}

module "networking_sg_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  for_each    = { for sg in var.security_groups : "${var.app_id}-${sg.alias}" => sg }
  tenant      = var.org
  name        = "sg"
  namespace   = format("%s-%s", var.app_id, each.value.alias)
  environment = var.environment
  attributes  = [local.region_code]
  label_order = ["tenant", "name", "namespace", "environment", "attributes"]
}

module "networking_tgw_attachment_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name        = "tgw-attach-IT-SEC-PROD-01"
  label_order = ["tenant", "name"]
}