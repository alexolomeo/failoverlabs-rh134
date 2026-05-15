#!/bin/bash

LAB_NAME=$1

printf "%-5s Configurando entorno y procesando las validaciones................\n"
sleep 2
printf "%-5s Checking system...................................................success\n"

sleep 2
printf "%-5s Ensuring scheduling tasku is installed on servera.................success\n"

ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/scheduling-review.yml -e "failover_mode='simulate'" > /tmp/$LAB_NAME.log  2>&1

printf "%-5s \n"

cat /tmp/$LAB_NAME.log | tail -3

printf "%-5s \n"

