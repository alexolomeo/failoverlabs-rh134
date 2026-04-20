#!/bin/bash

if [[ -f /tmp/console_lab_file ]]; then
    echo "✔ Lab completado correctamente"
    exit 0
else
    echo "✘ Lab incompleto"
    exit 1
fi
