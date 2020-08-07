# Testing cert-manager

- Start off by generating you ca certificates using openssl.

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./ca.key -out ./ca.crt -subj "/CN=mongo/O=kubedb"
```

- Now create a ca-secret using the certificate files you have just generated.

```bash
kubectl create secret tls mongo-ca \
     --cert=ca.crt \
     --key=ca.key \
     --namespace=demo
```

Now, create an `Issuer` using the `ca-secret` you have just created. The `YAML` file looks like this:

```yaml
apiVersion: cert-manager.io/v1alpha2
kind: Issuer
metadata:
  name: mongo-ca-issuer
  namespace: demo
spec:
  ca:
    secretName: mongo-ca
```

```bash
$ kubectl get secrets -n demo
NAME                  TYPE                                  DATA   AGE
default-token-tgjlz   kubernetes.io/service-account-token   3      10m
mongo-ca              kubernetes.io/tls                     2      10m
mycert-tls            kubernetes.io/tls                     3      5m33s

$ kubectl view-secret -n demo mycert-tls
Multiple sub keys found. Specify another argument, one of:
-> ca.crt
-> tls.crt
-> tls.key

$ kubectl view-secret -n demo mycert-tls ca.crt
-----BEGIN CERTIFICATE-----
MIIDIzCCAgugAwIBAgIUfusT4Oj1uXMuUJ05AZG1gDz5px0wDQYJKoZIhvcNAQEL
BQAwITEOMAwGA1UEAwwFbW9uZ28xDzANBgNVBAoMBmt1YmVkYjAeFw0yMDA4MDcw
NDMyMzRaFw0yMTA4MDcwNDMyMzRaMCExDjAMBgNVBAMMBW1vbmdvMQ8wDQYDVQQK
DAZrdWJlZGIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDwVVSXBRME
rfXVu23cMqRoPr3JFGlIGxqgPzN+wlteOlTQptVkbt+qv44Lrk1n45AFvNe+dEpI
XLvt6B9dkJhDz34Cj4MwWeOekSJ2jmWxMSNArD4MoCCIyIq++4xYGBsf9Xx2Frtd
fvg9qp4QcLEmzqWh/w3TikNY2QZWe726BlatdugP7xxrJXG8E5Hi6xK9ukbsG+xd
DE0snXr++dp+qBaumo0hjGuS6QlErqAnm4LwPXxiZSRmGVGgtj0NmZD+jkI48UI8
Lfl9GCfbczcD3+ludlpNksnEQGpxABfhtYcw5357p+KJw5fVQjRdRzT5pZ/vtU3g
B+g83sWEBSVjAgMBAAGjUzBRMB0GA1UdDgQWBBSQjI2uKX0jicKnVo0EbQd8EFYI
NjAfBgNVHSMEGDAWgBSQjI2uKX0jicKnVo0EbQd8EFYINjAPBgNVHRMBAf8EBTAD
AQH/MA0GCSqGSIb3DQEBCwUAA4IBAQCCoY503sixXQ7246jLvU246wcc64ulTQGb
4oAdDOjK9b55sY/ZU+aBZXNwK50UNU1Nkp6z6KjBZcTWUDwwOad2/RSSSCitL+Tv
NBr+fH0y/qoQvLUxEJq/rMd/6s5r4bjcRO6m+hekr/L7KSISyrGspUVDHxdHlWOm
RR2azvXWAqNYGorm9fpeRjnCrIvMTRiR7yw0l/3HHRYsysOTkLd7CdIwIS75dk6P
TISRT+2N9H0O9wJZtbpgXwy3mLR/yXhd0y6XHI9f4NXTxnG6K480eaJf5ng8wktQ
HTUsNM2cNy69KwgxR0KA4H6mFEoPWlk8ojFTSxCIieWzsv95Pdm6
-----END CERTIFICATE-----

$ kubectl view-secret -n demo mycert-tls tls.crt
-----BEGIN CERTIFICATE-----
MIIDIDCCAgigAwIBAgIRAMokuhF5tBxEa7nVEE31BvYwDQYJKoZIhvcNAQELBQAw
ITEOMAwGA1UEAwwFbW9uZ28xDzANBgNVBAoMBmt1YmVkYjAeFw0yMDA4MDcwNDM3
MjFaFw0yMDExMDUwNDM3MjFaMAAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQCbRHPysERf3yzqAv+nkPOFnQPmCRSXYl99yKMwQtjKaByNN2y75PvvS8x0
2ezif+xMTRR1gpZUSKDNGxTeNdJnyhHhUD1hFbd4FctIpmxrDl8uewTK+ailr6d4
JcsZL/gMr4M6hZbcmuTf8Ypfi+6EITbwK4fKQd+tWZHgsVci0jChs2gSNqsQyuKg
1snlpop12o4mNsYVsJ2cbD7UWwp5lzLwM13wg5e31J1DUei2E2I73Yc1eFwy6/wf
vFZJv4NGR/bURBOsIBY+DoF7jQ+IcTW16U1LNtCiOndlhL45qluP7udrRndhwsb9
c8T20eWeoUNXHgQEPvSUsGb5nFF/AgMBAAGjdDByMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMB8GA1UdIwQYMBaAFJCMja4pfSOJwqdWjQRtB3wQVgg2MDEG
A1UdEQEB/wQnMCWCDSouZXhhbXBsZS5jb22CC2V4YW1wbGUuY29tggdmb28uY29t
MA0GCSqGSIb3DQEBCwUAA4IBAQCTcs6cN2oEPF5LKIsbzuVFrPexs7kg9kCzZ/wJ
cUsPUI2wVO4oEIuM7S0L3fCOTgouBM67jOpGG1kFYI7wLipAxKwpgamdcZ+M90yT
LYlmK7ZyjyYMeFBCL73+uYkaSGQmQkLGAfCA+RVbfUZ1lh0rgE+xRohedw0JaF67
LhB92qZW3WbHVPctMt/h7A5ZdF/5qdZ/R6uBTLG4jNX3/hSLD4d53R6xdTs4UDQS
PLhBM1W8TC5XEbeKzCm3tTeVRW/AIVL8Q6lHiAnlbidS7ETesODRcxK1yshyI31N
3Vt5Zzf4amAPNIip59OnjCi7v9DageWG+cX7C+jUGcVDDUzf
-----END CERTIFICATE-----

