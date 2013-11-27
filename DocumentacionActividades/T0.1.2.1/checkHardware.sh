#!/bin/bash

# File:         checkHardware.sh
# Author:       Roberto Rosende Dopazo 
#               <roberto[dot]rosende[dot]dopazo[at]gmail[dot]com>

# This script run lshw and get an xml with all info
# Parse with a python script the xml and insert in ddbb of Getracer relevan info
# Rename xml file and create a log file with element_id from Getracer

##USER, SERVER and DIR are set to run scp
##REMOTE_PYTHON where python script is in remote machine
USER=""
SERVER=""
DIR=""
REMOTE_PYTHON=""

##FILENAME_TEMP is created with product name get from lshw and time in Unix format
FILENAME_LSHW=$(lshw | grep -m1 product: | sed -e 's/[ ]\{1,\}product: //g'|sed -e 's/[(,),\"]//g'|sed -e "s/\'//g"|sed -e 's/ $//g')
FILENAME_TEMP=$(echo "$FILENAME_LSHW"_`date +%s`.xml)


echo "Nombre del fichero temporal: "$FILENAME_TEMP
lshw -xml > "`echo $FILENAME_TEMP`"
scp "$FILENAME_TEMP" "$USER@$SERVER:$DIR"

if [ $? -eq 0 ] ; then
  echo "Fichero copiado con exito."
  echo "Se procede al parseado del xml."
else
  echo "ERROR al copiar el fichero."
  exit 1
fi

##run python script in repo machine
ssh "$USER@$SERVER" "python $REMOTE_PYTHON '$DIR/$FILENAME_TEMP' > '$DIR/$FILENAME_TEMP.log'"

##values are now inserted in DDBB, from log get element_id 
##change filenames with product_id+element_id
BASENAME=`ssh $USER@$SERVER "echo $DIR$FILENAME_TEMP" | cut -d'_' -f1`
IDNAME=`ssh $USER@$SERVER "grep 'El ID del Elemento es :' $DIR$FILENAME_TEMP.log" | cut -d':' -f2`
NEWNAME="$BASENAME"_"$IDNAME"
echo "El nuevo nombre para los ficheros es: $NEWNAME .log/.xml"

ssh "$USER@$SERVER" "mv '$DIR$FILENAME_TEMP' '$NEWNAME.xml'"
if [ $? -eq 0 ] ; then
  echo "Fichero xml renombrado con exito."
else
  echo "ERROR al renombrar el fichero xml."
  exit 1
fi

ssh "$USER@$SERVER" "mv '$DIR$FILENAME_TEMP.log' '$NEWNAME.log'"
if [ $? -eq 0 ] ; then
  echo "Fichero log renombrado con exito."
else
  echo "ERROR al renombrar el fichero log."
  exit 1
fi


