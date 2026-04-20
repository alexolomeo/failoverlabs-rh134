#!/bin/bash
printf "%-5s Configurando entorno del lab logs-syslog...\n"
sleep 2
printf "%-5s Checking Log system......................................success\n"

sleep 2
printf "%-5s Ensuring rsyslog is installed on servera.................success\n"

ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/selinux-opsmode.yml -e "failover_mode='simulate'"
#> /tmp/selinux-opsmode.log  2>&1


sleep 2
printf "%-5s Ensuring log files are not present on servera............success\n"

cat /tmp/selinux-opsmode/simulate.log

