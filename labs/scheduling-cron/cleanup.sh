#!/bin/bash

print_line() {
    local text="$1"
    local status="$2"
    
    # Colores ANSI para la salida
    local GREEN='\033[0;32m'
    local RED='\033[0;31m'
    local NC='\033[0m' # No Color

    # Mapear el estado a color y formato
    if [ "$status" == "SUCCESS" ]; then
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
LOG_LEVEL=$2

WORKSPACE=/usr/local/rh134/labs

if [[ ! "$LOG_LEVEL" =~ ^(none|info|basic|debug)$ ]]; then
    echo "Error: LOG_LEVEL debe ser 'none', 'info', 'basic' o 'debug'."
    exit 1
fi

if [ -f "/tmp/$LAB_NAME.log" ]; then
	sudo rm -rf /tmp/$LAB_NAME.log
fi

# ==============================================================================
# EJECUCIÓN DE ANSIBLE SEGÚN EL LOG_LEVEL
# ==============================================================================
case "$LOG_LEVEL" in
    none|info)
        # INFO AND NONE: Silencioso, todo redirigido al log
        sudo ansible-playbook -i $WORKSPACE/server.lab $WORKSPACE/$LAB_NAME.yml -e "failover_mode='finish'" > /tmp/$LAB_NAME.log 2>&1
        ;;
    basic)
        # BASIC: Se muestra directamente en pantalla (sin redirigir a archivo)
        sudo ansible-playbook -i $WORKSPACE/server.lab $WORKSPACE/$LAB_NAME.yml -e "failover_mode='finish'"
        ;;
    debug)
        # DEBUG: Modo muy verboso (-vvvv) en pantalla
        sudo ansible-playbook -i $WORKSPACE/server.lab $WORKSPACE/$LAB_NAME.yml -e "failover_mode='finish'" -vvvv
        ;;
esac

echo "Finishing lab."
echo ""
print_line "· Checking lab systems" "SUCCESS"
sleep 2
print_line "· Removing cronjobs for student from servera" "SUCCESS"
sleep 2
print_line "· Removing the output file for cronjob from servera" "SUCCESS"
echo ""

if [ "$LOG_LEVEL" = "info" ] && [ -f "/tmp/$LAB_NAME.log" ]; then
	cat /tmp/$LAB_NAME.log | tail -3
fi


