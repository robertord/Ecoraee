#!/bin/bash

##USER, SERVER and DIR are set to run scp
USER=""
SERVER=""
DIR=""
##FILENAME is created with product name get from lshw and time in Unix format
FILENAME="`lshw | grep -m1 product: | sed -e 's/[ ]\{1,\}product: //g'`_`date +%s`.xml"

echo "Nombre del fichero: "$FILENAME
lshw -xml > "`echo $FILENAME`"
scp "$FILENAME" "$USER@$SERVER:$DIR"

if [ $? -eq 0 ] ; then
  echo "Fichero copiado con EXITO.";
else
  echo "ERROR al copiar el fichero.";
fi


