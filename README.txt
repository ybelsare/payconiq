NOTES:
The eks cluster and the deployments are already done and will be present when you start to check this .
I have not cleaned up the resources in case you want to investigate what has been deployed .
There are 2 options
1) Cleanup everything using AWS console . terraform destroy command wont work as you will not have the 
.tfstate file 
2) Change the cluster name in variables.tf and create the cluster with your new name. 
In this case you will need to make sure that the kubectl update config command is run and
points to the new cluster . 
3) The kubectl config file i have supplied is for reference and will not work as it is . This contains
references to my folders
4) you can use the delete.yml to delete the wordpress and mysql configuration

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
7) VERY IMPORTANT :- setup your kubeconfig file by the command update-kubeconfig where terraform-eks-demo is the name of the  cluster.
   by default this file is in ~/.kube/config. 
   
   $ aws eks update-kubeconfig --name terraform-eks-demo


   IT IS RECOMMENDED THAT YOU KEEP THE CONFIG FILE 
   IN THE DEFAULT FOLDER . IN CASE YOU DECIDE ON ANY OTHER FOLDER THEN YOU WILL NEED TO CHANGE THE
   provider.tf TO POINT TO YOUR CONFIG FILE . ALSO YOU WILL NEED TO RUN kubectl SPECIFYING YOUR CONFIG FILE
   
   Config file for this assignment is added in the github repository . 
   
   
# Steps
Before starting verify that all pre requistes are met and all the tools are properly configured and operational
1) Clone the above mentioned repository from the develop branch
2) Navigate to the folder payconiq
3) To change the cluster name modify the file variables.tf and set the  variable "cluster-name" to
the cluster name you want
# Create the eks cluster    
3) Navigate to the terraform-eks folder
4) run the following commands
    $ terraform init (- This will download all the required plugins and modules)
    $ terraform plan --out my.plan
    $ terraform apply "my.plan"

This will create a eks cluster . (NOTE - This will take approx 10 mins) with the following details
    Cluster name = terraform-eks-demo
    node         = demo

5) run $ terraform destroy   to clean up
NOTE :- Terraform destroy might not work on your if you have do not have the proper .tfstate . In this case
destroy the clusters using aws console.

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

# Screenshots
(base) Yogesh-Belsares-MacBook:~ yogeshb$ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
nginx-7c76878bd-wg5pc              1/1     Running   0          3d15h
wordpress-6c8d7d9b5c-zf947         1/1     Running   0          2d16h
wordpress-mysql-5b697dbbfc-npwgh   1/1     Running   0          2d16h

(base) Yogesh-Belsares-MacBook:~ yogeshb$ kubectl get nodes
NAME                                       STATUS   ROLES    AGE     VERSION
ip-10-0-0-146.us-west-2.compute.internal   Ready    <none>   3d20h   v1.17.9-eks-4c6976

(base) Yogesh-Belsares-MacBook:~ yogeshb$ kubectl get svc
NAME              TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)                      AGE
kubernetes        ClusterIP      172.20.0.1       <none>                                                                    443/TCP                      3d20h
nginx             LoadBalancer   172.20.210.216   a32d51f92ef2e46d6a127dd9bf61020f-2135397906.us-west-2.elb.amazonaws.com   80:30515/TCP,443:32036/TCP   3d15h
wordpress         LoadBalancer   172.20.113.228   ab82a6df5efc54c38910585c497c3fbe-1823680208.us-west-2.elb.amazonaws.com   80:31611/TCP                 118s
wordpress-mysql   ClusterIP      None             <none>                                                                    3306/TCP                     2m7s


The word document shows the screenshots of the Running application in the browser
# Accessing the application
use the output of the $kubectl get svc command to access the application . see the output of the command
shown above and use the url mentioned in the EXTERNAL-IP column
For nginx
http://a32d51f92ef2e46d6a127dd9bf61020f-2135397906.us-west-2.elb.amazonaws.com/
For wordpress
http://ab82a6df5efc54c38910585c497c3fbe-1823680208.us-west-2.elb.amazonaws.com/

#Problems
Accessing the aws url sometimes resulted in too many redirects . Clearing the cache , cookies fixed
the issue . Need investigation on why this was happening .

# Credits
1) github/hashicorp     terraform examples
2) github/geerlingguy   k8s wordpress and my-sql deployments yml 