provider "aws" {
  region = local.region
}

locals {
  region   = "eu-west-1"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  vpc_cidr = "10.0.0.0/16"

  cost_report_tags = {
    "Environment" = "Production"
    "Owner"       = "SRE"
  }
}


module "ecr" {
  source = "../../modules/ecr"

  name       = "uptime-python"
  extra_tags = local.cost_report_tags
}

module "ecs_cluster" {
  source = "../../modules/ecs-cluster"

  name                      = "sample-ecs-cluster"
  enable_container_insights = true
  extra_tags                = local.cost_report_tags
}

module "task_def" {
  source = "../../modules/ecs-task-definition"

  container_name   = "uptime-python"
  container_image  = module.ecr.ecr_name
  container_memory = 512
  container_cpu    = 256
  container_port_mappings = [
    {
      containerPort = 8000
      hostPort      = 8000
      protocol      = "tcp"
    }
  ]
  aws_region               = "eu-west-1"
  family                   = "uptime-python-taskdef"
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # Cloudwatch logs
  create_log_group  = true
  retention_in_days = 7

  # IAM
  tasks_role_name          = "uptime-python-tasks"
  task_execution_role_name = "uptime-python-task-execution"

}

module "ecs_alb" {
  source = "../../modules/alb"

  name = "uptime-alb"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  # Security Group
  create_security_group = true
  security_group_name   = "uptime-alb-sg"
  security_group_rules = {
    inbound = {
      type        = "ingress"
      from_port   = 80,
      to_port     = 80,
      cidr_blocks = ["0.0.0.0/0"]
    },
    outbound = {
      type        = "egress"
      from_port   = 0,
      to_port     = 65536,
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


module "ecs_service" {
  source = "../../modules/ecs-service"

  name = "uptime-service"

  cluster = module.ecs_cluster.cluster_arn

  task_definition = module.task_def.ecs_taskdef_arn

  target_group_arn = module.ecs_alb.target_group_arn
  container_name   = "uptime-python"
  container_port   = 8000

  launch_type = "FARGATE"

  desired_count = 1

  # Network
  subnets          = module.vpc.private_subnets
  assign_public_ip = false

  # Security Group
  create_security_group = true
  vpc_id                = module.vpc.vpc_id
  security_group_name   = "uptime-service-sg"
  security_group_rules = {
    inbound = {
      type                     = "ingress"
      from_port                = 8000,
      to_port                  = 8000,
      source_security_group_id = module.ecs_alb.security_group_id
    },
    outbound = {
      type        = "egress"
      from_port   = 0,
      to_port     = 65536,
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


################################################################################
# Aurora RDS Module
################################################################################
module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.9.0"

  name            = "uptime-postgres"
  engine          = "aurora-postgresql"
  engine_version  = "14.7"
  master_username = "root"
  storage_type    = "aurora-iopt1"
  instances = {
    reader-1 = {
      instance_class      = "db.r5.2xlarge"
      publicly_accessible = false
      availability_zone   = "eu-west-1c"
    }
    reader-2 = {
      instance_class      = "db.r5.2xlarge"
      publicly_accessible = false
      availability_zone   = "eu-west-1b"
    }
  }

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  apply_immediately   = true
  skip_final_snapshot = true

  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = "uptime-postgres"
  db_cluster_parameter_group_family      = "aurora-postgresql14"
  db_cluster_parameter_group_description = "sample parameter group"
  db_cluster_parameter_group_parameters = [
    {
      name         = "log_min_duration_statement"
      value        = 4000
      apply_method = "immediate"
      }, {
      name         = "rds.force_ssl"
      value        = 1
      apply_method = "immediate"
    }
  ]

  performance_insights_enabled = true
  iam_role_name                = "uptime-service-rds-monitoring"

  enabled_cloudwatch_logs_exports = ["postgresql"]
  create_cloudwatch_log_group     = true
}


################################################################################
# VPC Module
################################################################################
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v5.12.1"

  name = "sample-vpc"
  cidr = local.vpc_cidr

  azs = local.azs

  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  tags = {
    "Component" = "network"
  }
}
