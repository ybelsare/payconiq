# payconiq
# Github
https://github.com/ybelsare/payconiq.git

# Structure
payconiq
    - terraform-eks             -- Terraform code to create the eks cluster
    - terraform-helm-nginx      -- Terraform code to deploy the nginx webserver to the cluster
    - cluster-aws-eks           -- Ansible code to deploy wordpress and mysql 
        - vars
            - main.yml          -- Configuration file for the eks cluster
            - wordpress
                - mysql.yml     -- k8s deployment file for mysql
                - wordpress.yml -- k8s deployment file for wordpress
        deploy.yml              -- deploys the wordpress and mysql application
        delete.yml              -- clean up the wordpress and mysql

# Objective
Create a k8s cluster on amazon eks - Created using Terraform
Deploy a stateless application - Deployed nginx using Terraform and Helm charts
Deploy a stateful application  - Deployed mysql and wordpress using Ansible

# Pre Requisites
0) Install terraform .
1) Install AWS CLI 
    Configure AWS CLI by the command . NOTE - The secret will be send by email seperately 
    $ AWS configure
    verify by
    $ aws configure list
2) Install AWS IAM Authenticator 
3) Install kubectl . (verify by using some kubectl commands)
4) Add all of the above in $PATH
5) setup your kubeconfig file by the command update-kubeconfig where terraform-eks-demo is the name of the  cluster.
   by default this file is in ~/.kube/config.
   Config file for this assignment is added in the github repository . Copy it in your ~/.kube folder
   
   $ aws eks update-kubeconfig --name terraform-eks-demo

# Steps
1) Clone the above mentioned repository from the develop branch
2) Navigate to the folder payconiq
# Create the eks cluster    
3) Navigate to the terraform-eks folder
4) run the following commands
    $ terraform init (- This will download all the required plugins and modules)
    $ terraform plan --out my.plan
    $ terraform apply "my.plan"

This will create a eks cluster . (NOTE - This will take approx 10 mins) with the following details
    Cluster name = terraform-eks-demo
    node         = demo

5) run terraform destroy to clean up 

# Deploy the stateless nginx application
1) Navigate to the folder terraform-helm-nginx folder
2) run the following commands
    $ terraform init (- This will download all the required plugins and modules)
    $ terraform plan --out my.plan
    $ terraform apply "my.plan"
This will deploy the nginx webserver on the eks cluster listening on port 80

# Deploy the stateful application wordpress
1) navigate to the cluster-aws-eks folder
2) verify that vars/main.yml contains the correct configuration for the 

