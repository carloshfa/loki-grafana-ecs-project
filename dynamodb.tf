# Criando o DynamoDB para persistência do Grafana
resource "aws_dynamodb_table" "grafana" {
  name         = "grafana"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  attribute {
    name = "id"
    type = "S"
  }
  tags = { Name = "grafana-table" }
}
