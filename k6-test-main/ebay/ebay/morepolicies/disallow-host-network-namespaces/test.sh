#!/usr/bin/bash


for i in {22..641}; do 
    cp disallow-host-network-namespaces-dev-1.yaml disallow-host-network-namespaces-dev-$i.yaml; 
    sed -i "s/disallow-host-network-namespace-1-dev-1/disallow-host-network-namespace-1-dev-$i/g" disallow-host-network-namespaces-dev-$i.yaml;
    sed -i "s/disallow-host-network-namespace-1/disallow-host-network-namespace-$i/g" disallow-host-network-namespaces-dev-$i.yaml;
done

