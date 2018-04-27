- How to use local docker images in minikube?

https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-in-kubernetes/42564211#42564211

```
minikube stop
minikube delete
minikube --memory 4096 --cpus 2 start
```

```
minikube config set kubernetes-version v1.9.0
minikube start
#############################################
minikube config unset
```
