resource "eks_service_account" "aws_load_balancer_controller" {
  name      = "aws-load-balancer-controller"
  namespace = "kube-system"
  cluster   = var.cluster_name
  role_arn  = aws_iam_role.aws_load_balancer_controller.arn
}
