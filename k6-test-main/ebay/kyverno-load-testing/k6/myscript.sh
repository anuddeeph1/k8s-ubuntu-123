#!/usr/bin/bash

#alias kks="kubectl -n kube-system"

full() {
	podnames=$(kubectl -n kube-system get pods -o name | awk -F/ '{ print $NF }')

#rm -rf logs/*
#rm -f *.txt

#	for podname in $podnames
#	do
#		kubectl -n kube-system logs $podname -f >> logs/$podname.log &
#	done

	for i in 1000 2000 5000 10000 
	do 
		/home/azureuser/ebay/kyverno-load-testing/k6/start-ebay.sh tests/kyverno-pods-ebay.js $i 10000
		sleep 60
	done

	sleep 1m

	/home/azureuser/ebay/kyverno-load-testing/k6/start-ebay.sh tests/kyverno-pods-ebay.js 10000 100000
        
	truncate --size 0 logs/results.txt

	for i in kyverno-pods-ebay.js-1000vu-10000it-logs.txt kyverno-pods-ebay.js-2000vu-10000it-logs.txt kyverno-pods-ebay.js-5000vu-10000it-logs.txt kyverno-pods-ebay.js-10000vu-10000it-logs.txt kyverno-pods-ebay.js-10000vu-100000it-logs.txt
	do 
		echo -e "$i:\t$(cat $i | grep "http_req_duration..............:")" >> logs/results.txt
		grep "checks.........................:" $i >> logs/results.txt
	done

}


test1() {

	podnames=$(kubectl -n kube-system get pods -o name | awk -F/ '{ print $NF }')
	kypodnames=$(kubectl -n kyverno get pods -o name | grep kyverno-admission-controller | awk -F/ '{ print $NF }')

	for podname in $podnames
        do
                kubectl -n kube-system logs $podname -f >> logs/$podname.log &
        done

	for kypodname in $kypodnames
        do
                kubectl -n kyverno logs $kypodname  -c kyverno -f >> logs/$kypodname.log &
        done

	/home/azureuser/kyverno-load-testing/k6/start-ebay.sh tests/kyverno-pods-ebay.js 10000 100000
}


## main

#test1
full
