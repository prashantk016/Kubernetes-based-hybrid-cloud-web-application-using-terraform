# CSYE7220_DevOps_Final_Project
_________
## Objectives:
Manage the infrastructure of a microservice app with kubernetes on AWS & Azure
– Run your nodes and pods across AWS and Azure
– Automate kubernetes infrastructure through az/aws/tf/juju
– Original Web app

## Description
Using terraform deploy kubernetes infrastructure on AWS (EKS) and Azure (AKS).
Hosting simple REST API backend on Azure AKS and Reactjs frontend on AWS EKS.
Project Structure is as seen below. Please read through all the instructions before starting.
```
.
├── deploy_application.sh
├── deploy_infrastructure.sh
├── kubernetes_aws
│   ├── csye7220-frontend-deployment.yaml
│   └── csye7220-frontend-service.yaml
├── kubernetes_azure
│   ├── csye7220-backend-deployment.yaml
│   └── csye7220-backend-service.yaml
├── LICENSE
├── react_frontend
│   ├── build
│   ├── docker-entrypoint.sh
│   ├── Dockerfile
│   ├── generate_config_js.sh
│   ├── node_modules
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   └── src
├── README.md
├── spring-boot_backend
│   ├── build.gradle
│   ├── Dockerfile
│   ├── gradle
│   ├── gradlew
│   ├── gradlew.bat
│   ├── manifest.yml
│   ├── mvnw
│   ├── mvnw.cmd
│   ├── pom.xml
│   ├── src
│   └── target
├── terraform_aws
│   ├── a-vpc-providers.tf
│   ├── a-vpc-variables.tf
│   ├── a-vpc-vpc.tf
│   ├── b-cluster-eks-cluster-iam.tf
│   ├── b-cluster-eks-cluster-sg.tf
│   ├── b-cluster-eks-cluster.tf
│   ├── c-nodes-eks-worker-nodes-asg.tf
│   ├── c-nodes-eks-worker-nodes-aslaunch.tf
│   ├── c-nodes-eks-worker-nodes-ds.tf
│   ├── c-nodes-eks-worker-nodes-iam.tf
│   ├── c-nodes-eks-worker-nodes-sg.tf
│   ├── config_map_aws_auth.yaml
│   ├── d-outputs.tf
│   ├── terraform.tfstate
│   └── terraform.tfstate.backup
└── terraform_azure
    ├── main.tf
    ├── outputs.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
````
Folder name and file names are quite self explanatory but I'll still give some overview.

__terraform\_aws, terraform\_azure__  => contains .tf scripts required for aws/azure to build kubernetes infrastructure on each platform
__kubernetes\_aw, kubernetes\_azure__ => contains yaml files for deploying frontend on azure kubernetes env and backend on aws kubernetes env
__deploy\_infractructure.sh__ => initiates and applys terraform on both aws and azure simultaneously
__deploy\_application.sh__ => uses kubectl to execute the application on both platforms
## Instructions

These instructions assumes you have your awscli, azure cli, kubeclt and terraform already setup on your machine. Skip step 2 and 3 if not on linux and manually run terraform apply in both terraform_* folder 
and apply yaml files in both kubernetes_* folder
1. Clone the repo
2. Run `deploy_infrastructure.sh`. Keep your azure appId and password ready.
You will be asked to enter the same on execution of script
3. Run `deploy_application.sh`. This will configure kubectl for aws and azure one at a time and deploy the respective application
4. Do `kubectl get svc` to get the external IP of the application

## @Author
Prashant Kabra