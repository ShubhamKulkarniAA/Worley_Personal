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
    matcher             = "200"
  }

  tags = {
    Name = "${var.public_alb_name}_tg"
  }
}

# Public ALB Listener (HTTP)
resource "aws_lb_listener" "public_alb_listener_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_alb_tg.arn
  }
}

resource "aws_security_group" "private_alb_sg" {
  name   = "${var.private_alb_name}_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_eks_cidr, var.private_eks_cidr] 
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

# Private ALB Target Group
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

resource "aws_lb_listener" "private_alb_listener_http" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_alb_tg.arn
  }
}

module "eks_public" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.public_eks_name
  vpc_id          = var.vpc_id
  subnet_ids      = var.public_subnets
  cluster_security_group_id = [aws_security_group.public_eks_sg.id]
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

module "eks_private" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.private_eks_name
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets
  cluster_security_group_id = [aws_security_group.private_eks_sg.id]
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

resource "aws_lb" "public_alb" {
  name               = var.public_alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.public_alb_sg.id]
}

resource "aws_lb" "private_alb" {
  name               = var.private_alb_name
  internal           = true
  load_balancer_type = "application"
  subnets            = var.private_subnets
  security_groups    = [aws_security_group.private_alb_sg.id]
}

resource "aws_lb_listener" "public_alb_listener_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_alb_tg.arn
  }
}

resource "aws_lb_listener" "private_alb_listener_http" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_alb_tg.arn
  }
}

resource "aws_lb_target_group" "public_alb_tg" {
  name        = "${var.public_alb_name}_tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_target_group" "private_alb_tg" {
  name        = "${var.private_alb_name}_tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_api_gateway_rest_api" "private_api" {
  name = "${var.private_eks_name}-api"
  endpoint_configuration {
    types = ["PRIVATE"]
  }
}

resource "aws_api_gateway_resource" "eks_private_resource" {
  rest_api_id = aws_api_gateway_rest_api.private_api.id
  parent_id   = aws_api_gateway_rest_api.private_api.root_resource_id
  path_part   = "private-eks"
}

resource "aws_api_gateway_method" "eks_private_method" {
  rest_api_id   = aws_api_gateway_rest_api.private_api.id
  resource_id   = aws_api_gateway_resource.eks_private_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "private_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.private_api.id
  resource_id             = aws_api_gateway_resource.eks_private_resource.id
  http_method             = aws_api_gateway_method.eks_private_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "http://${aws_lb.private_alb.dns_name}/private-eks"
}
