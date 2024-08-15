variable "name" {
  description = "The name of ecs service"
  type        = string
  default     = null
}

variable "cluster" {
  description = "The cluster where the service will be run"
  type        = string
  default     = null
}

variable "task_definition" {
  description = "The task definition arn to create the service"
  type        = string
  default     = null
}

variable "ecs_fargate_spot" {
  description = "If true, a capacity provider strategy will be applied"
  type        = bool
  default     = false
}

variable "launch_type" {
  description = "Launch type definition (EC2 or FARGATE)"
  type        = string
  default     = null
}

variable "enable_execute_command" {
  description = "Whether to use AWS Container exec command in the service"
  type        = bool
  default     = false
}

variable "deployment_maximum_percent" {
  description = "Upper limit (percentage of desired_count) of running tasks that can be running in a service during a deployment"
  type        = number
  # Default 200% for REPLICA, 100% for DAEMON
  default = null
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit (pct of desired_count) of running tasks that must remain running and healthy in a service during a deployment"
  type        = number
  # Default 100%, 0% for DAEMON
  default = null
}

variable "desired_count" {
  description = "Number of instances of the task to place and keep running"
  type        = number
  default     = 0
}

variable "scheduling_strategy" {
  description = "REPLICA OR DAEMON"
  type        = string
  default     = "REPLICA"
}

variable "deployment_controller_type" {
  description = "Deployment controller type: CODE_DEPLOY or ECS. Default: ECS"
  type        = string
  default     = null
}

variable "enable_ecs_managed_tags" {
  description = "Enable Amazon ECS managed tags for the tasks within the service"
  type        = bool
  default     = true
}

variable "health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown"
  type        = number
  # Default 0
  default = null
}


variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = null
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = null
}

variable "target_group_arn" {
  description = "The target group ARN for the load balancer"
  type        = string
  default     = null
}

variable "platform_version" {
  description = "Only for fargate.Default is latest"
  type        = string
  default     = null
}

variable "capacity_provider_strategy" {
  description = "Capacity provider strategy"
  type        = list(any)
  default     = []
}

variable "propagate_tags" {
  description = "Whether to propagate tags from task definition or service to tasks: SERVICE or TASK_DEFINITION"
  type        = string
  default     = null
}

variable "extra_tags" {
  description = "A mapping of tags to assign to all resources"
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

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the service"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "Extra SGs to add"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Subnet IDs of the service"
  type        = list(string)
  default     = []
}

variable "create_autoscaling" {
  description = "Flag to enable or disable autoscaling"
  type        = bool
  default     = false
}

variable "create_autoscaling_memory" {
  description = "Flag to enable or disable memory-based autoscaling"
  type        = bool
  default     = false
}

variable "create_autoscaling_cpu" {
  description = "Flag to enable or disable CPU-based autoscaling"
  type        = bool
  default     = false
}

variable "autoscaling_max_capacity" {
  description = "The maximum capacity of the service for autoscaling"
  type        = number
  default     = null
}

variable "autoscaling_min_capacity" {
  description = "The minimum capacity of the service for autoscaling"
  type        = number
  default     = null
}

variable "autoscaling_memory_target_value" {
  description = "The target value for memory utilization autoscaling"
  type        = number
  default     = null
}

variable "autoscaling_cpu_target_value" {
  description = "The target value for CPU utilization autoscaling"
  type        = number
  default     = null
}
