#!/usr/bin/python
import sys, commands ,MySQLdb , re ,time ,os , tty 
# Datos para la conexion a MySQL
mysql_servidor = 'localhost'
mysql_usuario  = 'root'
mysql_clave    = '#padege#'
mysql_bd       = 'getracer'

# Metodo para conectar la base de datos

def Conectar():
	return MySQLdb.connect(host=mysql_servidor, user=mysql_usuario, passwd=mysql_clave, db=mysql_bd)

