output "ecs_cluster_id" {
  description = "ECS cluster id"
  value       = aws_ecs_cluster.cluster.id
}

output "ecs_cluster_arn" {
  description = "ECS cluster arn"
  value       = aws_ecs_cluster.cluster.arn
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.cluster.name
}
