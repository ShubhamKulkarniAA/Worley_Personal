# Configure the Kubernetes provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Kubernetes Service Account for AWS Load Balancer Controller
resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lbc_role.arn
      "meta.helm.sh/release-name"  = "aws-load-balancer-controller"
      "meta.helm.sh/release-namespace" = "kube-system"
    }
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
    }
  }

}


# Helm Release for AWS Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"

  force_update = true  # Ensures that Helm forces an update if the version changes

  # Setting values for the Helm chart
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "serviceAccount.create"
    value = "false"  # Service account is already created in the above resource
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  replace = true  # Force Helm to replace existing resources if needed

  depends_on = [
    aws_iam_role_policy_attachment.lbc_custom_policy_attachment,
    kubernetes_service_account.aws_load_balancer_controller
  ]
}
