locals {
  log_group = "/ecs/${var.container_name}"

  definition_values = {
    container_name       = var.container_name
    container_image      = var.container_image
    container_memory     = var.container_memory
    container_cpu        = var.container_cpu
    container_depends_on = var.container_depends_on
    essential            = var.container_essential
    port_mappings        = var.container_port_mappings
    extra_hosts          = var.container_extra_hosts
    environment          = var.container_environment
    secrets              = var.container_secrets
    environment_files    = var.container_environment_files
    entrypoint           = var.container_entrypoint
    command              = var.container_command
    docker_labels        = var.container_docker_labels

    log_configuration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = local.log_group
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
      secretOptions = []
    }
  }


  container_definition_json = jsonencode([
    local.definition_values
  ])
}

resource "aws_ecs_task_definition" "task_definition" {
  family = var.family

  container_definitions = local.container_definition_json

  task_role_arn      = try(aws_iam_role.tasks[0].arn, var.task_role_arn)
  execution_role_arn = try(aws_iam_role.task_execution[0].arn, var.execution_role_arn)

  requires_compatibilities = var.requires_compatibilities

  cpu          = var.cpu
  memory       = var.memory
  network_mode = var.network_mode

  dynamic "volume" {
    for_each = var.volume
    content {
      name      = lookup(volume.value, "name", null)
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }
      }
    }
  }

}

resource "aws_cloudwatch_log_group" "log_group" {
  count = var.create_log_group ? 1 : 0

  name = local.log_group

  skip_destroy      = var.skip_destroy
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id

  tags = merge(
    {
      component = "cloudwatch"
    },
    var.extra_tags,
  )
}


resource "aws_iam_role" "task_execution" {
  count = var.create_task_execution_iam_role ? 1 : 0

  name = var.task_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    {
      component = "iam"
    },
    var.extra_tags,
  )
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy" {
  count = var.create_task_execution_iam_role ? 1 : 0

  name       = "ecsTaskExecutionRolePolicyAttachment"
  roles      = [aws_iam_role.task_execution[0].name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



data "aws_iam_policy_document" "tasks" {
  count = var.create_tasks_iam_role ? 1 : 0

  statement {
    sid     = "ECSTasksAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

  }
}

resource "aws_iam_role" "tasks" {
  count       = var.create_tasks_iam_role ? 1 : 0
  name        = var.tasks_role_name
  description = var.tasks_role_description

  assume_role_policy = data.aws_iam_policy_document.tasks[0].json

  tags = merge(
    {
      component = "iam"
    },
    var.extra_tags,
  )
}

resource "aws_iam_role_policy_attachment" "tasks" {
  for_each = { for k, v in var.tasks_iam_role_policies : k => v if var.create_tasks_iam_role }

  role       = aws_iam_role.tasks[0].name
  policy_arn = each.value
}
