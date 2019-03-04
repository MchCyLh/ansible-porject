#!/bin/bash

Usage() {
cat << EOF
ansible-copy usage:
  -s: source file or dir
  -h: destination hosts, defined in /etc/ansible/hosts
  -d: destination file or dir 
EOF
}

while getopts s:h:d: opt; do
	case $opt in
		s)
			src=$OPTARG
			;;
		h)
			hosts=$OPTARG
			;;
		d)
			dest=$OPTARG
			;;
		?)
			Usage
			exit
			;;
	esac
done
[ ! $src ] || [ ! $hosts ] || [ ! $dest ] && Usage && exit

ap_path=$AP
cat > $ap_path/ansible-copy.yml << EOF
---
- hosts: $hosts
  roles:
  - { role: ansible-copy, src: $src, dest: $dest }
EOF


cd $ap_path && ansible-playbook ansible-copy.yml

