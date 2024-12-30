output "vpc_id" {
  value       = aws_vpc.this[module.networking_vpc_label.id].id
  description = "VPC ID"
}

output "subnets" {
  value       = aws_subnet.this
  description = "Map of subnets"
}

output "security_groups" {
  value       = aws_security_group.this
  description = "Map of security groups"
}