#!/bin/bash
LAB_NAME=$1

if [[ -f /tmp/$LAB_NAME ]]; then
    echo "✔ Lab completado correctamente"
    exit 0
else
    echo "✘ Lab incompleto"
    exit 1
fi
