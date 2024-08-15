output "cluster_id" {
  description = "ECS cluster id"
  value       = aws_ecs_cluster.cluster.id
}

output "cluster_arn" {
  description = "ECS cluster arn"
  value       = aws_ecs_cluster.cluster.arn
}

output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.cluster.name
}
