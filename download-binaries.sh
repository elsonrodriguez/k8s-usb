#!/bin/bash

K8S_VERSION=${K8S_VERSION:-1.5.3}
DOCKER_VERSION=${DOCKER_VERSION:-1.12.1}
ETCD_VERSION=${ETCD_VERSION:-3.0.15}

mkdir -p bin
cd bin

curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl 
curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kube-apiserver
curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kube-controller-manager
curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kube-scheduler
curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubelet 
curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kube-proxy

curl -L -O https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz

mkdir -p dockerbin
tar -zxvf docker-${DOCKER_VERSION}.tgz --strip-components=1 -C dockerbin
sudo cp dockerbin/docker* .
rm -rf dockerbin
rm docker-${DOCKER_VERSION}.tgz 

curl -L -O https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
tar -zxvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
cp etcd-v${ETCD_VERSION}-linux-amd64/etcd* .
rm -rf etcd-v${ETCD_VERSION}-linux-amd64
rm etcd-v${ETCD_VERSION}-linux-amd64.tar.gz

chmod +x *
