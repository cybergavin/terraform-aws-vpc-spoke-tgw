# Sales Account Networking
module "sales-network" {
  source                     = "../../../"
  org                        = var.org
  app_id                     = var.app_id
  environment                = var.environment
  vpc_cidr                   = var.vpc_cidr
  tgw_sharing_enabled        = var.tgw_sharing_enabled
  shared_transit_gateway_arn = var.shared_transit_gateway_arn
  transit_gateway_id         = var.transit_gateway_id
  subnet_cidrs               = var.subnet_cidrs
  dns_servers                = var.dns_servers
  dns_domain                 = var.dns_domain
  security_groups            = var.security_groups
  global_tags                = var.global_tags
}