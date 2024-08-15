locals {
  security_group_name = try(coalesce(var.security_group_name, var.name), "")
}

resource "aws_ecs_service" "service" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.ecs_fargate_spot ? null : var.launch_type

  # only in replica mode
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  enable_execute_command = var.enable_execute_command

  deployment_controller {
    type = var.deployment_controller_type
  }

  enable_ecs_managed_tags           = var.enable_ecs_managed_tags
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  platform_version                  = var.platform_version
  propagate_tags                    = var.propagate_tags
  scheduling_strategy               = var.scheduling_strategy

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy
    iterator = strategy
    content {
      capacity_provider = lookup(strategy.value, "capacity_provider", null)
      weight            = lookup(strategy.value, "weight", null)
      base              = lookup(strategy.value, "base", null)
    }
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = coalescelist([aws_security_group.sg[0].id], var.security_groups)
    assign_public_ip = var.assign_public_ip
  }

  tags = merge(
    {
      component = "ecs"
    },
    var.extra_tags,
  )

  lifecycle {
    ignore_changes = [
      # eg. autoscaling
      desired_count,
    ]
  }
}


################################################################################
# Supporting resources
################################################################################
resource "aws_security_group" "sg" {
  count = var.create_security_group ? 1 : 0

  name        = local.security_group_name
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from the ECS Service")

  tags = merge(var.extra_tags, { Name = local.security_group_name })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if var.create_security_group }

  # required
  type              = try(each.value.type, "ingress")
  from_port         = try(each.value.from_port, 8000)
  to_port           = try(each.value.to_port, 8000)
  protocol          = try(each.value.protocol, "tcp")
  security_group_id = aws_security_group.sg[0].id

  # optional
  cidr_blocks              = try(each.value.cidr_blocks, null)
  description              = try(each.value.description, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}
