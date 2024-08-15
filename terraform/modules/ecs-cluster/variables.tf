variable "name" {
  description = "Name of the cluster"
  type        = string
  default     = ""
}

variable "enable_container_insights" {
  description = "Enable or disable container insights"
  type        = string
  default     = "disabled"
}

variable "extra_tags" {
  description = "Extra tags to add"
  type        = map(string)
  default     = {}
}
