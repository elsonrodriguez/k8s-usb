#stub

K8S_VERSION=${K8S_VERSION:-1.2.0}
curl -L -O https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/kubernetes.tar.gz -z kubernetes.tar.gz


ETCD_VERSION=2.3.0
curl -L -O https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz -z etcd-v$ETCD_VERSION-linux-amd64.tar.gz

