#!/bin/bash

IP_ADDRESS=`ip route get 1 | awk '{print $NF;exit}'`

IFS=. read ip1 ip2 ip3 ip4 <<< "$IP_ADDRESS"

rm units/kube-routes.sh

echo "#!/bin/bash" > units/kube-routes.sh
echo "set +e" >> units/kube-routes.sh

for i in `seq 1 254`; do
  if [ "${ip1}.${ip2}.${ip3}.${i}" != "${IP_ADDRESS}" ]; then
cat << EOF >> units/kube-routes.sh
route add -net 10.244.${i}.0 netmask 255.255.255.0 gw ${ip1}.${ip2}.${ip3}.${i}
EOF
  fi
done

echo "exit 0" >> units/kube-routes.sh

