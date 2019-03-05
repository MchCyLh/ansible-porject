#!/bin/bash

default_batch_conf=$AP/global_vars/ansible-add-host-batch.conf
Usage() {
cat << EOF
ansible-add-host-batch usage:
  -f: batch configuration file with "host user passwd" format each line, default file: $default_batch_conf
EOF
}

while getopts f: opt; do
  case $opt in
    f)
      batch_conf=$OPTARG
      ;;
    ?)
      Usage
      exit
      ;;
  esac
done
: ${batch_conf:=$default_batch_conf}
[ ! -f $batch_conf ] && echo -e "\033[31m file missed:$batch_conf \033[0m" && exit

cat $batch_conf | while read host user passwd; do
  sshpass -p $passwd ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no $user@$host > /dev//null 2>&1
  if [ $? -eq 0 ]; then
    echo "ansible-add-host-batch $host successfully"
  else
    echo -e "\033[31m ansible-add-host-batch $host unsuccessfully \033[0m"
  fi
done

