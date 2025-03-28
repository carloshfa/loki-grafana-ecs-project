# Criando o Secret no AWS Secrets Manager
resource "aws_secretsmanager_secret" "grafana_admin" {
  name = "grafana_admin_secret"
}

resource "aws_secretsmanager_secret_version" "grafana_admin_version" {
  secret_id     = aws_secretsmanager_secret.grafana_admin.id
  secret_string = jsonencode({
    admin_user     = "admin",
    admin_password = "SuperSecreto123!"
  })
}

# Permissão para ECS acessar o Secret Manager
resource "aws_iam_policy" "secrets_policy" {
  name   = "SecretsManagerAccess"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = "secretsmanager:GetSecretValue",
      Resource = aws_secretsmanager_secret.grafana_admin.arn
    }]
  })
}