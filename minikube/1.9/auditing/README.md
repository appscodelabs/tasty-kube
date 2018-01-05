- Restart minikube

```console
curl -fsSL https://raw.githubusercontent.com/tamalsaha/tasty-kube/master/minikube/1.9/auditing/restart.sh | bash
```
This will download a pre-configured manifest of `kube-apiserver.yaml` and `audit-policy.yaml` file into the `~/.minikube/files` folder. Then `minikube` will mount this folder inside the Minikube VM as /tmp/files folder.

- Once minikube is running, ssh into the Minikube VM and run the following command:

```console
minikube ssh
# inside minikube vm
cp /tmp/files/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
```

This will restart the kube apiserver.

- Now, if you check the `~/.minikube/files` on your host machine, you should see a `audit.log` file.

