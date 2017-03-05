#!/bin/bash

IP_ADDRESS=`ip route get 1 | awk '{print $NF;exit}'`

IFS=. read ip1 ip2 ip3 ip4 <<< "$IP_ADDRESS"

rm units/kube-routes.network

for i in `seq 1 254`; do
  if [ "${ip1}.${ip2}.${ip3}.${i}" != "${IP_ADDRESS}" ]; then
cat << EOF >> units/kube-routes.network
[Route]
Destination=10.244.${i}.0/24
Gateway=${ip1}.${ip2}.${ip3}.${i}
EOF
  fi
done
