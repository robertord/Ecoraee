#!/bin/bash
FICH=`date +%Y.%m.%d.%H.%M`_`hostname`
echo "Hola soy "`hostname`" y tengo la ip: " > /tmp/$FICH
ifconfig eth| grep -Eo "inet addr:[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"|grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+">>/tmp/$FICH
scp /tmp/$FICH cluster@192.168.40.102:/home/cluster/arranque/
