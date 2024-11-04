terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }
  }
}

resource "aws_iam_role" "aws_load_balancer_controller_role" {
  name = "${var.cluster_name}-lbc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lbc_policy_attachment" {
  policy_arn = "arn:aws:iam::484907523966:policy/LoadBalancerControllerPolicy"
  role       = aws_iam_role.aws_load_balancer_controller_role.name
}

# Service Account for Load Balancer Controller
resource "kubernetes_service_account" "lbc_service_account" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_load_balancer_controller_role.arn
    }
  }

  automount_service_account_token = true
}
