az aks get-credentials --resource-group RG-AKS --name AKSCNI

#View service principal for cluster
az aks show --resource-group RG-AKS --name AKSCNI --query servicePrincipalProfile.clientId
az ad sp show --id (az aks show --resource-group RG-AKS --name AKSCNI --query servicePrincipalProfile.clientId)

#Install kubectl then have to update path to include it
az aks install-cli

#Get basic info
kubectl cluster-info
kubectl get nodes

#Apply deployment
kubectl apply -f aks-badfather.yaml

#View information
kubectl get pods -o wide
kubectl get pods --show-labels
kubectl get service
kubectl describe svc azure-badfather-web1
#note the endpoints for the frontend points to the IP of the frontend pod IP
#this is the SERVICE in K8S, NOT the Azure Load Balancer
kubectl get endpoints azure-badfather-web1


#General other
kubectl get service --all-namespaces
#delete deployment
kubectl delete  -f aks-badfather.yaml