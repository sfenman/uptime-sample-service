locals {
  security_group_name = try(coalesce(var.security_group_name, var.name), "")
}

resource "aws_lb" "alb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg[0].id]
  subnets            = var.subnets

  tags = merge(
    {
      component = "alb"
    },
    var.extra_tags,
  )
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/"
  }
}

################################################################################
# Supporting resources
################################################################################
resource "aws_security_group" "sg" {
  count = var.create_security_group ? 1 : 0

  name        = local.security_group_name
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from the ALB ")

  tags = merge(var.extra_tags, { Name = local.security_group_name })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if var.create_security_group }

  # required
  type              = try(each.value.type, "ingress")
  from_port         = try(each.value.from_port, 80)
  to_port           = try(each.value.to_port, 80)
  protocol          = try(each.value.protocol, "tcp")
  security_group_id = aws_security_group.sg[0].id

  # optional
  cidr_blocks              = try(each.value.cidr_blocks, null)
  description              = try(each.value.description, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}
