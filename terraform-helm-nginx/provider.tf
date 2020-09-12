provider "helm" {
  
  version = "~> 1.2.3"

  debug = true
  
  kubernetes {   
    load_config_file       = true
    config_path            = "~/.kube/config"  
  }  
