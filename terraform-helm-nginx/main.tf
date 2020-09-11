resource "helm_release" "nginx" {
   
  repository = "https://charts.bitnami.com/bitnami"
  name       = "nginx"
  chart      = "nginx"  
}