
## Deploy app-a & app-b

```
k apply -f app-b.yaml
k apply -f app-a.yaml
```

## Scale down app-a and see app-b to stop

```
k scale deploy/app-a --replicas=0
```

## Scale up app-a and see app-b to start

```
k scale deploy/app-a --replicas=1
```