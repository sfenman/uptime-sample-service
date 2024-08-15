resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = var.image_mutability

  tags = merge(
    {
      component = "ecr"
    },
    var.extra_tags,
  )
}

resource "aws_ecr_lifecycle_policy" "policy" {
  count      = var.create_lifecycle_policy ? 1 : 0
  repository = aws_ecr_repository.repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last ${var.max_image_count} images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
    }
  )
}
