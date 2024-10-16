#!/bin/bash

#Aqui definimos la ruta de la papelera
PAPELERA=~/papelera

# Si el directorio papelera no existe, se crea automáticamente en el home del usuario
if [ ! -d "$PAPELERA" ]; then
    echo "=================================="
    echo
    echo "Creando papelera en $PAPELERA"
    echo
    echo "=================================="
    mkdir -p "$PAPELERA"
fi

#Si no se pasan archivos que eliminar, ni parámetros, se muestra la ayuda
if [ "$#" -eq 0 ]; then
    echo "=================================="
    echo
    echo "Uso: limpia [opciones] fichero"
    echo ""
    echo "Opciones:"
    echo "  -L            Listar el contenido de la papelera."
    echo "  -R fichero    Recuperar un fichero desde la papelera."
    echo "  -h            Muestra la ayuda."
    echo
    echo "=================================="
    exit 1
fi

#Si se le introduce la opción -h, muestra la ayuda
if [ "$1" == "-h" ]; then
    echo "=================================="
    echo
    echo "Uso: limpia [opciones] fichero"
    echo ""
    echo "Opciones:"
    echo "  -L            Listar el contenido de la papelera."
    echo "  -R fichero    Recuperar un fichero desde la papelera."
    echo "  -h            Muestra esta ayuda."
    echo
    echo "=================================="
    exit 0
fi

#Si se le introduce la opción -L, lista el contenido de la papelera
if [ "$1" == "-L" ]; then
    echo "=================================="
    echo
    echo "Contenido de la papelera:"
    echo
    ls -l "$PAPELERA"
    echo
    echo "=================================="
    exit 0
fi

#Si se le introduce la opción -R, recupera un archivo de la papelera, si no se le introduce ningun archivo o un archivo erroneo, da error
if [ "$1" == "-R" ]; then
    if [ -z "$2" ]; then
        echo "=================================="
        echo
        echo "Error: Debe especificar un archivo para recuperar."
        echo
        echo "=================================="
        exit 1
    fi
    if [ -e "$PAPELERA/$2.gz" ]; then
        gunzip "$PAPELERA/$2.gz"
        mv "$PAPELERA/$2" ./
        echo "=================================="
        echo
        echo "$2 recuperado desde la papelera."
        echo
        echo "=================================="
    else
        echo "=================================="
        echo
        echo "Error: El archivo $2 no existe en la papelera."
        echo
        echo "=================================="
    fi
    exit 0
fi

#Verifica si hay algun archivo para mover a la papelera, si no hay ninguno, da error
if [ -z "$1" ]; then
    echo "=================================="
    echo
    echo "Error: No se ha especificado ningún archivo."
    echo
    echo "=================================="
    exit 1
fi

#Verifica si es un archivo, en el caso de que sea un directorio, da error y cierra el script
if [ -e "$1" ]; then
    if [ -d "$1" ]; then
        # Si es un directorio, no permitir su eliminación
        echo "Error: $1 es un directorio y no puede ser movido a la papelera."
    else
        # Comprimir el archivo y moverlo a la papelera
        gzip -c "$1" > "$PAPELERA/$1.gz"
        rm "$1"
        echo "=================================="
        echo        
        echo "$1 comprimido y movido a la papelera."
        echo
        echo "=================================="     
    fi
else
    echo "=================================="
    echo
    echo "El archivo $1 no existe."
    echo
    echo "=================================="
fi
