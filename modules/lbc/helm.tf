resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  values = [
    <<-EOT
    clusterName: "${var.cluster_name}"
    serviceAccount:
      create: false
      name: "aws-load-balancer-controller"
    region: "${var.region}"
    vpcId: "${var.vpc_id}"
    EOT
  ]

  depends_on = [
    eks_service_account.aws_load_balancer_controller
  ]
}
