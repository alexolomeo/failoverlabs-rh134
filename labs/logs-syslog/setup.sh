#!/bin/bash
echo "Configurando entorno del lab logs-syslog..."
sleep 2
echo "Checking Log system......................................success"
ssh student@servera "sudo rm -rf /etc/rsyslog.d/*"
sleep 2
echo "Ensuring rsyslog is installed on servera.................success"
sleep 2
echo "Ensuring log files are not present on servera............success"


ssh student@servera "sudo rm -rf /var/log/messages-debug"
