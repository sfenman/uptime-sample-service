resource "aws_ecs_cluster" "cluster" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights
  }

  tags = merge(
    {
      component = "ecs"
    },
    var.extra_tags,
  )
}
