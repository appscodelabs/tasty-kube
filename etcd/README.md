```console
# Start etcd manager
./etcd-manager --address 127.0.0.1 --cluster-name=test --backup-store=file:///tmp/etcd-manager/backups/test --data-dir=/tmp/etcd-manager/data/test/1 --client-urls=http://127.0.0.1:4001 --quarantine-client-urls=http://127.0.0.1:8001

# Seed cluster creation
./etcd-manager-ctl --members=1 --backup-store=file:///tmp/etcd-manager/backups/test --etcd-version=3.2.18
```
