#!/bin/bash

LAB_NAME=$1

printf "%-5s Generando el reporte...\n"
sleep 2

ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/$LAB_NAME.yml -e "failover_mode='report'" > /tmp/$LAB_NAME.log  2>&1


sleep 2
printf "%-5s Se genero correctamente el reporte de $LAB_NAME............success\n"


