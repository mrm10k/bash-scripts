#!/bin/bash

#:Title: dupe.sh
#:Version: 1.0
#:Author: Mario Rolando León
#:Date: 10/18/2024
#:Date[ESP]: 18/10/2024
#:Description: A script to delete duped files checking the hash of the files on the selected directory.

sudo apt install lolcat -y && sudo apt install figlet -y

clear
figlet -f ANSI -c DUPE.sh | lolcat
echo "                          Made by mrm10k" | lolcat

# Verificar si el usuario ingresó un directorio
if [ -z "$1" ]; then
  echo "======================================"
  echo
  echo "Uso: $0 <directorio>"
  echo
  echo "======================================"
  exit 1
fi

DIRECTORIO="$1"

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
  echo "======================================"
  echo
  echo "El directorio $DIRECTORIO no existe."
  echo
  echo "======================================"
  exit 1
fi

echo "======================================"
echo
echo "Escaneando archivos en: $DIRECTORIO"
echo
echo "======================================"

# Crear un archivo temporal para guardar los hashes
TEMP_HASHES=$(mktemp)

# Calcular hashes SHA256 para todos los archivos en el directorio
find "$DIRECTORIO" -type f -exec sha256sum "{}" + > "$TEMP_HASHES"

# Buscar y procesar los hashes duplicados
DUPLICADOS=$(awk '{print $1}' "$TEMP_HASHES" | sort | uniq -d)

if [ -z "$DUPLICADOS" ]; then
  echo "======================================"
  echo
  echo "No se encontraron archivos duplicados."
  echo
  echo "======================================"
  rm "$TEMP_HASHES"
  exit 0
fi

# Abrimos descriptor para asegurar que el input del usuario no interfiera con el bucle
exec 3<&0

# Procesar cada hash duplicado
while read -r HASH; do
  echo "======================================"
  echo
  echo "Archivos con hash $HASH:"
  echo
  echo "======================================"

  # Obtener los archivos con este hash específico
  mapfile -t ARCHIVOS < <(grep "^$HASH" "$TEMP_HASHES" | cut -d ' ' -f 3-)

  # Mostrar los archivos encontrados
  for ARCHIVO in "${ARCHIVOS[@]}"; do
    echo "$ARCHIVO"
  done

  # Preguntar si se deben eliminar los duplicados
  while true; do
    echo "======================================"
    echo
    read -p "¿Deseas eliminar todos menos uno? (s/n): " RESPUESTA <&3
    echo
    echo "======================================"
    case "$RESPUESTA" in
      [sS])
        # Mantener solo el primer archivo y eliminar el resto
        for ((i = 1; i < ${#ARCHIVOS[@]}; i++)); do
          echo "Eliminando: ${ARCHIVOS[$i]}"
          rm -f "${ARCHIVOS[$i]}"
        done
        break
        ;;
      [nN])
        echo "======================================"
        echo
        echo "No se eliminaron archivos para el hash $HASH."
        echo
        echo "======================================"
        break
        ;;
      *)
        echo "======================================"
        echo
        echo "Por favor ingresa 's' o 'n'."
        echo
        echo "======================================"
        ;;
    esac
  done
done <<< "$DUPLICADOS"

# Cerrar el descriptor
exec 3<&-

# Limpiar archivos temporales
rm "$TEMP_HASHES"

echo "======================================"
echo
echo "Proceso completado."
echo
echo "======================================"
exit 0
