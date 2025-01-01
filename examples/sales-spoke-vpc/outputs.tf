output "sales-web-snets" {
  value = [for subnet in module.sales-network.subnets :
    subnet.id
    if can(regex("web", lookup(subnet.tags, "Name", "")))
  ]
}

output "sales-web-snets-az1" {
  value = [for subnet in module.sales-network.subnets :
    subnet.id
    if can(regex("web.*usw2a", lookup(subnet.tags, "Name", "")))
  ]
}

output "sales-sqldb-sg" {
  value = [for sg in module.sales-network.security_groups :
    sg.id
    if can(regex("sqldb", lookup(sg.tags, "Name", "")))
  ]
}