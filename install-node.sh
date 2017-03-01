#!/bin/bash -x
cp bin/{kubelet,kube-proxy} /usr/bin

cp units/{kubelet.service,kube-proxy.service} /etc/systemd/system/

mkdir -p /etc/kubernetes/node
mkdir -p /etc/kubernetes/manifests

cp conf/{kubelet.conf,kube-proxy.conf} /etc/kubernetes/node

if [ -n "${1}" ]; then
  echo "Overriding default master url"
  sed -i "/http:\/\/master/s/master/$1/" /etc/kubernetes/node/kubelet.conf
  sed -i "/http:\/\/master/s/\/master/\/$1/" /etc/kubernetes/node/kube-proxy.conf
fi

systemctl daemon-reload
systemctl enable kubelet kube-proxy 
systemctl start kubelet kube-proxy 
