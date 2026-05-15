#!/bin/bash

LAB_NAME=$1

printf "%-5s Preparando el entorno del lab...\n"

ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/scheduling-review.yml -e "failover_mode='start'"  >  /tmp/scheduling-review.log  2>&1

sleep 2
printf "%-5s Checking  System...................................................success\n"

sleep 2
printf "%-5s Ensuring scheduling-review is installed on servera.................success\n"


sleep 2
printf "%-5s Ensuring and clean all scheduling task on servera..................success\n"


sleep 2
printf "%-5s Ensuring init config on servera....................................success\n"
printf "....................................................................................................\n"



cat /tmp/$LAB_NAME.log | tail -3


