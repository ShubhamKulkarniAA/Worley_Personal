resource "aws_security_group" "public_alb_sg" {
  name        = "${var.public_alb_name}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.public_alb_name}-sg"
  }
}

resource "aws_lb" "public_alb" {
  name               = var.public_alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb_sg.id]
  subnets            = [var.public_subnet1, var.public_subnet2]
  enable_deletion_protection = false

  tags = {
    Name = var.public_alb_name
  }
}

resource "aws_lb_target_group" "frontend_tg" {
  name        = "${var.public_alb_name}-frontend-tg"
  port        = 80  # Adjust according to your frontend port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"  # Adjust according to your frontend health check
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "${var.public_alb_name}-frontend-tg"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name        = "${var.public_alb_name}-backend-tg"
  port        = 5000  # Adjust according to your backend port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/api/health"  # Adjust according to your backend health endpoint
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "${var.public_alb_name}-backend-tg"
  }
}

resource "aws_lb_listener" "public_alb_listener_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn  # Default to frontend
  }
}

resource "aws_lb_listener_rule" "frontend_rule" {
  listener_arn = aws_lb_listener.public_alb_listener_http.arn
  priority      = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]  # Matches only the root path
    }
  }
}

resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.public_alb_listener_http.arn
  priority      = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]  # Matches all API requests
    }
  }
}

resource "aws_api_gateway_rest_api" "public_api" {
  name = "Public-ALB-API"
}

resource "aws_api_gateway_resource" "public_proxy" {
  rest_api_id = aws_api_gateway_rest_api.public_api.id
  parent_id   = aws_api_gateway_rest_api.public_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "public_proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.public_api.id
  resource_id   = aws_api_gateway_resource.public_proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "public_proxy_integration" {
  rest_api_id = aws_api_gateway_rest_api.public_api.id
  resource_id = aws_api_gateway_resource.public_proxy.id
  http_method = aws_api_gateway_method.public_proxy_method.http_method
  type        = "HTTP_PROXY"

  integration_http_method = "ANY"
  uri                     = "http://${aws_lb.public_alb.dns_name}/{proxy}"

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}
