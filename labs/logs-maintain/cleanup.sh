#!/bin/bash

echo "Finishing lab..."
sleep 2
echo "Checking system....................................................success"

sleep 2
echo "Restoring  original chrony config on servera.......................success"

ssh student@servera "sudo cp -rf /etc/chrony.conf.backup /etc/chrony.conf"

sleep 2
echo "Restoring original time zone on servera............................success"

ssh student@servera "sudo timedatectl set-timezone America/Lima"

ssh student@servera "sudo systemctl restart chronyd"

ssh student@servera "sudo timedatectl set-ntp false"
