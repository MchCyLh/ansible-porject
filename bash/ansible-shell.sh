#!/bin/bash

Usage() {
cat << EOF
ansible-shell usage:
  -c: command line in shell
  -h: destination hosts, defined in /etc/ansible/hosts
EOF
}

while getopts c:h: opt; do
	case $opt in
		c)
			cmd=$OPTARG
			;;
		h)
			hosts=$OPTARG
			;;
		?)
			Usage
			exit
			;;
	esac
done
[ ! "$cmd" ] || [ ! "$hosts" ] && Usage && exit

#ap_path=$AP
#cat > $ap_path/ansible-shell.yml << EOF
#---
#- hosts: $hosts
#  roles:
#  - { role: ansible-shell, cmd: $cmd }
#EOF
#cd $ap_path && ansible-playbook ansible-shell.yml

ansible $hosts -m shell -a "$cmd"

