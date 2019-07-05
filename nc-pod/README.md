# nc-pod

A simple [Kubernetes](https://kubernetes.io/) [Pod](https://kubernetes.io/docs/user-guide/pods/) that runs [netcat](http://netcat.sourceforge.net/) (nc) typically in the role of the
listening endpoint.  

The goal of this simple little Pod is to enable any number of Kubernetes 
networking configuration test scenarios.  From a simple intra-pod connectivity
test (show here), to any form of advanced networking configuration you can 
apply to Kubernetes Pods and more specifially, [Services](https://kubernetes.io/docs/user-guide/services/).  

## Building the Docker Image
Build and push the docker image, replacing the Samsung private Quay registry with your target registry.
```
$ docker build --rm --tag quay.io/samsung_cnct/nc-pod .
$ docker push quay.io/samsung_cnct/nc-pod:latest
```

## Helm Chart
This project might also end up being packaged as a Helm Chart eventually.  
However, it's pretty dead simple as is, and might not need to ever become a 
chart... we'll see.

## Configuration
Configuring 'nc' execution is handled by a single environment variable that 
captures the entire set of 'nc' command line arguments, but not the 'nc'
command itself.

For a complete description of 'nc' command line arguments see: [man nc(1)](https://linux.die.net/man/1/nc)

Environment Variable:
* NC_CMD_ARGS: Required, a quoted string of nc command line arguments.

Example (excerpt from [Deployment spec](https://kubernetes.io/docs/user-guide/deployments/#writing-a-deployment-spec) yaml):
```
    spec:
      containers:
      - name: nc-pod
        image: quay.io/samsung_cnct/nc-pod
        env:
        - name: NC_CMD_ARGS
          value: "-lk -n -u -p 26500"
``` 

## Deployment
Using the example nc-pod.yaml file's default values, the project is easily 
deployed as shown here:

```
$ kubectl create -f nc-pod.yaml
deployment "nc-pod" created

$ kubectl expose -f nc-pod.yaml 
service "nc-pod" exposed

$ kubectl get po,ep -l app=nc-pod
NAME                         READY     STATUS    RESTARTS   AGE
po/nc-pod-2355685321-3gd8r   1/1       Running   0          58s

NAME        ENDPOINTS          AGE
ep/nc-pod   10.64.0.23:26500   48s
```

## Running / Testing with netcat
From the example [Deployment](https://kubernetes.io/docs/user-guide/deployments/) above we tail the output of the created pod.
```
$ kubectl logs -f nc-pod-2355685321-3gd8r
cmd: /bin/nc -lk -n -u -p 26500 
```
We'll check back on the output of the 'logs' command after the next steps.

Since the service created by the default example isn't exposed via a public IP
address, we need to login to either a cluster node or pod.  Let's stay away 
from using the node, and stick to a pod.

```
$ kubectl run -i -t alps --image=alpine:latest --restart=Never --command /bin/ash
Waiting for pod default/alps to be running, status is Pending, pod ready: false
If you don't see a command prompt, try pressing enter.
/ # 
/ # nc -n -u 10.64.0.23 26500
Example of running netcat in a pod.
^Cpunt!

/ # exit
$ 
```
As soon as we hit ruturn on our input line above, we should have seen the 
following output scroll in our 'logs -f' terminal:
```
rastop:nc-pod sostheim$ kubectl logs -f nc-pod-2355685321-3gd8r
cmd: /bin/nc -lk -n -u -p 26500 
Example of running netcat in a pod.
```
