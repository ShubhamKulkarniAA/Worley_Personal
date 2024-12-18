# Create IAM Role for AWS Load Balancer Controller
resource "aws_iam_role" "lbc_role" {
  name = "AWSLoadBalancerControllerRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : module.eks.oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${replace(module.eks.oidc_provider, "https://", "")}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

# Attach the IAM Policy to the LBC Role
resource "aws_iam_role_policy_attachment" "lbc_policy_attachment" {
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
  role       = aws_iam_role.lbc_role.name
}

# Deploy the AWS Load Balancer Controller Addon
resource "aws_eks_addon" "lbc" {
  cluster_name             = var.cluster_name
  addon_name               = "aws-load-balancer-controller"
  service_account_role_arn = aws_iam_role.lbc_role.arn

  depends_on = [
    aws_iam_role.lbc_role,
    aws_iam_role_policy_attachment.lbc_policy_attachment
  ]
}
