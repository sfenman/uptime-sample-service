variable "name" {
  description = "The name of the Application Load Balancer."
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or external."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "A list of subnet IDs where the load balancer will be deployed."
  type        = list(string)
  default     = null
}

variable "extra_tags" {
  description = "A map of extra tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "create_security_group" {
  description = "Determines whether to create security group for RDS cluster"
  type        = bool
  default     = true
}

variable "security_group_description" {
  description = "The description of the security group. If value is set to empty string it will contain cluster name in the description"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "security_group_name" {
  description = "The security group name. Default value is (`var.name`)"
  type        = string
  default     = ""
}
variable "security_group_rules" {
  description = "Map of security group rules to add to the cluster security group created"
  type        = any
  default     = {}
}

