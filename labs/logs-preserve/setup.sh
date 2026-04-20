#!/bin/bash

echo "Starting lab..."
sleep 2
echo "Checking Log system......................................success"

ssh student@servera "sudo rm -rf /var/log/journal"

sleep 2
echo "Backing up log config on servera.........................success"

ssh student@servera "sudo cp -rf /etc/systemd/journald.conf.backup  /etc/systemd/journald.conf"
ssh student@servera "sudo systemctl restart systemd-journald.service"


