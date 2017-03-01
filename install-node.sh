cp bin/{kubectl,kube-proxy} /usr/bin

cp units/{kubelet.service,kube-proxy.service} /etc/systemd/system/

mkdir -p /etc/kubernetes/node
cp conf/{kubelet.conf,kube-proxy.conf} /etc/kubernetes/node

if [ -z "$1"] then
  sed -i "/http:\/\/master/s/master/$1/" /etc/kubernetes/kubelet.conf
  sed -i "/http:\/\/master/s/master/$1/" /etc/kubernetes/kube-proxy.conf
fi

systemctl daemon reload
systemctl enable kubelet kube-proxy 
systemctl start kubelet kube-proxy 
