# Criando o Cluster ECS
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster"
}

# Atualizando Task Definition do Loki para salvar logs no S3
resource "aws_ecs_task_definition" "loki" {
  family                   = "loki-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([
    {
      name      = "loki"
      image     = "grafana/loki:latest"
      memory    = 1024
      cpu       = 512
      essential = true
      portMappings = [{
        containerPort = 9092
        hostPort      = 9092
      }],
      environment = [
        { name = "LOKI_STORAGE_S3_BUCKET", value = "${aws_s3_bucket.loki_logs.bucket}" }
      ]
    }
  ])
}


output "s3_bucket_logs" {
  value = aws_s3_bucket.loki_logs.bucket
}

# Atualizando Task Definition do Grafana para usar o DynamoDB
resource "aws_ecs_task_definition" "grafana" {
  family                   = "grafana-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([
    {
      name      = "grafana"
      image     = "grafana/grafana:latest"
      memory    = 1024
      cpu       = 512
      essential = true
      portMappings = [{
        containerPort = 9091
        hostPort      = 9091
      }],
      environment = [
        { name = "GF_SECURITY_ADMIN_USER", value = "admin" },
        { name = "GF_SECURITY_ADMIN_PASSWORD", value = "SuperSecreto123!" },
        { name = "GF_DATABASE_TYPE", value = "dynamodb" },
        { name = "GF_DATABASE_DYNAMODB_TABLE", value = "grafana" }
      ]
    }
  ])
}

output "grafana_url" {
  value = aws_lb.ecs_lb.dns_name
}