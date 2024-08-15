output "ecs_taskdef_arn" {
  description = "Task definition arn"
  value       = aws_ecs_task_definition.task_definition.arn
}

output "ecs_taskdef_family" {
  description = "Task definition family"
  value       = aws_ecs_task_definition.task_definition.family
}

output "ecs_taskdef_revision" {
  description = "Task definition revision"
  value       = aws_ecs_task_definition.task_definition.revision
}
