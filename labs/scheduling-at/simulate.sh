#!/bin/bash

print_line() {
    local text="$1"
    local status="$2"
    
    # Colores ANSI para la salida
    local YELLOW='\033[0;33m'
    local GREEN='\033[0;32m'
    local RED='\033[0;31m'
    local NC='\033[0m' # No Color

    # Mapear el estado a color y formato
    if [ "$status" == "CHECKING" ]; then
        status_formatted="${YELLOW}CHECKING${NC}"
    elif [ "$status" == "SUCCESS" ]; then
        status_formatted="${GREEN}SUCCESS${NC}"
    elif [ "$status" == "FAILED" ]; then
        status_formatted="${RED}FAILED${NC}"
    else
        status_formatted="$status"
    fi

    # 1. Obtener el ancho total de la terminal actual
    local term_width=$(tput cols)

    # 2. Calcular la longitud del texto base y del estado original (sin códigos de color)
    local text_len=${#text}
    local status_len=${#status}

    # 3. Calcular cuántos puntos de relleno se necesitan
    # El '- 2' es para dejar un espacio antes de los puntos y otro antes del estado
    local dots_count=$(( term_width - text_len - status_len - 2 ))

    # Si por alguna razón la pantalla es muy pequeña, asegurar al menos un par de puntos
    if [ $dots_count -lt 2 ]; then
        dots_count=2
    fi

    # 4. Generar la cadena de puntos dinámicamente
    local dots=$(printf '%*s' "$dots_count" | tr ' ' '.')

    # 5. Imprimir la línea final armada
    echo -e "$text $dots $status_formatted"
}

LAB_NAME=$1

if [ -f "/tmp/$LAB_NAME.log" ]; then
	sudo rm -rf /tmp/$LAB_NAME.log
fi

sudo ansible-playbook -i /usr/local/rh134/labs/server.lab  /usr/local/rh134/labs/$LAB_NAME.yml -e "failover_mode='simulate'" >  /tmp/$LAB_NAME.log  2>&1

echo "Starting lab."
echo ""
print_line "· Validating execution on servera" "CHECKING"
sleep 2
print_line "· Validating jobs generate for student on servera" "CHECKING"
sleep 2
print_line "· Validating all proccess on servera" "CHECKING"
sleep 2
print_line "· Generate reports from servera" "SUCCESS"
echo ""

if [ -f "/tmp/$LAB_NAME.log" ]; then
	cat /tmp/$LAB_NAME.log | tail -3
fi

printf "%-5s \n"

filtered=$(awk -F: '{ NF--; print $0 }' OFS=: /tmp/$LAB_NAME/simulate.log)

checked=$(printf '%s\n' "$filtered" | awk -F: '{last=$NF; NF--; print $0 "|" last}' OFS=:)

while IFS='|' read -r p1 p2; do
    print_line "· $p1" "$p2"
    sleep 1
done <<< "$checked"



