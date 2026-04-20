#!/bin/bash

echo "Finishing lab..."
sleep 2
echo "Checking Log system......................................success"

sleep 2
echo "Restoring log config on servera..........................success"

ssh student@servera "sudo cp -rf /etc/systemd/journald.conf.backup  /etc/systemd/journald.conf"

sleep 2
echo "Restoring journald service on servera....................success"

ssh student@servera "sudo systemctl restart systemd-journald.service"

sleep 2
echo "Cleaning Log on servera..................................success"

ssh student@servera "sudo rm -rf /var/log/journal"

