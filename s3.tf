# Criando o bucket S3 para logs do Loki
resource "aws_s3_bucket" "loki_logs" {
  bucket = "loki-logs-bucket"
  acl    = "private"
  tags = { Name = "loki-logs" }
}