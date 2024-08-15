variable "name" {
  description = "Name of the repo"
  type        = string
  default     = ""
}

variable "image_mutability" {
  description = "if repo supports mutable images"
  type        = string
  default     = "MUTABLE"
}

variable "extra_tags" {
  description = "Extra tags to add"
  type        = map(string)
  default     = {}
}

variable "create_lifecycle_policy" {
  description = "Whether to create or not an Ecr lifecycle policy"
  type        = bool
  default     = false
}

variable "max_image_count" {
  description = "Max images to keep"
  type        = number
  default     = 7
}
