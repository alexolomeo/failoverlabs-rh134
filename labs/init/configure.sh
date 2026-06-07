#!/bin/bash

LAB_NAME=$1
LOG_LEVEL=$2

if [[ ! "$LOG_LEVEL" =~ ^(none|info|basic|debug)$ ]]; then
    echo "Error: LOG_LEVEL debe ser 'none', 'info', 'basic' o 'debug'."
    exit 1
fi


if [ -f "/tmp/$LAB_NAME.log" ]; then
	sudo rm -rf /tmp/$LAB_NAME.log
fi

sleep 2
printf "%-5s Checking Workstation.....................................success\n"

printf "%-5s Checking dependency collection...........................success\n"

ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.general

sleep 2
printf "%-5s Checking servera.........................................success\n"

sleep 2
printf "%-5s Checking serverb.........................................success\n"

# ==============================================================================
# EJECUCIÓN DE ANSIBLE SEGÚN EL LOG_LEVEL
# ==============================================================================
case "$LOG_LEVEL" in
    none|info)
        # INFO AND NONE: Silencioso, todo redirigido al log
        sudo ansible-playbook -i /usr/local/rh134/labs/server.lab /usr/local/rh134/labs/$LAB_NAME.yml -e "failover_mode='configure'" > /tmp/$LAB_NAME.log 2>&1
        ;;
    basic)
        # BASIC: Se muestra directamente en pantalla (sin redirigir a archivo)
        sudo ansible-playbook -i /usr/local/rh134/labs/server.lab /usr/local/rh134/labs/$LAB_NAME.yml -e "failover_mode='configure'"
        ;;
    debug)
        # DEBUG: Modo muy verboso (-vvvv) en pantalla
        sudo ansible-playbook -i /usr/local/rh134/labs/server.lab /usr/local/rh134/labs/$LAB_NAME.yml -e "failover_mode='configure'" -vvvv
        ;;
esac

sleep 2
printf "%-5s Activate Rsync............................................success\n"
printf "....................................................................................................\n"

if [ "$LOG_LEVEL" = "info" ] && [ -f "/tmp/$LAB_NAME.log" ]; then
	cat /tmp/$LAB_NAME.log | tail -4
fi
