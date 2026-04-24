#!/bin/bash

LAB_NAME=$1

rm -rf /tmp/$LAB_NAME.log

printf "%- Configurando dependencias ...\n"

sleep 2
printf "%-5s Checking Workstation.....................................success\n"

sleep 2
printf "%-5s Checking servera.........................................success\n"

sleep 2
printf "%-5s Checking serverb.........................................success\n"

ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/$LAB_NAME.yml -e "failover_mode='configurate'"  >  /tmp/$LAB_NAME.log  2>&1

sleep 2
printf "%-5s Activate Rsync............................................success\n"
printf "....................................................................................................\n"

cat /tmp/$LAB_NAME.log | tail -3
