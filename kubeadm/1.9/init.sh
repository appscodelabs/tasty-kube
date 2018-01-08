#!/bin/bash
set -euxo pipefail
# log to /var/log/pharmer.log
exec > >(tee -a /var/log/pharmer.log)
exec 2>&1

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

exec_until_success() {
	$1
	while [ $? -ne 0 ]; do
		sleep 2
		$1
	done
}

# We rely on DNS for a lot, and it's just not worth doing a whole lot of startup work if this isn't ready yet.
# ref: https://github.com/kubernetes/kubernetes/blob/443908193d564736d02efdca4c9ba25caf1e96fb/cluster/gce/configure-vm.sh#L24
ensure_basic_networking() {
  until getent hosts $(hostname -f || echo _error_) &>/dev/null; do
    echo 'Waiting for functional DNS (trying to resolve my own FQDN)...'
    sleep 3
  done
  until getent hosts $(hostname -i || echo _error_) &>/dev/null; do
    echo 'Waiting for functional DNS (trying to resolve my own IP)...'
    sleep 3
  done

  echo "Networking functional on $(hostname) ($(hostname -i))"
}

ensure_basic_networking

# https://major.io/2016/05/05/preventing-ubuntu-16-04-starting-daemons-package-installed/
echo -e '#!/bin/bash\nexit 101' > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d

apt-get update -y
apt-get install -y apt-transport-https curl ca-certificates software-properties-common tzdata
curl -fsSL --retry 5 https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
exec_until_success 'add-apt-repository -y ppa:gluster/glusterfs-3.10'
apt-get update -y
exec_until_success 'apt-get install -y cron docker.io ebtables git glusterfs-client haveged jq nfs-common socat kubelet=1.9.0* kubectl=1.9.0* kubeadm=1.9.0* kubernetes-cni=0.6.0* ntp'

curl -fsSL --retry 5 -o pre-k https://cdn.appscode.com/binaries/pre-k/1.9.0-rc.0/pre-k-linux-amd64 \
	&& chmod +x pre-k \
	&& mv pre-k /usr/bin/

timedatectl set-timezone Etc/UTC


cat > /etc/systemd/system/kubelet.service.d/20-pharmer.conf <<EOF
[Service]
Environment="KUBELET_EXTRA_ARGS=--cloud-provider= --node-labels=cloud.appscode.com/pool=master "
EOF
systemctl daemon-reload
rm -rf /usr/sbin/policy-rc.d
systemctl enable docker kubelet nfs-utils
systemctl start docker kubelet nfs-utils

kubeadm reset

mkdir -p /etc/kubernetes/ccm
mkdir -p /etc/kubernetes/kubeadm
cat > /etc/kubernetes/kubeadm/base.yaml <<EOF
api:
  advertiseAddress: ""
  bindPort: 6443
apiServerExtraArgs:
  admission-control: NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,ValidatingAdmissionWebhook,ResourceQuota,DefaultTolerationSeconds,MutatingAdmissionWebhook
  kubelet-preferred-address-types: InternalIP,ExternalIP
apiVersion: kubeadm.k8s.io/v1alpha1
certificatesDir: ""
cloudProvider: ""
etcd:
  caFile: ""
  certFile: ""
  dataDir: ""
  endpoints: null
  image: ""
  keyFile: ""
imageRepository: ""
kind: MasterConfiguration
kubernetesVersion: v1.9.0
networking:
  dnsDomain: cluster.local
  podSubnet: 192.168.0.0/16
  serviceSubnet: 10.96.0.0/12
nodeName: ""
token: ""
tokenTTL: 0s
unifiedControlPlaneImage: ""

EOF

pre-k merge master-config \
  --config=/etc/kubernetes/kubeadm/base.yaml \
  --apiserver-advertise-address=$(pre-k machine public-ips --all=false) \
  --apiserver-cert-extra-sans=$(pre-k machine public-ips --routable) \
  --apiserver-cert-extra-sans=$(pre-k machine private-ips) \
  --node-name=${NODE_NAME:-} \
  > /etc/kubernetes/kubeadm/config.yaml
kubeadm init --config=/etc/kubernetes/kubeadm/config.yaml --skip-token-print

kubectl apply \
  -f https://raw.githubusercontent.com/pharmer/addons/master/calico/2.6/calico.yaml \
  --kubeconfig /etc/kubernetes/admin.conf

mkdir -p ~/.kube
sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
