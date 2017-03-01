cp bin/{etcdctl,etcd,kubectl,kube-apiserver,kube-controller-manager,kube-scheduler} /usr/bin

cp units/{etcd.service,kube-apiserver.service,kube-controller-manager.service,kube-scheduler.service} /etc/systemd/system/

mkdir -p /etc/kubernetes/master
cp conf/{config.conf,apiserver.conf,controller-manager.conf,scheduler.conf} /etc/kubernetes/master

mkdir -p /etc/etcd
cp conf/etcd.conf /etc/etcd

openssl genrsa -out /srv/kubernetes/kube-serviceaccount.key

systemctl daemon-reload
systemctl enable etcd kube-apiserver kube-controller-manager kube-scheduler
systemctl start etcd kube-apiserver kube-controller-manager kube-scheduler
