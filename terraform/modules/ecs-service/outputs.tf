output "ecs_service_id" {
  description = "Service ARN"
  value       = aws_ecs_service.service.id
}

output "ecs_service_name" {
  description = "Service name"
  value       = aws_ecs_service.service.name
}

output "ecs_service_cluster" {
  description = "Cluster ARN"
  value       = aws_ecs_service.service.cluster
}
