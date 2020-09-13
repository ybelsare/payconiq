# payconiq
# Github
https://github.com/ybelsare/payconiq.git

# Technologies
1) Terraform
2) Ansible
3) Helm

# Structure
* payconiq
*    - terraform-eks             -- Terraform code to create the eks cluster
*    - terraform-helm-nginx      -- Terraform code to deploy the nginx webserver to the cluster
*    - cluster-aws-eks           -- Ansible code to deploy wordpress and mysql 
*        - vars
*            - main.yml          -- Configuration file for the eks cluster
*            - wordpress
*                - mysql.yml     -- k8s deployment file for mysql
*                - wordpress.yml -- k8s deployment file for wordpress
*        deploy.yml              -- deploys the wordpress and mysql application
*        delete.yml              -- clean up the wordpress and mysql

# Objective
1) Create a k8s cluster on amazon eks - Created using Terraform
2) Deploy a stateless application - Deployed nginx using Terraform and Helm charts
3) Deploy a stateful application  - Deployed mysql and wordpress using Ansible

# Pre Requisites
1) Install Terraform .
2) Install Ansible 
3) Install AWS CLI.

    a) Configure AWS CLI by the command . NOTE - The secret will be send by email seperately 
    b) $ AWS configure
    c) verify by $ aws configure list
    
4) Install AWS IAM Authenticator 
5) Install kubectl . (verify by using some kubectl commands)
6) Add all of the above in $PATH
7) setup your kubeconfig file by the command update-kubeconfig where terraform-eks-demo is the name of the  cluster.
   by default this file is in ~/.kube/config.
   Config file for this assignment is added in the github repository . Copy it in your ~/.kube folder
   
   $ aws eks update-kubeconfig --name terraform-eks-demo

# Steps
Before starting verify that all pre requistes are met and all the tools are properly configured and operational
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
2) verify that vars/main.yml contains the correct configuration for the cluster
3) run the command $> ansible-playbook deploy.yml to create the wordpress deployment
4) run the command $> ansible-playbook delete.yml to clean up 

