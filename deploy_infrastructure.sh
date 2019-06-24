#!/bin/bash
print_fn (){
    echo "======== $1 ========"
    echo ""
}

print_fn 'Creating Azure Kubernetes infrastructure'
cd terraform_azure
pwd
terraform init
terraform apply -auto-approve &

print_fn 'Creating AWS Kubernetes infrastructure'
cd ../terraform_aws
pwd
terraform init
terraform apply -auto-approve

