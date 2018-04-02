#!/bin/bash
set -xe

ETCD_VER=v3.2.18

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/coreos/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

rm -f /opt/etcd-${ETCD_VER}-linux-amd64.tar.gz
rm -rf /opt/etcd-${ETCD_VER}-linux-amd64 && mkdir -p /opt/etcd-${ETCD_VER}-linux-amd64

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /opt/etcd-${ETCD_VER}-linux-amd64.tar.gz
tar xzvf /opt/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /opt/etcd-${ETCD_VER}-linux-amd64 --strip-components=1
rm -f /opt/etcd-${ETCD_VER}-linux-amd64.tar.gz

/opt/etcd-${ETCD_VER}-linux-amd64/etcd --version
<<COMMENT
etcd Version: 3.2.18
Git SHA: eddf599c6
Go Version: go1.8.7
Go OS/Arch: linux/amd64
COMMENT

ETCDCTL_API=3 /opt/etcd-${ETCD_VER}-linux-amd64/etcdctl version
<<COMMENT
etcdctl version: 3.2.18
API version: 3.2
COMMENT
