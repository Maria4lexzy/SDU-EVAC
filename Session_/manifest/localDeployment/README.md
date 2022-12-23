# sdu-evac


### Build container images

```console
//in \Frontend Folder 
 docker build -f Dockerfile --no-cache -t sdu-evac-frontend .

 //in \Backend Folder 
docker build -f Dockerfile --no-cache -t sdu-evac-backend .
```
### Start minikube and setup docker/insecure-registry

```console
minikube start --insecure-registry "10.0.0.0/24,192.168.39.0/24"
minikube addons enable registry

minikube ip

# edit /etc/docker/daemon.json
{
  ...
  "insecure-registries": [ "your-minikube-ip:5000" ]
  ...
}
```
### load images
**First create deployment and service files**
```console
minikube image load sdu-evac-frontend
minikube image load sdu-evac-backend
```
### create deployment

```console
kubectl create -f frontend-dep.yaml
kubectl create -f backend-dep.yaml
```
### check deployment status
```
kubectl get deployments
minikube  service service-name --url
```

### Install and set up helm

```console
choco install kubernetes-helm
helm repo add bitnami https://charts.bitnami.com/bitnami
```
### Install mongodb / redis

```console
helm install mongodb bitnami/mongodb --set image.tag=latest --set persistence.mountPath=/data/db --set image.repository=amd64/mongo
minikube image pull mongodb
```

```console
helm install redis bitnami/redis --set rchitecture=standalone --set auth.enabled=false
```

### Apply manifests

```console
kubectl apply -f ./Session/manifests
```
### Apply manifests

```console
 kubectl port-forward services/sdu-evac-backend 3000:80
 kubectl port-forward services/sdu-evac-frontend 8887:80
 minikube service sdu-evac-frontend --url
```

## Playbook 2

### Terraform apply

```console
 choco install terraformy
 
terraform -chdir=Session/terraform init
terraform -chdir=Session/terraform apply
```
