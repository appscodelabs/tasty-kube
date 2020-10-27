# Headless Kubernetes Service

Kubernetes also supports DNS SRV (Service) records for named ports. If the my-service.my-ns Service has a port named http with the protocol set to TCP, you can do a DNS SRV query for `_http._tcp.my-service.my-ns` to discover the port number for http, as well as the IP address.

```
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
```


```
~/g/s/g/a/t/headless (master) $ kubectl exec -it web-0 bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl kubectl exec [POD] -- [COMMAND] instead.
root@web-0:/# dig -t SRV _web._tcp.nginx.default.svc.cluster.local

; <<>> DiG 9.10.3-P4-Ubuntu <<>> -t SRV _web._tcp.nginx.default.svc.cluster.local
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 33455
;; flags: qr aa rd; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 4
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;_web._tcp.nginx.default.svc.cluster.local. IN SRV

;; ANSWER SECTION:
_web._tcp.nginx.default.svc.cluster.local. 30 IN SRV 0 33 80 web-2.nginx.default.svc.cluster.local.
_web._tcp.nginx.default.svc.cluster.local. 30 IN SRV 0 33 80 web-0.nginx.default.svc.cluster.local.
_web._tcp.nginx.default.svc.cluster.local. 30 IN SRV 0 33 80 web-1.nginx.default.svc.cluster.local.

;; ADDITIONAL SECTION:
web-0.nginx.default.svc.cluster.local. 30 IN A	10.244.0.6
web-2.nginx.default.svc.cluster.local. 30 IN A	10.244.0.10
web-1.nginx.default.svc.cluster.local. 30 IN A	10.244.0.8

;; Query time: 1 msec
;; SERVER: 10.96.0.10#53(10.96.0.10)
;; WHEN: Tue Oct 27 09:33:11 UTC 2020
;; MSG SIZE  rcvd: 523

root@web-0:/# 
root@web-0:/# dig -t SRV _https._tcp.nginx.default.svc.cluster.local

; <<>> DiG 9.10.3-P4-Ubuntu <<>> -t SRV _https._tcp.nginx.default.svc.cluster.local
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 59768
;; flags: qr aa rd; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 4
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;_https._tcp.nginx.default.svc.cluster.local. IN	SRV

;; ANSWER SECTION:
_https._tcp.nginx.default.svc.cluster.local. 30	IN SRV 0 33 443 web-2.nginx.default.svc.cluster.local.
_https._tcp.nginx.default.svc.cluster.local. 30	IN SRV 0 33 443 web-0.nginx.default.svc.cluster.local.
_https._tcp.nginx.default.svc.cluster.local. 30	IN SRV 0 33 443 web-1.nginx.default.svc.cluster.local.

;; ADDITIONAL SECTION:
web-0.nginx.default.svc.cluster.local. 30 IN A	10.244.0.6
web-1.nginx.default.svc.cluster.local. 30 IN A	10.244.0.8
web-2.nginx.default.svc.cluster.local. 30 IN A	10.244.0.10

;; Query time: 0 msec
;; SERVER: 10.96.0.10#53(10.96.0.10)
;; WHEN: Tue Oct 27 09:33:17 UTC 2020
;; MSG SIZE  rcvd: 531

root@web-0:/# dig -t SRV nginx.default.svc.cluster.local

; <<>> DiG 9.10.3-P4-Ubuntu <<>> -t SRV nginx.default.svc.cluster.local
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 25066
;; flags: qr aa rd; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 4
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;nginx.default.svc.cluster.local. IN	SRV

;; ANSWER SECTION:
nginx.default.svc.cluster.local. 30 IN	SRV	0 16 443 web-2.nginx.default.svc.cluster.local.
nginx.default.svc.cluster.local. 30 IN	SRV	0 16 80 web-2.nginx.default.svc.cluster.local.
nginx.default.svc.cluster.local. 30 IN	SRV	0 16 443 web-0.nginx.default.svc.cluster.local.
nginx.default.svc.cluster.local. 30 IN	SRV	0 16 80 web-0.nginx.default.svc.cluster.local.
nginx.default.svc.cluster.local. 30 IN	SRV	0 16 443 web-1.nginx.default.svc.cluster.local.
nginx.default.svc.cluster.local. 30 IN	SRV	0 16 80 web-1.nginx.default.svc.cluster.local.

;; ADDITIONAL SECTION:
web-1.nginx.default.svc.cluster.local. 30 IN A	10.244.0.8
web-2.nginx.default.svc.cluster.local. 30 IN A	10.244.0.10
web-0.nginx.default.svc.cluster.local. 30 IN A	10.244.0.6

;; Query time: 0 msec
;; SERVER: 10.96.0.10#53(10.96.0.10)
;; WHEN: Tue Oct 27 09:33:59 UTC 2020
;; MSG SIZE  rcvd: 747

```