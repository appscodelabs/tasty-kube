
apt-get update
apt-get install net-tools
apt-get install dnsutils

Headless service (clusterIP: None) needs pod selector labels but not ports

pod-hostname.pod-subdomain.pod-namespace.svc.cluster.local

root@web-0:/# nslookup web-0.nginx.default.svc
Server:		10.96.0.10
Address:	10.96.0.10#53

Name:	web-0.nginx.default.svc.cluster.local
Address: 10.244.0.6

root@web-0:/# hostname -I
10.244.0.6 
