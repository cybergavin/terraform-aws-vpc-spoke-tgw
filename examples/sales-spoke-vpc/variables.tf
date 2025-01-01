variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "org" {
  description = "A name or abbreviation for the Organization. Must not contain blankspaces and special characters."
  type        = string
}

variable "app_id" {
  description = "The universally unique application ID for the service."
  type        = string
}

variable "global_tags" {
  description = "A map of global tags to apply to all resources"
  type        = map(string)
}

variable "environment" {
  description = "Environment (sbx, dev, tst, stg, prd)"
  type        = string
  validation {
    condition     = contains(["sbx", "dev", "tst", "stg", "prd"], var.environment)
    error_message = "The variable 'environment' must be one of: sbx, dev, tst, stg, prd."
  }
}

variable "vpc_cidr" {
  description = "The CIDR block for the Sales Lead Generation VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "Map of subnet aliases to a list of CIDR blocks for each component across multiple AZs"
  type        = map(list(string))
}

variable "security_groups" {
  description = "List of security groups with associated ingress and egress rules"
  type = list(object({
    alias       = string
    description = string
    ingress = optional(list(object({
      description     = string
      cidr_ipv4       = optional(string) # Optional for source CIDR
      source_sg_alias = optional(string) # Optional for source SG
      ip_protocol     = string
      from_port       = optional(number) # Optional for cases like `-1` protocol
      to_port         = optional(number) # Optional for cases like `-1` protocol
    })))
    egress = optional(list(object({
      description          = string
      cidr_ipv4            = optional(string) # Optional for destination CIDR
      destination_sg_alias = optional(string) # Optional for destination SG
      ip_protocol          = string
      from_port            = optional(number) # Optional for cases like `-1` protocol
      to_port              = optional(number) # Optional for cases like `-1` protocol
    })))
  }))
}

variable "shared_transit_gateway_arn" {
  description = "The ARN of the Ingress network account's shared Transit Gateway. TBD: Obtain output from another tofu module."
  type        = string
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID for the peering connection. TBD: Obtain output from another tofu module."
  type        = string
}

variable "dns_servers" {
  description = "List of custom DNS servers to use (e.g., Bluecat)"
  type        = list(string)
}

variable "dns_domain" {
  description = "Domain name for DHCP option set"
  type        = string
}

variable "tgw_sharing_enabled" {
  description = "Enable or disable the Transit Gateway sharing and attachment resources. Set to true to create the resources."
  type        = bool
  default     = false
}