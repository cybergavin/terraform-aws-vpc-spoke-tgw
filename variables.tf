variable "org" {
  description = "A name or abbreviation for the Organization. Only alphanumeric characters and hyphens are valid, with a string length from 3 to 8 characters."
  type        = string
  default     = "usc-its"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9]*(?:-[a-zA-Z0-9]+)*$", var.org)) && length(var.org) >= 3 && length(var.org) <= 8
    error_message = "The variable 'org' accepts only alphanumeric characters and hyphens, with a string length from 3 to 8 characters. The value of var.org must not begin with a hypen and must not contain consecutive hyphens."
  }
}

variable "app_id" {
  description = "The universally unique application ID for the service. Only alphanumeric characters are valid, with a string length from 3 to 8 characters."
  type        = string
  default     = "appid"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{3,8}$", var.app_id))
    error_message = "The variable 'app_id' accepts only alphanumeric characters, with a string length from 3 to 8 characters."
  }
}

variable "global_tags" {
  description = "A map of global tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "A valid Infrastructure Environment (poc, dev, tst, stg, prd)"
  type        = string
  default     = "poc"

  validation {
    condition     = contains(["poc", "dev", "tst", "stg", "prd"], var.environment)
    error_message = "The variable 'environment' must be one of: poc, dev, tst, stg, prd."
  }
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[12][0-9]|3[0-2])$", var.vpc_cidr))
    error_message = "The variable 'vpc_cidr' must be a valid CIDR block in the form of X.X.X.X/Y where X is between 0 and 255 and Y is between 0 and 32."
  }
}

variable "subnet_cidrs" {
  description = "A map of subnet aliases and their associated list of CIDR blocks across multiple AZs, with an alias length from 3 to 8 lowercase alphanumeric characters and valid CIDR blocks."
  type        = map(list(string))
  default     = {}
  validation {
    condition = alltrue([
      for alias, cidrs in var.subnet_cidrs :
      can(regex("^[a-z0-9]{3,8}$", alias)) && alltrue([
        for cidr in cidrs :
        can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/([0-9]|[12][0-9]|3[0-2])$", cidr))
      ])
    ])
    error_message = "Subnet aliases must contain only lowercase alphanumeric characters, 3-8 characters long, and associated with valid CIDR blocks."
  }
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

  validation {
    condition = alltrue([
      for sg in var.security_groups : (
        alltrue([
          for rule in(sg.ingress != null ? sg.ingress : []) :
          (rule.cidr_ipv4 == null && rule.source_sg_alias != null) ||
          (rule.cidr_ipv4 != null && rule.source_sg_alias == null)
        ]) &&
        alltrue([
          for rule in(sg.egress != null ? sg.egress : []) :
          (rule.cidr_ipv4 == null && rule.destination_sg_alias != null) ||
          (rule.cidr_ipv4 != null && rule.destination_sg_alias == null)
        ])
      )
    ])
    error_message = "Each ingress/egress rule in var.security_groups must define either 'cidr_ipv4' or 'source_sg_alias'/'destination_sg_alias', but not both."
  }
}

variable "tgw_sharing_enabled" {
  description = "Enable or disable the Transit Gateway sharing and attachment resources. Set to true to create the resources."
  type        = bool
  default     = false
}

variable "shared_transit_gateway_arn" {
  description = "The ARN of the Ingress network account's shared Transit Gateway."
  type        = string
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID for the peering connection. TBD: Obtain output from another tofu module."
  type        = string
}

variable "dns_servers" {
  description = "List of custom DNS servers to use"
  type        = list(string)
  default     = []
}

variable "dns_domain" {
  description = "Domain name for DHCP option set"
  type        = string
  default     = ""
}