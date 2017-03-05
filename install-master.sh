cp bin/{etcdctl,etcd,kubectl,kube-apiserver,kube-controller-manager,kube-scheduler} /usr/bin

cp units/{etcd.service,kube-apiserver.service,kube-controller-manager.service,kube-scheduler.service} /etc/systemd/system/

#Systemd routes not working, using hack for now
#./generate-kube-routes.sh
#cp units/kube-routes.network /etc/systemd/network
./generate-kube-routes-script.sh
cp units/kube-routes.service /etc/systemd/system/
cp units/kube-routes.sh /usr/local/bin
chmod +x /usr/local/bin/kube-routes.sh
systemctl enable kube-routes
systemctl start kube-routes

mkdir -p /etc/kubernetes/master
cp conf/{config.conf,apiserver.conf,controller-manager.conf,scheduler.conf} /etc/kubernetes/master

./generate-kube-routes.sh
cp units/kube-routes.network /etc/systemd/network

mkdir -p /etc/etcd
cp conf/etcd.conf /etc/etcd

openssl genrsa -out /srv/kubernetes/kube-serviceaccount.key

systemctl daemon-reload
systemctl enable etcd kube-apiserver kube-controller-manager kube-scheduler
systemctl start etcd kube-apiserver kube-controller-manager kube-scheduler

sleep 10

kubectl create -f kubernetes/
