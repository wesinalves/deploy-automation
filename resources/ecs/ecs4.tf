# ... existing code ...

data "template_file" "api_container_definitions" {
  template = file("templates/ecs/container-definitions.json.tpl")

  vars = {
    app_image         = var.ecr_image_api
    proxy_image       = var.ecr_image_proxy
    django_secret_key = var.django_secret_key
    db_host           = aws_db_instance.main.address
    db_name           = aws_db_instance.main.name
    db_user           = aws_db_instance.main.username
    db_pass           = aws_db_instance.main.password
    log_group_name    = aws_cloudwatch_log_group.ecs_task_logs.name
    log_group_region  = data.aws_region.current.name
    allowed_hosts     = "*"
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${local.prefix}-api"
  container_definitions    = data.template_file.api_container_definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.app_iam_role.arn
  volume {
    name = "static"
  }

  tags = local.common_tags
}