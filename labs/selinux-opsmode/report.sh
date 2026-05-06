#!/bin/bash


printf "%-5s Generando el reporte...\n"
sleep 2

ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/selinux-opsmode.yml -e "failover_mode='report'" 
#> /tmp/selinux-opsmode.log  2>&1


sleep 2
printf "%-5s Se genero correctamente el reporte en el servera............success\n"


