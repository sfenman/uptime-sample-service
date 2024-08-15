variable "container_name" {
  description = "Container name"
  type        = string
  default     = null
}

variable "family" {
  description = "Task definition name"
  type        = string
  default     = null
}

variable "container_image" {
  description = "Container image"
  type        = string
  default     = null
}

variable "container_cpu" {
  description = "Total number of cpu units used by container: 128 to 10240"
  type        = number
  default     = null
}


variable "container_memory" {
  description = "Amount in MiB of memory used by container"
  type        = number
  default     = null
}

variable "container_depends_on" {
  description = "The dependencies defined for container startup and shutdown."
  type = list(object({
    containerName = string
    condition     = string
  }))
  default = null
}

variable "container_port_mappings" {
  description = "host and container port. for fargate this can be left blank or the same port with container port"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = null
}

variable "container_extra_hosts" {
  description = "extra hosts to pass in /etc/hosts of the container"
  type = list(object({
    ipAddress = string
    hostname  = string
  }))
  default = null
}

variable "container_essential" {
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason."
  type        = bool
  default     = null
}

variable "container_environment" {
  description = "The environment variables to pass to the container. This is a list of maps"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "container_environment_files" {
  description = "The environment files to pass to the container (eg. from s3). This is a list of maps"
  type = list(object({
    value = string
    type  = string
  }))
  default = []
}

variable "container_secrets" {
  description = "The secrets to pass to the container. This is a list of maps"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = null
}

variable "container_entrypoint" {
  description = "Entrypoint for container"
  type        = list(string)
  default     = null
}

variable "container_command" {
  description = "Command for container"
  type        = list(string)
  default     = null
}

variable "container_docker_labels" {
  description = "The configuration options to send to the `docker_labels`"
  type        = map(string)
  default     = null
}

variable "aws_region" {
  description = "The AWS region to store the logs"
  type        = string
  default     = ""
}

variable "requires_compatibilities" {
  description = "Launch types required by task: EC2 or FARGATE"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "cpu" {
  description = "CPU used by the task"
  type        = number
  default     = null
}

variable "memory" {
  description = "Memory used by the task "
  type        = number
  default     = null
}

variable "network_mode" {
  description = "Network mode of the service. For fargate this is always awsvpc"
  type        = string
  default     = "awsvpc"
}

variable "task_role_arn" {
  description = "IAM task role, similar to instance profile"
  type        = string
  default     = null
}

variable "execution_role_arn" {
  description = "IAM service role for container agent and the Docker daemon"
  type        = string
  default     = null
}

variable "volume" {
  description = "List of volume blocks"
  type        = list(any)
  default     = []
}

variable "create_log_group" {
  description = "Whether to create a log group resource"
  type        = bool
  default     = true
}

variable "skip_destroy" {
  description = "If true terraform doesn't delete the resource but removes it from state"
  type        = bool
  default     = false
}

variable "retention_in_days" {
  description = "Specifies the numbers to retain logs"
  type        = number
  default     = 0
}

variable "kms_key_id" {
  description = "The ARN of the KMS to encrypt log data"
  type        = string
  default     = null
}

variable "create_task_execution_iam_role" {
  description = "Flag to determine whether to create the ECS task execution IAM role."
  type        = bool
  default     = true
}

variable "task_execution_role_name" {
  description = "The name of the IAM role for ECS task execution."
  type        = string
  default     = null
}

variable "create_tasks_iam_role" {
  description = "Flag to determine whether to create the ECS tasks IAM role."
  type        = bool
  default     = true
}

variable "tasks_role_name" {
  description = "The name of the IAM role for ECS tasks."
  type        = string
  default     = null
}

variable "tasks_role_description" {
  description = "The description of the IAM role for ECS tasks."
  type        = string
  default     = null
}

variable "tasks_iam_role_policies" {
  description = "Map of IAM role policy ARNs to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
