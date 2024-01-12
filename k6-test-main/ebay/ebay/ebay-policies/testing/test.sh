#!/usr/bin/bash

#set -x

for count in {1..42}
do
	for i in *.yaml
	do

		polname=$(cat $i | grep -w "name:" | grep -v "\- name:" | awk '{ print $NF }')
		filename=$(echo $i | cut -d "." -f1)

		cat $i | sed "s/$polname/${polname}-${count}/g"  > 2x/${filename}-${count}.yaml
	done
done

for h in 2x/*.yaml
do 
	number=$(echo $h | cut -d "." -f1 | awk -F "-" '{print $NF}')
        echo "number: $number"

	sed -i "s/\brequire-drop-cap_net_raw\b/require-drop-cap_net_raw-$number/g;s/\brequire-drop-cap_net_bind_service\b/require-drop-cap_net_bind_service-$number/g;s/\brequire-drop-cap_setuid\b/require-drop-cap_setuid-$number/g;s/\brequire-drop-cap_setgid\b/require-drop-cap_setgid-$number/g;s/\brequire-drop-cap-sys_admin\b/require-drop-cap-sys_admin-$number/g;s/\brequire-drop-cap-net_admin\b/require-drop-cap-net_admin-$number/g;s/\brequire-drop-cap-AUDIT_CONTROL\b/require-drop-cap-AUDIT_CONTROL-$number/g;s/\brequire-drop-cap-AUDIT_READ\b/require-drop-cap-AUDIT_READ-$number/g;s/\brequire-drop-cap-BLOCK_SUSPEND\b/require-drop-cap-BLOCK_SUSPEND-$number/g;s/\brequire-drop-cap-BPF\b/require-drop-cap-BPF-$number/g;s/\brequire-drop-cap-CHECKPOINT_RESTORE\b/require-drop-cap-CHECKPOINT_RESTORE-$number/g;s/\brequire-drop-cap-DAC_READ_SEARCH\b/require-drop-cap-DAC_READ_SEARCH-$number/g;s/\brequire-drop-cap-IPC_LOCK\b/require-drop-cap-IPC_LOCK-$number/g;s/\brequire-drop-cap-IPC_OWNER\b/require-drop-cap-IPC_OWNER-$number/g;s/\brequire-drop-cap-LEASE\b/require-drop-cap-LEASE-$number/g;s/\brequire-drop-cap-LINUX_IMMUTABLE\b/require-drop-cap-LINUX_IMMUTABLE-$number/g;s/\brequire-drop-cap-MAC_ADMIN\b/require-drop-cap-MAC_ADMIN-$number/g;s/\brequire-drop-cap-MAC_OVERRIDE\b/require-drop-cap-MAC_OVERRIDE-$number/g;s/\brequire-drop-cap-NET_BROADCAST\b/require-drop-cap-NET_BROADCAST-$number/g;s/\brequire-drop-cap-PERFMON\b/require-drop-cap-PERFMON-$number/g;s/\brequire-drop-cap-SYS_BOOT\b/require-drop-cap-SYS_BOOT-$number/g;s/\brequire-drop-cap-SYS_MODULE\b/require-drop-cap-SYS_MODULE-$number/g;s/\brequire-drop-cap-SYS_NICE\b/require-drop-cap-SYS_NICE-$number/g;s/\brequire-drop-cap-SYS_PACCT\b/require-drop-cap-SYS_PACCT-$number/g;s/\brequire-drop-cap-SYS_PTRACE\b/require-drop-cap-SYS_PTRACE-$number/g;s/\brequire-drop-cap-SYS_RAWIO\b/require-drop-cap-SYS_RAWIO-$number/g;s/\brequire-drop-cap-SYS_RESOURCE\b/require-drop-cap-SYS_RESOURCE-$number/g;s/\brequire-drop-cap-SYS_TIME\b/require-drop-cap-SYS_TIME-$number/g;s/\brequire-drop-cap-SYS_TTY_CONFIG\b/require-drop-cap-SYS_TTY_CONFIG-$number/g;s/\brequire-drop-cap-SYSLOG\b/require-drop-cap-SYSLOG-$number/g;s/\brequire-drop-cap-WAKE_ALARM\b/require-drop-cap-WAKE_ALARM-$number/g;s/\bdisallow-host-ipc-namespace\b/disallow-host-ipc-namespace-$number/g;s/\bdisallow-host-network-namespace\b/disallow-host-network-namespace-$number/g;s/\bhost-path\b/host-path-$number/g;s/\bdisallow-host-pid-namespace\b/disallow-host-pid-namespace-$number/g;s/\bdisallow-host-ports-range\b/disallow-host-ports-range-$number/g;s/\bdisallow-host-ports\b/disallow-host-ports-$number/g;s/\bdisallow-privilege-escalation\b/disallow-privilege-escalation-$number/g;s/\bdisallow-privileged-containers\b/disallow-privileged-containers-$number/g;s/\bvalidate-readOnlyRootFilesystem\b/validate-readOnlyRootFilesystem-$number/g;s/\brun-as-non-root-user-id\b/run-as-non-root-user-id-$number/g;s/\brun-as-non-root\b/run-as-non-root-$number/g" $h 

	sed -i "s/\brun-asi-non-root\b/run-asi-non-root-$number/g" $h
	sed -i "s/\brestricted-volumess-hostpath\b/restricted-volumess-hostpath-$number/g" $h
	sed -i "s/restrictedtt-volumes/restrictedtt-volumes-$number/g" $h
	sed -i "s/disallow-host-rule-ports-range/disallow-host-rule-ports-range-$number/g" $h
	sed -i "s/disallow-rule-host-ports/disallow-rule-host-ports-$number/g" $h
	sed -i "s/run-rule-as-non-root-user-id/run-rule-as-non-root-user-id-$number/g" $h

done
