#!/bin/bash

Usage() {
cat << EOF
ansible-add-host usage:
  -h: host ip
  -u: user
  -p: password
EOF
}

while getopts h:u:p: opt; do
  case $opt in
    h)
      host=$OPTARG
      ;;
    u)
      user=$OPTARG
      ;;
    p)
      passwd=$OPTARG
      ;;
    ?)
      Usage
      exit
      ;;
  esac
done
[ ! "$host" ] || [ ! "$user" ] || [ ! "$passwd" ] && Usage && exit

sshpass -p $passwd ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no $user@$host > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "ansible-add-host $host successfully"
else
  echo -e "\033[31m ansible-add-host $host unsuccessfully \033[0m"
fi

