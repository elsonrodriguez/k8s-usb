#!/bin/bash -x
cp bin/{kubelet,kube-proxy,docker*} /usr/bin

cp units/{kubelet.service,kube-proxy.service,docker.service} /etc/systemd/system/

./generate-kube-routes.sh
cp units/kube-routes.network /etc/systemd/network

mkdir -p /etc/kubernetes/node
mkdir -p /etc/kubernetes/manifests

cp conf/{kubelet.conf,kube-proxy.conf} /etc/kubernetes/node

if [ -n "${1}" ]; then
  echo "Overriding default master URL"
  sed -i "/http:\/\/master/s/master/$1/" /etc/kubernetes/node/kubelet.conf
  sed -i "/http:\/\/master/s/\/master/\/$1/" /etc/kubernetes/node/kube-proxy.conf
fi


IP_ADDRESS=`ip route get 1 | awk '{print $NF;exit}'`

IFS=. read ip1 ip2 ip3 ip4 <<< "$IP_ADDRESS"

POD_CIDR="10.244.$ip4.1/24"

sed -i "s/POD_CIDR/${POD_CIDR}/" /etc/systemd/system/docker.service

systemctl daemon-reload
systemctl restart systemd-networkd
systemctl enable docker kubelet kube-proxy
systemctl start docker kubelet kube-proxy
