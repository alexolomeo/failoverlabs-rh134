#!/bin/bash
echo "Finishing Lab..."

sleep 2
echo "Checking Log system......................................success"
ssh student@servera "sudo rm -rf /etc/rsyslog.d/*"
sleep 2
echo "Removing log files from servera..........................success"


ssh student@servera "sudo rm -rf /var/log/messages-debug"
