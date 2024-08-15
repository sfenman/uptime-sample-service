output "alb_arn" {
  description = "The ARN of the Application Load Balancer."
  value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.alb.dns_name
}

output "alb_listener_arn" {
  description = "The ARN of the Application Load Balancer listener."
  value       = aws_lb_listener.alb_listener.arn
}

output "target_group_arn" {
  description = "The ARN of the target group."
  value       = aws_lb_target_group.tg.arn
}

output "security_group_id" {
  description = "The SG ID of ALB"
  value       = aws_security_group.sg[0].id
}
