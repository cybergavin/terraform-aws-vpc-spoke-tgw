org         = "cg-it" # Cybergavin IT department
app_id      = "slg"   # Sales Lead Generation
environment = "sbx"   # Sandbox
vpc_cidr    = "10.10.20.0/22"
subnet_cidrs = {
  web  = ["10.10.20.0/24", "10.10.21.0/24"]
  sftp = ["10.10.22.0/27", "10.10.23.0/27"]
}
tgw_sharing_enabled        = false
shared_transit_gateway_arn = null
transit_gateway_id         = null
dns_servers                = ["10.20.53.53", "10.20.53.54", "AmazonProvidedDNS"]
dns_domain                 = "cybergav.in"
security_groups = [
  {
    alias       = "web"
    description = "Security group for Sales web application"
    ingress = [
      {
        description = "Allow HTTPS"
        cidr_ipv4   = "0.0.0.0/0"
        source_sg_alias = null
        from_port   = 443
        to_port     = 443
        ip_protocol = "tcp"
      }
    ]
    egress = [
      {
        description = "Allow DB traffic"
        cidr_ipv4   = null
        destination_sg_alias = "sqldb"
        from_port            = 1433         
        to_port              = 1433         
        ip_protocol = "tcp"
      },
      {
        description = "Allow traffic to monitoring server"
        cidr_ipv4   = "150.240.22.32/27"
        destination_sg_alias = null
        from_port            = 9099         
        to_port              = 9099         
        ip_protocol = "tcp"
      }      
    ]
  },
  {
    alias       = "sqldb"
    description = "Security group for Sales DB servers"
    ingress = [
      {
        description = "Allow Web traffic"
        cidr_ipv4   = null
        source_sg_alias = "web"
        from_port   = 1433
        to_port     = 1433
        ip_protocol = "tcp"
      }
    ]
  }
]
global_tags = {
  "usc:application:name"       = "Sales Lead Generation"
  "usc:application:id"         = "slg"
  "usc:application:owner"      = "Cybergavin IT"
  "usc:operations:environment" = "sbx"
  "usc:operations:managed_by"  = "OpenTofu"
  "usc:cost:cost_center"       = "CA45321"
  "usc:cost:business_unit"     = "ITS"
}