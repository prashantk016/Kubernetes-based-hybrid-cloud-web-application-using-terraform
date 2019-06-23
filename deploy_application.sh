#!/bin/bash
print_fn (){
    echo "======== $1 ========"
    echo ""
}

# Azure Backend 
print_fn "Deploying backend to Azure"
cd terraform_azure
terraform output kube_config > ~/.kube/config
print_fn "Added Azure aks config to kubectl"
cd ..
pwd
cd kubernetes_azure
kubectl apply -f csye7220-backend-deployment.yaml
kubectl apply -f csye7220-backend-service.yaml
print_fn "Deployed backend on Azure aks"

# Waiting for external ip

backend_external_ip=$(kubectl get svc csye7220-yesno --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

while [ -z "$backend_external_ip" ] 
do 
    backend_external_ip=$(kubectl get svc csye7220-yesno --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
    echo "waiting for external ip ...."
    sleep 5s;
done
print_fn "Backend External IP : "
echo $backend_external_ip

# AWS frontend
print_fn "Deploying frontend to AWS"
cd ../terraform_aws
terraform output kubeconfig > ~/.kube/config
print_fn "Added AWS eks config to kubectl"
kubectl apply -f config_map_aws_auth.yaml
print_fn "Applied config_map_aws_auth.yaml"
cd ..
pwd
cd kubernetes_aws
kubectl create configmap my-config --from-literal=API_URL_FROM_CONF=http://$backend_external_ip/answer
kubectl apply -f csye7220-frontend-deployment.yaml
kubectl apply -f csye7220-frontend-service.yaml
print_fn "Deployed frontend on AWS eks"

frontend_external_ip=$(kubectl get svc csye7220-frontend --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')

print_fn "Front External IP : "
echo $front_external_ip

