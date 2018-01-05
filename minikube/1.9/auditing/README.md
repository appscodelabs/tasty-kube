- Restart minikube

```console
https://raw.githubusercontent.com/tamalsaha/tasty-kube/master/minikube/1.9/auditing/restart.sh
```

- Once minikube is running, ssh into the Minikube VM and run the following command:

```console
minikube ssh
sudo cp /tmp/files/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml
```

This will restart the kube apiserver.

- Now, if you check the `~/.minikube/files` on your host machine, you should see a `audit.log` file.

