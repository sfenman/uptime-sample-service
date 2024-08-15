<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.61 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.cpu_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.memory_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Whether to assign a public IP to the service | `bool` | `false` | no |
| <a name="input_autoscaling_cpu_target_value"></a> [autoscaling\_cpu\_target\_value](#input\_autoscaling\_cpu\_target\_value) | The target value for CPU utilization autoscaling | `number` | `null` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | The maximum capacity of the service for autoscaling | `number` | `null` | no |
| <a name="input_autoscaling_memory_target_value"></a> [autoscaling\_memory\_target\_value](#input\_autoscaling\_memory\_target\_value) | The target value for memory utilization autoscaling | `number` | `null` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | The minimum capacity of the service for autoscaling | `number` | `null` | no |
| <a name="input_capacity_provider_strategy"></a> [capacity\_provider\_strategy](#input\_capacity\_provider\_strategy) | Capacity provider strategy | `list(any)` | `[]` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | The cluster where the service will be run | `string` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name of the container | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port of the container | `number` | `null` | no |
| <a name="input_create_autoscaling"></a> [create\_autoscaling](#input\_create\_autoscaling) | Flag to enable or disable autoscaling | `bool` | `false` | no |
| <a name="input_create_autoscaling_cpu"></a> [create\_autoscaling\_cpu](#input\_create\_autoscaling\_cpu) | Flag to enable or disable CPU-based autoscaling | `bool` | `false` | no |
| <a name="input_create_autoscaling_memory"></a> [create\_autoscaling\_memory](#input\_create\_autoscaling\_memory) | Flag to enable or disable memory-based autoscaling | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines whether to create security group for RDS cluster | `bool` | `true` | no |
| <a name="input_deployment_controller_type"></a> [deployment\_controller\_type](#input\_deployment\_controller\_type) | Deployment controller type: CODE\_DEPLOY or ECS. Default: ECS | `string` | `null` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | Upper limit (percentage of desired\_count) of running tasks that can be running in a service during a deployment | `number` | `null` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | Lower limit (pct of desired\_count) of running tasks that must remain running and healthy in a service during a deployment | `number` | `null` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Number of instances of the task to place and keep running | `number` | `0` | no |
| <a name="input_ecs_fargate_spot"></a> [ecs\_fargate\_spot](#input\_ecs\_fargate\_spot) | If true, a capacity provider strategy will be applied | `bool` | `false` | no |
| <a name="input_enable_ecs_managed_tags"></a> [enable\_ecs\_managed\_tags](#input\_enable\_ecs\_managed\_tags) | Enable Amazon ECS managed tags for the tasks within the service | `bool` | `true` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Whether to use AWS Container exec command in the service | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown | `number` | `null` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type definition (EC2 or FARGATE) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of ecs service | `string` | `null` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | Only for fargate.Default is latest | `string` | `null` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Whether to propagate tags from task definition or service to tasks: SERVICE or TASK\_DEFINITION | `string` | `null` | no |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | REPLICA OR DAEMON | `string` | `"REPLICA"` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group. If value is set to empty string it will contain cluster name in the description | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The security group name. Default value is (`var.name`) | `string` | `""` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Map of security group rules to add to the cluster security group created | `any` | `{}` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Extra SGs to add | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs of the service | `list(string)` | `[]` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The target group ARN for the load balancer | `string` | `null` | no |
| <a name="input_task_definition"></a> [task\_definition](#input\_task\_definition) | The task definition arn to create the service | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_cluster"></a> [ecs\_service\_cluster](#output\_ecs\_service\_cluster) | Cluster ARN |
| <a name="output_ecs_service_id"></a> [ecs\_service\_id](#output\_ecs\_service\_id) | Service ARN |
| <a name="output_ecs_service_name"></a> [ecs\_service\_name](#output\_ecs\_service\_name) | Service name |
<!-- END_TF_DOCS -->