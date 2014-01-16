#!/bin/bash
FILE=/home/usuario/regSensores.txt
##captura de fecha y hora
echo " ">>$FILE
echo "================================">>$FILE
echo "  Fecha: "`date +%Y.%m.%d` `date +%H:%M`>>$FILE
echo "================================">>$FILE
##captura a traves de top del uptime 
##para comprobar que no se haya reiniciado
##ver las cargas medias del sistema
echo " ">>$FILE
echo "Uptime: "`uptime`>>$FILE
##capturar con top estado de cpu en el momento
echo " ">>$FILE
top -b -n1 | grep "Cpu(s)" >>$FILE
##captura de la temperatura desde los distintos sensores
echo " ">>$FILE
sensors >> $FILE

