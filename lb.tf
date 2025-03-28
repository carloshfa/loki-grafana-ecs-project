# Criando um Load Balancer para expor Grafana
resource "aws_lb" "ecs_lb" {
  name               = "ecs-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets           = aws_subnet.public[*].id
  tags = { Name = "ecs-lb" }
}

resource "aws_lb_target_group" "grafana_tg" {
  name     = "grafana-tg"
  port     = 9091
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"
}

resource "aws_lb_listener" "grafana_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 9091
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.grafana_tg.arn
  }
}