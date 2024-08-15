output "ecr_arn" {
  value = aws_ecr_repository.repository.arn
}

output "ecr_name" {
  value = aws_ecr_repository.repository.name
}

output "ecr_registry_id" {
  value = aws_ecr_repository.repository.registry_id
}

output "ecr_repository_url" {
  value = aws_ecr_repository.repository.repository_url
}
