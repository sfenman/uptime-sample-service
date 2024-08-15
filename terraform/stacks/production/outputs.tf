output "ecr_repository_uri" {
  description = "The URI of the ECR repository"
  value       = module.ecr.ecr_name
}

output "ecs_cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = module.ecs_cluster.cluster_arn
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs_service.ecs_service_name
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS Task Definition"
  value       = module.task_def.ecs_taskdef_arn
}

output "ecs_alb_dns_name" {
  description = "The DNS name of the ALB for the ECS service"
  value       = module.ecs_alb.alb_dns_name
}

output "aurora_cluster_endpoint" {
  description = "The endpoint address of the Aurora cluster"
  value       = module.aurora.cluster_endpoint
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
