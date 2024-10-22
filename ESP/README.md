# clean.sh

Un script muy simple escrito en bash. Este crea un directorio llamado papelera en el home del usuario y manda los archivos deseados a ese directorio.

---
## Funcionalidades
- **Mueve archivos a la papelera** (comprimido como archivos`.gz` ).
- **Lista el contenido** de la papelera.
- **Recupera archivos** de la papelera.
- **Muestra la ayuda** con instrucciones de uso.

---
## Funcionamiento

Hay que asegurarse de que el archivo se puede ejecutar, para ello ejecutaremos lo siguiente en la terminal:

`chmod +x clean.sh`

---
## Uso
 ``./limpia.sh [paramétros] [archivo]``

---
## Parametros
- **``-L``**: Lista el contenido de la papelera.
- **``-R``**: Recupera un archivo de la papelera.
- **``-h``**: Muestra la ayuda de uso.

---
## Ejemplos
1. **``./limpia.sh ejemplo.txt``**: Mueve un archivo a ~/papelera.
2. **``./limpia.sh -L``**: Lista el contenido de ~/papelera.
3. **``./limpia.sh -R ejemplo.txt``**: Recupera un archivo de ~/papelera.
4. **``./limpia.sh -h``**: Muestra la ayuda.

---
## Como funciona
1. **Mueve archivos a la papelera:**
- El archivo especificado es comprimido en formato `.gz` y movido a  ~/papelera.
- Si ~/papelera lo crea automáticamente.
 
2. **Listar Archivos:**
- Muestra el contenido de ~/papelera.

3. **Recuperar archivos**
- Descomprime el archivo `.gz` especificado y lo devuelve al directorio desde el que fue eliminado.
   
4. **Restricciones:**
- Este script no borra directorios ni archivos en lote, solo uno a uno.

---
## Errores

- Si no se ha introducido ningún parámetro muestra la ayuda de uso.
- Si se intenta mover un directorio mostrará un error y saldrá del script.
- Si se intenta recuperar un archivo inexistente mostrará un error y saldrá del script.

---


# dupe.sh.

## Funcionalidades
**Instala automáticamente los requerimientos y elimina los archivos duplicados verificando y comparando el hash de los archivos de un directorio especificado dando la opción de dejar uno de los que se encuentren.**

---
## Funcionamiento
Hay que asegurarse que el archivo se puede ejecutar:
`sudo chmod +x dupe.sh`

---
## Ejemplos
`dupe.sh .`
`./dupe.sh /home/`
`dupe.sh /`

---
## Errores
- Si no se introduce ningún directorio, muestra la ayuda de uso y sale del script mostrando un error.
- Si se introduce un directorio inexistente, sale del script mostrando un error.
- Si las opciones introducidas no son ni "y" o "n" vuelve a preguntar una de las opciones hasta que se le introduzca una de las dos. 
---
