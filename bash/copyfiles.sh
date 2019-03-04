#!/bin/bash

Usage() {
	echo "copyfiles usage:
		-f: file list, eg. \"[ 'file1', 'file2' ]\", quota and spaces need
		-h: host list name, eg. testservers 
		-p: destination path, eg. /tmp/ansible 
		"
}

while getopts f:h:p: opt; do
	case $opt in
		f)
			file_list=$OPTARG
			;;
		h)
			hosts=$OPTARG
			;;
		p)
			dest_path=$OPTARG
			;;
		?)
			Usage
			exit
			;;
	esac
done


ap_path=$AP
copyfiles_vars_file=global_vars/copyfiles_vars
cat > $ap_path/copyfiles.yml << EOF
---
- hosts: $hosts
  vars_files: $copyfiles_vars_file
  roles:
    - { role: copyfiles }
EOF

cat > $ap_path/$copyfiles_vars_file << EOF
file_list: $file_list
dest_path: $dest_path
EOF

cd $ap_path && ansible-playbook copyfiles.yml

