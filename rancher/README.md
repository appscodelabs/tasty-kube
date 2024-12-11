# rancher trusted cert

- Issue cert using certbot
https://certbot.eff.org/instructions?ws=other&os=pip

- Install rancher in single node using "Bring Your Own Certificate, Signed by a Recognized CA"
https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/other-installation-methods/rancher-on-a-single-node-with-docker#option-c-bring-your-own-certificate-signed-by-a-recognized-ca

- `agent-tls-mode` - `system-store`
https://github.com/rancher/rancher/issues/46798#issuecomment-2307812655
