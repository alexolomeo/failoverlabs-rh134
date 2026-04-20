#!/bin/bash

echo "Starting lab..."
sleep 2
echo "Checking system...........................................success"

sleep 2
echo "Ensuring up chrony is installed on servera................success"

#ssh student@servera "sudo dnf install chrony"

sleep 2
echo "Backing up chrony confid on servera.......................success"

ssh student@servera "sudo cp -rf /etc/chrony.conf.backup /etc/chrony.conf"

sleep 2
echo "Removing time servera.....................................success"

ssh student@servera "sudo timedatectl set-timezone America/Lima"

sleep 2
echo "Restarting chrony service.................................success"

ssh student@servera "sudo systemctl restart chronyd"

sleep 2
echo "Disabling time syncrhonization on servera.................success"

ssh student@servera "sudo timedatectl set-ntp false"