$ kubectl view-secret -n demo mycert-tls tls.key
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAm0Rz8rBEX98s6gL/p5DzhZ0D5gkUl2JffcijMELYymgcjTds
u+T770vMdNns4n/sTE0UdYKWVEigzRsU3jXSZ8oR4VA9YRW3eBXLSKZsaw5fLnsE
yvmopa+neCXLGS/4DK+DOoWW3Jrk3/GKX4vuhCE28CuHykHfrVmR4LFXItIwobNo
EjarEMrioNbJ5aaKddqOJjbGFbCdnGw+1FsKeZcy8DNd8IOXt9SdQ1HothNiO92H
NXhcMuv8H7xWSb+DRkf21EQTrCAWPg6Be40PiHE1telNSzbQojp3ZYS+Oapbj+7n
a0Z3YcLG/XPE9tHlnqFDVx4EBD70lLBm+ZxRfwIDAQABAoIBAGR5OnK8X7KOb7kK
sbcUVJGM1p4AGEQSE2sI75jmWPU5w+gaCpHYDrN+IFMpRmIXl6iUZH3aQD9QNEYl
lS5qM7qYB1P/IYj2jZ/2snJTx2rLhQpF7wcN4XU+IqfcBP5KjUBgPxIaqlIdJahI
3FsR6Qm1mKB3+soGMKEzifOVrqZHzcrqx/7+RsDFFy262Ycb0noFAslVAIrzmh9Q
QYXzb1VvpYwJ+4Kydz/9tXQGKrbGM0sNaQhDKQGUEu5lEEWpQpxO1NChZ1f6qlkN
V1lrDhYkXNyUwy5qwwrGcReTaaY3Bd2dG3QEnCV1npFZV+rK3adG3TBnmAYVjQpf
/bRYVckCgYEAx+TfnR5Ajf0tMT06kei0rHY2VPZ5qXd7JyGRCRxQjOiloi0LsqUl
iwWd4oQFu3/58eqWES1amJptJddgvODXZxff/vhFjsh18aY8lGHjMmH1jLG92u2S
pBcvA8ZNjHEdzFvRaDBJFbO0xVtVuitCnXiX0k0KbSPYvq3MfztYZFMCgYEAxtj9
bT6SACGtA4WuB92emMePVRdHwHWw992j/UVRg4G//oTfqCzs+Zy2UcAzBKu9AhWT
CXZGPKJbyUufodH640pQ5vRZmOdlJPBXKQ5GvgNarVCIe2UuYcNpBHqHbf5E+ock
CkRvuqglfO8f+/sap6Nt1L3qd2kUSHVbPtdYuKUCgYEAxAkhg+T3SkjQ2UlC93VQ
OxJzlj9icWBL1sSEiHrMRGSki7fBkSGFACIyBMOVG50WcrmtEot4HdDU2hevN40J
soEnm9W/4ZeWk7aEEsEtH2wSdDicCOiUt3hFE16XDvSgVJp3c8Zm5nGnByXbnQhv
/B8YRZZoc0CEf/vSYbTBqyECgYEAtI7SSAFZ536ssJcROJk3arlCYFycTZlQkTGT
t+Xap5QIt18GC5qHr/xp3P+uE96x6JOYiS35hxNSTw05LWIS85JGtgBI3zu2Lv2B
14jcGavICbonxAxTOniLAoMUOH97ORW/VwdfgNkv+SrVGySexnvyvguZPMaQoV7W
9M/sAvUCgYEAgwOs6LbzOwvH3fV4glIYkeppiQdKVA67uBYXm7Aelehx/7eS4OFO
8/KcE6EWFDi9pJmhPWeNWn1FEepEAveZ2+cjklRU93ge2Aa4vbXeqXifxGiGteAF
xT/LBlHkzIlNKjLphp/6SPmceDb5cRTZKOCC8wX+R28F07SuVIOgcBk=
-----END RSA PRIVATE KEY-----
```