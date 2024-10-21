# Public ALB Security Group
resource "aws_security_group" "public_alb_sg" {
  name   = "${var.public_alb_name}_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing HTTP traffic from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allowing HTTPS traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allowing all outbound traffic
  }

  tags = {
    Name = "${var.public_alb_name}_sg"
  }
}

# Public ALB
resource "aws_lb" "public_alb" {
  name               = var.public_alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb_sg.id]
  subnets            = var.public_subnets
  enable_deletion_protection = false

  tags = {
    Name = var.public_alb_name
  }
}

# Public ALB Target Group
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
   
  }

  tags = {
    Name = "${var.public_alb_name}_tg"
  }
}

# Public ALB Listener (HTTP) - Redirect HTTP to HTTPS
resource "aws_lb_listener" "public_alb_listener_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301" # Permanent redirect
    }
  }
}

# Public ALB Listener (HTTPS)
resource "aws_lb_listener" "public_alb_listener_https" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08" # AWS Recommended SSL Policy
  certificate_arn   = var.certificate_arn # SSL certificate from ACM

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_alb_tg.arn
  }
}

