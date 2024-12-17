# IAM Policy for the Load Balancer Controller
resource "aws_iam_policy" "aws_load_balancer_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = data.aws_iam_policy_document.aws_load_balancer_controller.json
}

# IAM Policy Document for the Load Balancer Controller
data "aws_iam_policy_document" "aws_load_balancer_controller" {
  statement {
    actions   = ["sts:AssumeRoleWithWebIdentity"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eksctl-${var.cluster_name}-nodegroup-*"]

    condition {
      test     = "StringEquals"
      variable = "oidc.eks.${var.region}.amazonaws.com/id/${module.eks.cluster_oidc_issuer_url}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }
  }

  statement {
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eksctl-${var.cluster_name}-nodegroup-*"]
  }
}
