resource "aws_security_group" "public_alb_sg" {
  name        = "${var.public_alb_name}_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "${var.public_alb_name}_sg"
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

resource "aws_lb_target_group" "public_alb_tg" {
  name        = "${var.public_alb_name}_tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "${var.public_alb_name}_tg"
  }
}

resource "aws_lb_listener" "public_alb_listener_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}

resource "aws_lb_listener" "public_alb_listener_https" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_alb_tg.arn
  }
}


resource "aws_security_group" "private_alb_sg" {
  name        = "${var.private_alb_name}_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_eks_cidr, var.private_eks_cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.api_gateway_cidr, var.public_eks_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.private_alb_name}_sg"
  }
}

resource "aws_lb" "private_alb" {
  name               = var.private_alb_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_alb_sg.id]
  subnets            = [var.private_subnet1, var.private_subnet2]
  enable_deletion_protection = false
  tags = {
    Name = var.private_alb_name
  }
}

resource "aws_lb_target_group" "private_alb_tg" {
  name        = "${var.private_alb_name}_tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/health"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "${var.private_alb_name}_tg"
  }
}

resource "aws_lb_listener" "private_alb_listener_https" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_alb_tg.arn
  }
}

# Deploy services to EKS and associate with ALBs

resource "kubernetes_service" "public_service" {
  metadata {
    name      = "public-service"
    namespace = "default"
    labels = {
      app = "public-service"
    }
  }

  spec {
    selector = {
      app = "public-service"
    }

    type = "LoadBalancer"
    ports {
      port        = 80
      target_port = 8080
    }
  }
}

resource "kubernetes_service" "private_service" {
  metadata {
    name      = "private-service"
    namespace = "default"
    labels = {
      app = "private-service"
    }
  }

  spec {
    selector = {
      app = "private-service"
    }

    type = "LoadBalancer"
    ports {
      port        = 80
      target_port = 8080
    }
  }
}

output "public_alb_dns" {
  value = aws_lb.public_alb.dns_name
}

output "private_alb_dns" {
  value = aws_lb.private_alb.dns_name
}
