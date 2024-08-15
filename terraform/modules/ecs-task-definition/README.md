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
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_task_definition.task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy_attachment.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to store the logs | `string` | `""` | no |
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | Command for container | `list(string)` | `null` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | Total number of cpu units used by container: 128 to 10240 | `number` | `null` | no |
| <a name="input_container_depends_on"></a> [container\_depends\_on](#input\_container\_depends\_on) | The dependencies defined for container startup and shutdown. | <pre>list(object({<br>    containerName = string<br>    condition     = string<br>  }))</pre> | `null` | no |
| <a name="input_container_docker_labels"></a> [container\_docker\_labels](#input\_container\_docker\_labels) | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| <a name="input_container_entrypoint"></a> [container\_entrypoint](#input\_container\_entrypoint) | Entrypoint for container | `list(string)` | `null` | no |
| <a name="input_container_environment"></a> [container\_environment](#input\_container\_environment) | The environment variables to pass to the container. This is a list of maps | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_container_environment_files"></a> [container\_environment\_files](#input\_container\_environment\_files) | The environment files to pass to the container (eg. from s3). This is a list of maps | <pre>list(object({<br>    value = string<br>    type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_container_essential"></a> [container\_essential](#input\_container\_essential) | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. | `bool` | `null` | no |
| <a name="input_container_extra_hosts"></a> [container\_extra\_hosts](#input\_container\_extra\_hosts) | extra hosts to pass in /etc/hosts of the container | <pre>list(object({<br>    ipAddress = string<br>    hostname  = string<br>  }))</pre> | `null` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Container image | `string` | `null` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | Amount in MiB of memory used by container | `number` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Container name | `string` | `null` | no |
| <a name="input_container_port_mappings"></a> [container\_port\_mappings](#input\_container\_port\_mappings) | host and container port. for fargate this can be left blank or the same port with container port | <pre>list(object({<br>    containerPort = number<br>    hostPort      = number<br>    protocol      = string<br>  }))</pre> | `null` | no |
| <a name="input_container_secrets"></a> [container\_secrets](#input\_container\_secrets) | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU used by the task | `number` | `null` | no |
| <a name="input_create_log_group"></a> [create\_log\_group](#input\_create\_log\_group) | Whether to create a log group resource | `bool` | `true` | no |
| <a name="input_create_task_execution_iam_role"></a> [create\_task\_execution\_iam\_role](#input\_create\_task\_execution\_iam\_role) | Flag to determine whether to create the ECS task execution IAM role. | `bool` | `true` | no |
| <a name="input_create_tasks_iam_role"></a> [create\_tasks\_iam\_role](#input\_create\_tasks\_iam\_role) | Flag to determine whether to create the ECS tasks IAM role. | `bool` | `true` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | IAM service role for container agent and the Docker daemon | `string` | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_family"></a> [family](#input\_family) | Task definition name | `string` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the KMS to encrypt log data | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory used by the task | `number` | `null` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Network mode of the service. For fargate this is always awsvpc | `string` | `"awsvpc"` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | Launch types required by task: EC2 or FARGATE | `list(string)` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the numbers to retain logs | `number` | `0` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | If true terraform doesn't delete the resource but removes it from state | `bool` | `false` | no |
| <a name="input_task_execution_role_name"></a> [task\_execution\_role\_name](#input\_task\_execution\_role\_name) | The name of the IAM role for ECS task execution. | `string` | `null` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | IAM task role, similar to instance profile | `string` | `null` | no |
| <a name="input_tasks_iam_role_policies"></a> [tasks\_iam\_role\_policies](#input\_tasks\_iam\_role\_policies) | Map of IAM role policy ARNs to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_tasks_role_description"></a> [tasks\_role\_description](#input\_tasks\_role\_description) | The description of the IAM role for ECS tasks. | `string` | `null` | no |
| <a name="input_tasks_role_name"></a> [tasks\_role\_name](#input\_tasks\_role\_name) | The name of the IAM role for ECS tasks. | `string` | `null` | no |
| <a name="input_volume"></a> [volume](#input\_volume) | List of volume blocks | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_taskdef_arn"></a> [ecs\_taskdef\_arn](#output\_ecs\_taskdef\_arn) | Task definition arn |
| <a name="output_ecs_taskdef_family"></a> [ecs\_taskdef\_family](#output\_ecs\_taskdef\_family) | Task definition family |
| <a name="output_ecs_taskdef_revision"></a> [ecs\_taskdef\_revision](#output\_ecs\_taskdef\_revision) | Task definition revision |
<!-- END_TF_DOCS -->