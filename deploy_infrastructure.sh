#!/bin/bash
print_fn (){
    echo "======== $1 ========"
    echo ""
}

print_fn 'Creating Azure Kubernetes infrastructure'
cd terraform_azure
pwd
#terraform init
terraform apply -var 'prefix=az' -var 'location=eastus' -var 'kubernetes_client_id=c1cfa75d-7109-45f5-b93d-628e3115f158' -var 'kubernetes_client_secret=bd3ebc36-d6d4-43e6-8637-a9865c9a26ba' -auto-approve &

print_fn 'Creating AWS Kubernetes infrastructure'
cd ../terraform_aws
pwd
#terraform init
terraform apply -auto-approve

