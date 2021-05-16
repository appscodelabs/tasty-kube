# Multi-version CRD

```
$ kubectl get --raw=/apis/example.com | jq
{
  "kind": "APIGroup",
  "apiVersion": "v1",
  "name": "example.com",
  "versions": [
    {
      "groupVersion": "example.com/v1",
      "version": "v1"
    },
    {
      "groupVersion": "example.com/v1beta1",
      "version": "v1beta1"
    }
  ],
  "preferredVersion": {
    "groupVersion": "example.com/v1",
    "version": "v1"
  }
}
```

```
$ kubectl get --raw=/apis/example.com/v1 | jq
{
  "kind": "APIResourceList",
  "apiVersion": "v1",
  "groupVersion": "example.com/v1",
  "resources": [
    {
      "name": "crontabs",
      "singularName": "crontab",
      "namespaced": true,
      "kind": "CronTab",
      "verbs": [
        "delete",
        "deletecollection",
        "get",
        "list",
        "patch",
        "create",
        "update",
        "watch"
      ],
      "shortNames": [
        "ct"
      ],
      "storageVersionHash": "7Zf9gZVeNNw="
    }
  ]
}
```

# kubectl.kubernetes.io/last-applied-configuration keeps track of original version

```
$ kubectl apply -f my-versioned-crontab.yaml 
customresourcedefinition.apiextensions.k8s.io/crontabs.example.com created

$ kubectl apply -f cr.yaml 
crontab.example.com/mycron created

$ kubectl get crontab mycron
NAME     AGE
mycron   24s

$ kubectl get crontab mycron -o yaml
apiVersion: example.com/v1
kind: CronTab
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"example.com/v1beta1","kind":"CronTab","metadata":{"annotations":{},"name":"mycron","namespace":"default"},"spec":{"host":"company.com","port":"8080"}}
  creationTimestamp: "2021-05-16T06:44:04Z"
  generation: 1
  name: mycron
  namespace: default
  resourceVersion: "294119"
  uid: e90cce64-a6a5-4a1a-ad78-f654565c6960
spec:
  host: company.com
  port: "8080"
```
