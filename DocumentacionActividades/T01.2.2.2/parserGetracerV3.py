#!/usr/bin/python
import sys, commands ,MySQLdb , re ,time ,os , tty , datetime ,shutil
from lxml import etree
from select import select
from Conexion import Conectar

##Creo la clase y los metodos para controlar una interrupcion mediante una tecla pulsada
class NotTTYException(Exception): pass

class TerminalFile:
    def __init__(self,infile):
        if not infile.isatty():
            raise NotTTYException()
        self.file=infile
        #prepare for getch
        self.save_attr=tty.tcgetattr(self.file)
        newattr=self.save_attr[:]
        newattr[3] &= ~tty.ECHO & ~tty.ICANON
        tty.tcsetattr(self.file, tty.TCSANOW, newattr)

    def __del__(self):
        #restoring stdin
        import tty  #required this import here
        tty.tcsetattr(self.file, tty.TCSADRAIN, self.save_attr)

    def getch(self):
        if select([self.file],[],[],0)[0]:
            c=self.file.read(1)
        else:
            c=''
        return c

# Obtenemos el id_element mayor de la tabla element de la base de datos
id_max=0
id_padre=0

# Conectamos la base de datos

db=Conectar();

cursor=db.cursor()
sql = "select max(id_element) from element"
cursor.execute(sql)
resultado=cursor.fetchall()
id_max=int(''.join(map(str,resultado[0])))
id_max=id_max + 1
id_padre=id_max
cursor.close()

##Creo el fichero de .log obteniendo como nombre el xml que se le pasa al script cambiando solo el .xml por .log

fichero_aux = sys.argv[1]
fichero_aux=fichero_aux.split('/')[-1]
fichero_aux=fichero_aux.split('.')[0]
fichero_aux=fichero_aux+".log"

fichero = open(fichero_aux,"w+")
	
	
##Obtener la fecha actual

fecha= datetime.date.today()
hoy= fecha.strftime("%Y/%m/%d")
hora_agregado = fecha.strftime("%Y/%m/%d %I:%M %p")
valor="Fecha : "+str(hora_agregado)
fichero.write(valor)
fichero.write(" \n")
#-------------------------

xml_aux=sys.argv[1]

infile = open(sys.argv[1])
data = infile.read()
infile.close()
inventory = etree.XML(data)

##Obtengo del segundo parametro al programa la Ip publica de la cual se llama al script

ip=sys.argv[2]


#Pido por teclado el identificador de donde se esta realizando la operacion

print "Introduzca el identificador"
id_destino_aux = raw_input('')

cursor=db.cursor()
sql = "select *  from destino_origen where(id_destino_origen ='"+str(id_destino_aux)+"')"
cursor.execute(sql)

if cursor.fetchall():
	
	resultado_ip=cursor.fetchall()
	for row in cursor:
    		id_destino_origen=row[0]
	cursor.close()	

	
	


	valor="Conectado desde la ip : "+str(ip)+" con identificacion del origen :"+str(id_destino_origen)
	fichero.write(valor)
	fichero.write(" \n")
	fichero.write("-------------------------------------------------------------")
	fichero.write(" \n")

	opcion=0
	print ""
	print ""
	print ""
	print "+--------------------------------------------------------------+"
	print "+                                                              +"
	print "+			MENU				       +"	
	print "+                                       parserGetracer v3      +"
	print "+--------------------------------------------------------------+"
	print "+ -Para insertar todos los elementos espere unos segundos      +"
	print "+                                                              +"
	print "+ -Insercion de elementos mediante seleccion PULSE SOLO 1      +"		
	print "+--------------------------------------------------------------+"

	##Switch de las opciones del menu


	if __name__=="__main__":
    		s=TerminalFile(sys.stdin)
    
    	i=0
    	while s.getch()!="1" and i !=10:
		time.sleep(1)
        	i+=1

    	if i!=10:
		opcion=1


	if opcion!=1:
## Elemento Padre Id:0001

		cursor=db.cursor()
		element="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0001,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"') "

		fichero.write(element)
		fichero.write(" \n")

		cursor.execute(element)
		cursor.close()
		print ""
		fichero.write(" \n")
		print "El ID del Elemento es :"+str(id_padre)+""
		valor="El ID del Elemento es :"+str(id_padre)+""
		fichero.write(valor)
		print ""
		fichero.write(" \n")
		print "-------------------------------------------------------------"
		fichero.write("------------------------------------------------------------- \n")
		print""
		fichero.write(" \n")
		##Elemento Padre->Caracterticas Descripcion=0001

		cursor=db.cursor()
		caracteristica_element_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_padre)+" ,0001,0001,'Computer')"  
	
		fichero.write(caracteristica_element_descripcion)
		fichero.write(" \n")

		cursor.execute(caracteristica_element_descripcion)
		cursor.close()
##--------------------------------------------------
##CDROM

		find_cdrom=etree.XPath(".//node[@id='cdrom']")
		cdrom_descripcion=''
		cdrom_vendedor=''
		cdrom_producto=''
		for cdrom in find_cdrom(inventory):
		##Como puede tener mas de un elemento primero hacemos el caso base para un solo elemento
		#Insertamos el elemento nuevo
			cursor=db.cursor()
			elemento_cdrom="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0005,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

			fichero.write(elemento_cdrom)
			fichero.write(" \n")


			cursor.execute(elemento_cdrom)
			id_max=id_max+1
			cursor.close()
    			print 'CDROM'
			fichero.write("CDROM\n")
    	# busco el cdrom
    			if cdrom.find('description') is not None:
				print 'Descripcion : ' ,cdrom.find('description').text

				valor="Descripcion : "+cdrom.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				cdrom_descripcion = str(cdrom.find('description').text)
		##Descripcion=0035
				cursor=db.cursor()
				caracteristica_cdrom_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0035,0005,'"+cdrom_descripcion.replace("\'","")+"')"  
				fichero.write(caracteristica_cdrom_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_cdrom_descripcion)
				cursor.close()
		
    			if cdrom.find('vendor') is not None:
				print 'Vendedor : ' ,cdrom.find('vendor').text

				valor="Vendedor : " +cdrom.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				cdrom_vendedor=str(cdrom.find('vendor').text)
		##Vendedor=0037
				cursor=db.cursor()
				caracteristica_cdrom_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0037,0005,'"+cdrom_vendedor.replace("\'","")+"')"  

				fichero.write(caracteristica_cdrom_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_cdrom_vendedor)
				cursor.close()
		
    			if cdrom.find('product') is not None:
				print 'Producto : ' ,cdrom.find('product').text
				cdrom_producto=str(cdrom.find('product').text)

				valor="Producto : "+cdrom.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

		##Producto=0036
				cursor=db.cursor()
				caracteristica_cdrom_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0036,0005,'"+cdrom_producto.replace("\'","")+"')"  

				fichero.write(caracteristica_cdrom_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_cdrom_producto)
				cursor.close()
			print "-------------------------------------------------------------"
	
			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

			print""
##Este es el caso en el que existan mas de un elemento de este tipo,hace un recorrido de 0-9
		r=10
		for cont in range(0,r,1):
			find_cdrom = etree.XPath(".//node[@id='cdrom:"+str(cont)+"']")
			cdrom_descripcion=''
			cdrom_vendedor=''
			cdrom_producto=''
			for cdrom in find_cdrom(inventory):
				print"CDROM="+str(cont)

				valor="CDROM="+str(cont)
				fichero.write(valor)
				fichero.write(" \n")

			#Insertamos el elemento nuevo
				cursor=db.cursor()
				elemento_cdrom="insert into element	(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0005,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(valor)
				fichero.write(" \n")

				cursor.execute(elemento_cdrom)
				id_max=id_max+1
				cursor.close()
    		# busco el cdrom
    				if cdrom.find('description')is not None:
					print 'Descripcion : ' ,cdrom.find('description').text
					cdrom_descripcion = str(cdrom.find('description').text)
				

					valor="Descripcion : "+cdrom.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

			##Descripcion=0035
					cursor=db.cursor()
					caracteristica_cdrom_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0035,0005,'"+cdrom_descripcion.replace("\'","")+"')" 
					fichero.write(caracteristica_cdrom_descripcion)
					fichero.write(" \n")

	 				cursor.execute(caracteristica_cdrom_descripcion)
					cursor.close()
		
    				if cdrom.find('vendor')is not None:
					print 'Vendedor : ' ,cdrom.find('vendor').text
					cdrom_vendedor=str(cdrom.find('vendor').text)

					valor="Vendedor : "+cdrom.find('vendor').text
					fichero.write(valor)
					fichero.write(" \n")

		##Vendedor=0037
					cursor=db.cursor()
					caracteristica_cdrom_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0037,0005,'"+cdrom_vendedor.replace("\'","")+"')"  

					fichero.write(caracteristica_cdrom_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_cdrom_vendedor)
					cursor.close()
			
    				if cdrom.find('product')is not None:
					print 'Producto : ' ,cdrom.find('product').text
					cdrom_producto=str(cdrom.find('product').text)

					valor="Producto : "+cdrom.find('product').text
					fichero.write(valor)
					fichero.write(" \n")

			##Producto=0036
					cursor=db.cursor()
					caracteristica_cdrom_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0036,0005,'"+cdrom_producto.replace("\'","")+"')"  
					fichero.write(caracteristica_cdrom_producto)
					fichero.write(" \n")

					cursor.execute(caracteristica_cdrom_producto)
					cursor.close()
				print "-------------------------------------------------------------"
				print""
			
				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")
	##--------------------------------------------------
	##Targeta de red
	##Como puede tener mas de un elemento primero hacemos el caso base para un solo elemento
		find_red = etree.XPath(".//node[@id='network']")
		red_descripcion=''
		red_vendedor=''
		red_producto=''
		red_bits=0

	##Targeta de red ->Caracterticas 
		for red in find_red(inventory):
			cursor=db.cursor()
			elemento_targetared="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0004,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

			fichero.write(elemento_targetared)
			fichero.write(" \n")

			cursor.execute(elemento_targetared)
			id_max=id_max+1
			cursor.close()
			print "Targeta de red"

			fichero.write("Targeta de red\n")

	   	 # busco la targeta de red
			##Descripcion=0022
			if red.find('description')is not None:
				print 'Descripcion : ' ,red.find('description').text
						
				valor="Descripcion : "+red.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				red_descripcion=str(red.find('description').text)
				cursor=db.cursor()
				caracteristica_red_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0022,0004,'"+str(red_descripcion.replace("\'",""))+"')"  
				fichero.write(caracteristica_red_descripcion)
				fichero.write(" \n")
			
				cursor.execute(caracteristica_red_descripcion)
				cursor.close()
		
		##Vendedor=0024	
			if red.find('vendor')is not None:
				print 'Vendedor : ' ,red.find('vendor').text

				valor="Vendedor :"+red.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				red_vendedor=str(red.find('vendor').text)
				cursor=db.cursor()
				caracteristica_red_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0024,0004,'"+str(red_vendedor.replace("\'",""))+"')"  
				fichero.write(caracteristica_red_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_red_vendedor)
				cursor.close()
	
		##Producto=0023	
			if red.find('product')is not None:
				print 'Producto : ' ,red.find('product').text
			
				valor="Producto :"+red.find('product').text
				fichero.write(valor)
				fichero.write(" \n")
			
				red_producto=str(red.find('product').text)
				cursor=db.cursor()
				caracteristica_red_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0023,0014,'"+str(red_producto.replace("\'",""))+"')"  
				fichero.write(caracteristica_red_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_red_producto)
				cursor.close()

		##N Bits=0025	
			if red.find('width')is not None:
				print 'Bits : ' ,red.find('width').text

				valor="Bits : "+red.find('width').text
				fichero.write(valor)
				fichero.write(" \n")

				red_bits=int(red.find('width').text)
				cursor=db.cursor()
				caracteristica_red_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0025,0004,'"+str(red_bits)+"')"  

				fichero.write(caracteristica_red_bits)
				fichero.write(" \n")

				cursor.execute(caracteristica_red_bits)
				cursor.close()
			print "-------------------------------------------------------------"
			print""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	
	##Este es el caso en el que existan mas de un elemento de este tipo,hace un recorrido de 0-9
		r=10
		for cont in range(0,r,1):
			find_red = etree.XPath(".//node[@id='network:"+str(cont)+"']")
			red_descripcion=''
			red_vendedor=''
			red_producto=''
			red_bits=0
	
		##Targeta de red ->Caracterticas 
			for red in find_red(inventory):
				cursor=db.cursor()
				elemento_targetared="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0004,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_targetared)
				fichero.write(" \n")

				cursor.execute(elemento_targetared)
				id_max=id_max+1
				cursor.close()
				print "Tarjeta de red:"+str(cont)+""

				valor="Tarjeta de red:"+str(cont)
				fichero.write(valor)
				fichero.write(" \n")
			
			# busco la targeta de red
			##Descripcion=0022
				if red.find('description')is not None:
					print 'Descripcion : ' ,red.find('description').text

					valor="Descripcion : "+red.find('description').text
					fichero.write(valor)
					fichero.write(" \n")
				
					red_descripcion=str(red.find('description').text)
					cursor=db.cursor()
					caracteristica_red_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0022,0004,'"+str(red_descripcion.replace("\'",""))+"')"  
					fichero.write(caracteristica_red_descripcion)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_descripcion)
					cursor.close()
		
		##Vendedor=0024	
				if red.find('vendor')is not None:
					print 'Vendedor : ' ,red.find('vendor').text

					valor="Vendedor :"+red.find('vendor').text
					fichero.write(valor)
					fichero.write(" \n")

					red_vendedor=str(red.find('vendor').text)
					cursor=db.cursor()
					caracteristica_red_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0024,0004,'"+str(red_vendedor.replace("\'",""))+"')"  
					fichero.write(caracteristica_red_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_vendedor)
					cursor.close()
		##N Bits=0025	
				if red.find('width')is not None:
					print 'Bits : ' ,red.find('width').text

					valor="Bits :"+red.find('width').text
					fichero.write(valor)
					fichero.write(" \n")

					red_bits=int(red.find('width').text)
					cursor=db.cursor()
					caracteristica_red_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0025,0004,'"+str(red_bits)+"')"  
				
					fichero.write(caracteristica_red_bits)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_bits)
					cursor.close()
		##Producto=0023	
				if red.find('product')is not None:
					print 'Producto : ' ,red.find('product').text
				
					valor="Producto : "+red.find('product').text
					fichero.write(valor)
					fichero.write(" \n")

					red_producto=str(red.find('product').text)
					cursor=db.cursor()
					caracteristica_red_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0023,0004,'"+str(red_producto.replace("\'",""))+"')"  
					fichero.write(caracteristica_red_producto)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_producto)
					cursor.close()

				print "-------------------------------------------------------------"
				print""

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")


	##--------------------------------------------------
	##Adaptador de display Id:0012 
		find_display = etree.XPath(".//node[@id='display']")
		display_descripcion=''
		display_vendedor=''
		display_producto=''
	##Adaptador de display ->Caracterticas 
		for display in find_display(inventory):
	    		print "Adaptador de display"

			fichero.write("Adaptador de display")
			fichero.write(" \n")

			cursor=db.cursor()
			elemento_display="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0012,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

			fichero.write(elemento_display)
			fichero.write(" \n")

			cursor.execute(elemento_display)
			cursor.close()
			id_max=id_max+1
	    	# busco el adaptador de display
	
		##Descripcion=0046
	    		if display.find('description')is not None:
				print 'Descripcion : ' ,display.find('description').text
		
				valor="Descripcion : "+display.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				display_descripcion=str(display.find('description').text)
				cursor=db.cursor()
				caracteristica_display_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0046,0012,'"+str(display_descripcion.replace("\'",""))+"')"  
	
				fichero.write(caracteristica_display_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_display_descripcion)
				cursor.close()
		
		##Vendedor=0047	
	   		if display.find('vendor')is not None:
				print 'Vendedor : ' ,display.find('vendor').text

				valor="Vendedor : "+display.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				display_vendedor=str(display.find('vendor').text)
				cursor=db.cursor()
				caracteristica_display_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0047,0012,'"+str(display_vendedor.replace("\'",""))+"')"  

				fichero.write(caracteristica_display_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_display_vendedor)
				cursor.close()
		
		##Producto=0045	
	    		if display.find('product')is not None:
				print 'Producto : ' ,display.find('product').text
			
				valor="Producto : "+display.find('product').text
				fichero.write(valor)
				fichero.write(" \n")
				
				display_producto=str(display.find('product').text)
				cursor=db.cursor()
				caracteristica_display_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0045,0012,'"+str(display_producto.replace("\'",""))+"')" 

				fichero.write(caracteristica_display_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_display_producto)
				cursor.close()
		
			print "-------------------------------------------------------------"
			print""
		
			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	##--------------------------------------------------
	##Dispositivo multimedia Id:0013	
	##Caso en que solo exista una targeta multimedia

		find_multimedia = etree.XPath(".//node[@id='multimedia']")
		multimedia_descripcion=''
		multimedia_vendedor=''
		multimedia_producto=''


	##Multimedia ->Caracterticas 
		for multimedia in find_multimedia(inventory):
	    		print 'Dispositivo Multimedia'

			fichero.write("Dispositivo Multimedia")
			fichero.write(" \n")

			cursor=db.cursor()
			elemento_multimedia="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0013,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

			fichero.write(elemento_multimedia)
			fichero.write(" \n")

			cursor.execute(elemento_multimedia)
			id_max=id_max+1
			cursor.close()
	    # busco el dispositivo multimedia
	
		##Descripcion=0042
	    		if multimedia.find('description')is not None:
				print 'Descripcion : ' ,multimedia.find('description').text

				valor="Descripcion : "+multimedia.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				multimedia_descripcion=str(multimedia.find('description').text)
				cursor=db.cursor()
				caracteristica_multimedia_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0042,0013,'"+str(multimedia_descripcion.replace("\'",""))+"')"

				fichero.write(caracteristica_multimedia_descripcion)
				fichero.write(" \n")
	  
				cursor.execute(caracteristica_multimedia_descripcion)
				cursor.close()
		
		##Vendedor=0044	
	    		if multimedia.find('vendor')is not None:
				print 'Vendedor : ' ,multimedia.find('vendor').text

				valor="Vendedor : "+multimedia.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				multimedia_vendedor=str(multimedia.find('vendor').text)
				cursor=db.cursor()
				caracteristica_multimedia_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0044,0013,'"+str(multimedia_vendedor.replace("\'",""))+"')" 
		
				fichero.write(caracteristica_multimedia_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_multimedia_vendedor)
				cursor.close()
		
		##Producto=0043	
	    		if multimedia.find('product')is not None:
				print 'Producto : ' ,multimedia.find('product').text

				valor="Producto : "+multimedia.find('product').text
				fichero.write(valor)
				fichero.write(" \n")
			
				multimedia_producto=str(multimedia.find('product').text)
				multimedia_producto=multimedia_producto.replace("\'","")
				cursor=db.cursor()
				caracteristica_multimedia_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0043,0013,'"+str(multimedia_producto.replace("\'",""))+"')" 
			
				fichero.write(caracteristica_multimedia_producto)
				fichero.write(" \n") 

				cursor.execute(caracteristica_multimedia_producto)
				cursor.close()

			print "-------------------------------------------------------------"
			print""
			
			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	##Caso en que exista mas de una targeta multimedia
		r=10
		for cont in range(0,r,1):
			find_multimedia = etree.XPath(".//node[@id='multimedia:"+str(cont)+"']")
			multimedia_descripcion=''
			multimedia_vendedor=''
			multimedia_producto=''

			for multimedia in find_multimedia(inventory):
				print 'Dispositivo Multimedia'

				fichero.write("Dispositivo Multimedia")
				fichero.write(" \n")

				cursor=db.cursor()
				elemento_multimedia="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0013,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
				cursor.execute(elemento_multimedia)

				fichero.write(elemento_multimedia)
				fichero.write(" \n")
			

				id_max=id_max+1
				cursor.close()
			# busco el dispositivo multimedia
			##Multimedia ->Caracterticas 
			##Descripcion=0042
				if multimedia.find('description')is not None:
					print 'Descripcion : ' ,multimedia.find('description').text

					valor="Descripcion : "+multimedia.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

					multimedia_descripcion=str(multimedia.find('description').text)
					cursor=db.cursor()
					caracteristica_multimedia_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0042,0013,'"+str(multimedia_descripcion.replace("\'",""))+"')"  

					fichero.write(caracteristica_multimedia_descripcion)
					fichero.write(" \n")

					cursor.execute(caracteristica_multimedia_descripcion)
					cursor.close()
		
			##Vendedor=0044	
				if multimedia.find('vendor')is not None:
					print 'Vendedor : ' ,multimedia.find('vendor').text

					valor="Vendedor : "+multimedia.find('vendor').text
					fichero.write(" \n")

					multimedia_vendedor=str(multimedia.find('vendor').text)
					cursor=db.cursor()
					caracteristica_multimedia_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0044,0013,'"+str(multimedia_vendedor.replace("\'",""))+"')"  
				
					fichero.write(caracteristica_multimedia_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_multimedia_vendedor)
					cursor.close()
		
			##Producto=0043	
				if multimedia.find('product')is not None:
					print 'Producto : ' ,multimedia.find('product').text
				
					valor="Producto : "+multimedia.find('product').text
					fichero.write(" \n")

					multimedia_producto=str(multimedia.find('product').text)
					cursor=db.cursor()
					caracteristica_multimedia_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0043,0013,'"+str(multimedia_producto.replace("\'",""))+"')"

					fichero.write(caracteristica_multimedia_producto)
	  				fichero.write(" \n")

					cursor.execute(caracteristica_multimedia_producto)
					cursor.close()

				print "-------------------------------------------------------------"
				print""

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")


	##--------------------------------------------------
	##Placa base Id:0007  
		find_motherboard = etree.XPath(".//node[@id='core']")

	##Inicializamos variables 
		id_max=id_max+1
		placa_descripcion=''
		placa_vendedor=''
		placa_producto=''

		for motherboard in find_motherboard(inventory):
	    		print 'Placa Base'
		
			fichero.write("Placa Base")
			fichero.write(" \n")

			cursor=db.cursor()
			elemento_placa="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0007,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
		
			fichero.write(elemento_placa)
			fichero.write(" \n")

			cursor.execute(elemento_placa)
			cursor.close()
		##Placa Base ->Caracterticas 
		# busco el adaptador de la placa base
	
		##Descripcion=0004
	    		if motherboard.find('description')is not None:
				print 'Descripcion : ' ,motherboard.find('description').text
		
				valor="Descripcion : "+motherboard.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				placa_descripcion=str(motherboard.find('description').text)
				cursor=db.cursor()
				caracteristica_placa_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0004,0007,'"+str(placa_descripcion.replace("\'",""))+"')"
			
				fichero.write(caracteristica_placa_descripcion)
	  			fichero.write(" \n")

				cursor.execute(caracteristica_placa_descripcion)
				cursor.close()
		
		##Vendedor=0005	
	    		if motherboard.find('vendor')is not None:
				print 'Vendedor : ' ,motherboard.find('vendor').text

				valor="Vendedor : "+motherboard.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")
			
				placa_vendedor=str(motherboard.find('vendor').text)
				cursor=db.cursor()
				caracteristica_placa_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0005,0007,'"+str(placa_vendedor.replace("\'",""))+"')"  
			
				fichero.write(caracteristica_placa_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_placa_vendedor)
				cursor.close()
		
		##Producto=0039	
	    		if motherboard.find('product')is not None:
				print 'Producto : ' ,motherboard.find('product').text

				valor="Producto : "+motherboard.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				placa_producto=str(motherboard.find('product').text)
				cursor=db.cursor()
				caracteristica_placa_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0039,0007,'"+str(placa_producto.replace("\'",""))+"')"  
				fichero.write(caracteristica_placa_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_placa_producto)
				cursor.close()
		
			print "-------------------------------------------------------------"
			print""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	##--------------------------------------------------
	##Fuente de alimentacion Id:0015	
		find_energy = etree.XPath(".//node[@id='power']")

	##Inicializamos variables
		fuente_descripcion=''
		fuente_vendedor=''
		fuente_producto=''
		for energy in find_energy(inventory):
	    		print 'Fuente de alimentacion'
		        
			fichero.write("Fuente de alimentacion")
			fichero.write(" \n")

			cursor=db.cursor()
			elemento_fuente="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0015,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

			fichero.write(elemento_fuente)
			fichero.write(" \n")

			cursor.execute(elemento_fuente)
			id_max=id_max+1
			cursor.close()
	    # busco la fuente de alimentacion
		##Fuente de alimentacion ->Caracterticas 
	
		##Descripcion=0048
	    		if energy.find('description')is not None:
				print 'Descripcion : ' ,energy.find('description').text

				valor="Descripcion : "+energy.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				fuente_descripcion=str(energy.find('description').text)
				cursor=db.cursor()
				caracteristica_fuente_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0048,0015,'"+str(fuente_descripcion.replace("\'",""))+"')" 

				fichero.write(caracteristica_fuente_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_fuente_descripcion)
				cursor.close()
		
		##Vendedor=0049
	    		if energy.find('vendor')is not None:
				print 'Vendedor : ' ,energy.find('vendor').text
		
				valor="Vendedor : "+energy.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				fuente_vendedor=str(energy.find('vendor').text)
				cursor=db.cursor()
				caracteristica_fuente_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0049,0015,'"+str(fuente_vendedor.replace("\'",""))+"')"  
				fichero.write(caracteristica_fuente_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_fuente_vendedor)
				cursor.close()
		
		##Producto=0050	
	    		if energy.find('product')is not None:
				print 'Producto : ' ,energy.find('product').text

				valor="Producto : "+energy.find('product').text
				fichero.write(valor)			
				fichero.write(" \n")

				fuente_producto=str(energy.find('product').text)
				cursor=db.cursor()
				caracteristica_fuente_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0050,0015,'"+str(fuente_producto.replace("\'",""))+"')"  

				fichero.write(caracteristica_fuente_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_fuente_producto)
				cursor.close()
		
			print "-------------------------------------------------------------"
			print ""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	## ------------------------------------------------------------------------------------
	##Procesador Id:0002

		find_cpu = etree.XPath(".//node[@id='cpu']")

	##Inicializamos variables
		cpu_descripcion=''
		cpu_vendedor=''
		cpu_producto=''
		cpu_bits=''

		for cpu in find_cpu(inventory):
	    		print 'Procesador'

			fichero.write("Procesador")
			fichero.write(" \n")

			cursor=db.cursor()
			elemento_procesador="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0002,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
		
			fichero.write(elemento_procesador)
			fichero.write(" \n")

			cursor.execute(elemento_procesador)
			cursor.close()
			id_max=id_max+1
	    # busco el procesador
		##Procesador ->Caracterticas 
	
		##N Descripcion=0040
	    		if cpu.find('description')is not None:
				print 'Descripcion : ' ,cpu.find('description').text

				valor="Descripcion : "+cpu.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				cpu_descripcion=str(cpu.find('description').text)
				cursor=db.cursor()
				caracteristica_procesador_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0040,0002,'"+str(cpu_descripcion.replace("\'",""))+"')"
				  
				fichero.write(caracteristica_procesador_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_descripcion)
				cursor.close()
		
		##Vendedor=0007	
	    		if cpu.find('vendor')is not None:
				print 'Vendedor : ' ,cpu.find('vendor').text
			
				valor="Vendedor : "+cpu.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				cpu_vendedor=str(cpu.find('vendor').text)
				cursor=db.cursor()
				caracteristica_procesador_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0007,0002,'"+str(cpu_vendedor.replace("\'",""))+"')"  

				fichero.write(caracteristica_procesador_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_vendedor)
				cursor.close()
	
		##Producto=0006	
	   		if cpu.find('product')is not None:
				print 'Producto : ' ,cpu.find('product').text
			
				valor="Producto : "+cpu.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				cpu_producto=str(cpu.find('product').text)
				cursor=db.cursor()
				caracteristica_procesador_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0006,0002,'"+str(cpu_producto.replace("\'",""))+"')"  
			
				fichero.write(caracteristica_procesador_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_producto)
				cursor.close()
	
		##N Bits=0009	
	   		if cpu.find('width')is not None:
				print 'Bits : ' ,cpu.find('width').text
			
				valor="Bits :"+cpu.find('width').text
				fichero.write(valor)
				fichero.write(" \n")

				cpu_bits=str(cpu.find('width').text)
				cursor=db.cursor()
				caracteristica_procesador_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0009,0002,'"+str(cpu_bits)+"')"  
			
				fichero.write(caracteristica_procesador_bits)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_bits)
				cursor.close()
		
			print "-------------------------------------------------------------"
			print ""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")


		#Caso en que solo exista un disco duro
		##Disco Duro Id:0006
		find_disks = etree.XPath(".//node[@class='disk']")
		disk_tamanho = 0
		numdisks = 0
		disk_descripcion=''
		disk_vendedor=''
		disk_producto=''

		for disk in find_disks(inventory):
	    # has to be a hard-disk
	    		if disk.find('size') is not None:
				print "Disco Duro "+str(numdisks)+""
			
				valor="Disco Duro "+str(numdisks)
				fichero.write(valor)
				fichero.write(" \n")

				numdisks = numdisks + 1
			##Si encontramos un class='disk' que tenga la caracteristica size,significa que es un disco duro,entonces ya encontramos uno
				cursor=db.cursor()
				elemento_discoduro="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0006,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
			
				fichero.write(elemento_discoduro)
				fichero.write(" \n")

				cursor.execute(elemento_discoduro)
				id_max=id_max+1
				cursor.close()

			##Disco Duro ->Caracterticas 
		
			##Tamanho=0033
				disk_tamanho = int(disk.find('size').text)
				print 'Capacidad(GB):', disk_tamanho/(1024*1024**2)
				disk_tamanho=disk_tamanho/(1024*1024**2)

				valor="Capacidad(GB):"+str(disk_tamanho)
				fichero.write(valor)
				fichero.write(" \n")

				cursor=db.cursor()
				caracteristica_discoduro_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0033,0006,'"+str(disk_tamanho)+"')" 

				fichero.write(caracteristica_discoduro_tamanho)
				fichero.write(" \n")
	 
				cursor.execute(caracteristica_discoduro_tamanho)
				cursor.close()
		
		
			##Descripcion =0030
				if disk.find('description') is not None:
					print 'Descripcion : ' ,disk.find('description').text

					valor="Descripcion : "+disk.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

					disk_descripcion=str(disk.find('description').text)
					cursor=db.cursor()
					caracteristica_discoduro_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0030,0006,'"+str(disk_descripcion.replace("\'",""))+"')" 

					fichero.write(caracteristica_discoduro_descripcion)
					fichero.write(" \n") 

					cursor.execute(caracteristica_discoduro_descripcion)
					cursor.close()
		
			##Producto =0031		
				if disk.find('product') is not None:
					print 'Producto : ' ,disk.find('product').text
				
					valor="Producto : "+disk.find('product').text
					fichero.write(valor)
					fichero.write(" \n") 

					disk_producto=str(disk.find('product').text)
					cursor=db.cursor()
					caracteristica_discoduro_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0031,0006,'"+str(disk_producto.replace("\'",""))+"')"  
					fichero.write(caracteristica_discoduro_producto)
					fichero.write(" \n") 

					cursor.execute(caracteristica_discoduro_producto)
					cursor.close()
			
			##Vendedor=0032	
				if disk.find('vendor') is not None:
					print 'Vendedor : ' ,disk.find('vendor').text
		
					valor="Vendedor : "+disk.find('vendor').text
					fichero.write(valor)
					fichero.write(" \n")
				
					disk_vendedor=str(disk.find('vendor').text)
					cursor=db.cursor()
					caracteristica_discoduro_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0032,0006,'"+str(disk_vendedor.replace("\'",""))+"')"  

					fichero.write(caracteristica_discoduro_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_discoduro_vendedor)
					cursor.close()
				print "-------------------------------------------------------------"
				print""

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")
	
	##Caso en que exista mas de un disco duro
		r=10
		for cont in range(0,r,1):
			find_disks = etree.XPath(".//node[@class='disk:"+str(cont)+"']")
			disk_tamanho = 0
			numdisks = 0
			disk_descripcion=''
			disk_vendedor=''
			disk_producto=''

			for disk in find_disks(inventory):
			# has to be a hard-disk
				print "Disco Duro "+str(i)+""

				valor="Disco Duro : "+str(i)
				fichero.write(valor)
				fichero.write(" \n")
			
				if disk.find('size') is not None:
				
					numdisks = numdisks + 1
				##Si encontramos un class='disk' que tenga la caracteristica size,significa que es un disco duro,entonces ya encontramos uno
					cursor=db.cursor()
					elemento_discoduro="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0006,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
					cursor.execute(elemento_discoduro)

				
					fichero.write(elemento_discoduro)
					fichero.write(" \n")
			
					id_max=id_max+1
					cursor.close()
				##Disco Duro ->Caracterticas 
		
				##Tamanho=0033
					disk_tamanho = int(disk.find('size').text)
					print 'Capacidad:', disk_tamanho/(1024*1024**2)

					valor="Capacidad : "+str(disk_tamanho/(1024*1024**2))
					fichero.write(valor)
					fichero.write(" \n")

					disk_tamanho=disk_tamanho/(1024*1024**2)
					cursor=db.cursor()
					caracteristica_discoduro_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0033,0006,'"+str(disk_tamanho)+"')" 

					fichero.write(caracteristica_discoduro_tamanho)
					fichero.write(" \n") 

					cursor.execute(caracteristica_discoduro_tamanho)
					cursor.close()
		
		
				##Descripcion =0030
					if disk.find('description') is not None:
						print 'Descripcion : ' ,disk.find('description').text

						valor="Descripcion : "+disk.find('description').text
						fichero.write(valor)
						fichero.write(" \n")

						disk_descripcion=str(disk.find('description').text)
						cursor=db.cursor()
						caracteristica_discoduro_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0030,0006,'"+str(disk_descripcion.replace("\'",""))+"')"  

						fichero.write(caracteristica_discoduro_descripcion)
						fichero.write(" \n")

						cursor.execute(caracteristica_discoduro_descripcion)
			
		
				##Producto =0031		
					if disk.find('product') is not None:
						print 'Producto : ' ,disk.find('product').text


						valor="Producto : "+disk.find('product').text
						fichero.write(valor)
						fichero.write(" \n")

						disk_producto=str(disk.find('product').text)
						cursor=db.cursor()
						caracteristica_discoduro_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0031,0006,'"+str(disk_producto.replace("\'",""))+"')"  
						fichero.write(caracteristica_discoduro_producto)
						fichero.write(" \n")

						cursor.execute(caracteristica_discoduro_producto)
						cursor.close()
			
				##Vendedor=0032	
					if disk.find('vendor') is not None:
						print 'Vendedor : ' ,disk.find('vendor').text

						valor="Vendedor : "+disk.find('vendor').text
						fichero.write(valor)
						fichero.write(" \n")

						disk_vendedor=str(disk.find('vendor').text)
						cursor=db.cursor()
						caracteristica_discoduro_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0032,0006,'"+str(disk_vendedor.replace("\'",""))+"')"  


						fichero.write(caracteristica_discoduro_vendedor)
						fichero.write(" \n")

						cursor.execute(caracteristica_discoduro_vendedor)
						cursor.close()
					print "-------------------------------------------------------------"
					print ""

					fichero.write("-------------------------------------------------------------")
					fichero.write(" \n")


	##Memoria Ram Id:0003


	##Inicializamos variables
		ram_descripcion=''
		ram_vendedor=''
		ram_producto=''
		ram_tamanho=0
		ram_frecuencia=0
		ram_bits=''

	##Primero el caso de que solo tenga una memoria RAM
		find_mem = etree.XPath(".//node[@id='bank']")


		for mem in find_mem(inventory):
	    # busco la memoria ram
			##Se inserta la memoria Ram
			print "Memoria RAM"
		
			fichero.write("Memoria RAM")
			fichero.write(" \n")

			cursor=db.cursor()
			elemento_memoriaRam="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0003,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

			fichero.write(elemento_memoriaRam)
			fichero.write(" \n")

			cursor.execute(elemento_memoriaRam)
			id_max=id_max+1
			cursor.close()
	
		##Memoria Ram ->Caracterticas 
	
		##Tamanho=0012
	    		if mem.find('size')is not None :
				ram_tamanho = int(mem.find('size').text)
				print 'Capacidad:', ram_tamanho/(1024**2)

				valor="Capacidad : "+ram_tamanho/(1024**2)
				fichero.write(valor)
				fichero.write(" \n")

				ram_tamanho=ram_tamanho/(1024**2)
		
				cursor=db.cursor()
				caracteristica_memoriaRam_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0012,0003,'"+str(ram_tamanho)+"')"

				fichero.write(caracteristica_memoriaRam_tamanho)
				fichero.write(" \n")
	 
				cursor.execute(caracteristica_memoriaRam_tamanho)
				cursor.close()
		
		##Descripcion=0010
			if disk.find('description') is not None:
				print 'Descripcion : ' ,disk.find('description').text

				valor="Descripcion : "+disk.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				ram_descripcion=str(disk.find('description').text)
				cursor=db.cursor()
				caracteristica_memoriaRam_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0010,0003,'"+str(ram_descripcion.replace("\'",""))+"')"  
				fichero.write(caracteristica_memoriaRam_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_descripcion)
				cursor.close()
	
		##Vendedor=0011
			if disk.find('vendor') is not None:
				print 'Vendedor : ' ,disk.find('vendor').text

				valor="Vendedor : "+disk.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				ram_vendedor=str(disk.find('vendor').text)
				cursor=db.cursor()
				caracteristica_memoriaRam_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0011,0003,'"+str(ram_vendedor.replace("\'",""))+"')"  
				fichero.write(caracteristica_memoriaRam_vendedo)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_vendedor)
				cursor.close()

		##N Bits=0013
			if disk.find('width') is not None:
				print 'N Bits : ' ,disk.find('width').text
			

				valor="N Bits : "+disk.find('width').text
				fichero.write(valor)
				fichero.write(" \n")

				ram_bits=str(disk.find('width').text)
				cursor=db.cursor()
				caracteristica_memoriaRam_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0013,0003,'"+str(ram_bits)+"')"  

				fichero.write(caracteristica_memoriaRam_bits)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_bits)
				cursor.close()
	
		##Frecuencia=0014
			if disk.find('clock') is not None:
				print 'Frecuencia(Hz) : ' ,disk.find('clock').text

				valor="Frecuencia(Hz) : "+disk.find('clock').text
				fichero.write(valor)
				fichero.write(" \n")

				ram_frecuencia=str(disk.find('clock').text)
				ram_frecuencia=ram_frecuencia/1000000
				cursor=db.cursor()
				caracteristica_memoriaRam_frecuencia="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0014,0003,'"+str(ram_frecuencia)+"')"  
			
				fichero.write(caracteristica_memoriaRam_frecuencia)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_frecuencia)
				cursor.close()

		##Producto=0041
			if disk.find('product') is not None:
				print 'Producto : ' ,disk.find('product').text

				valor="Producto :  "+disk.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				ram_producto=str(disk.find('product').text)
				cursor=db.cursor()
				caracteristica_memoriaRam_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0041,0003,'"+str(ram_producto.replace("\'",""))+"')"  

				fichero.write(caracteristica_memoriaRam_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_producto)
				cursor.close()
			print "-------------------------------------------------------------"
			print""
			
			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")
		
	##Caso en que exista mas de una memoria Ram
	## ------------------------------------------------------------------------------------
		r=10
		for cont in range(0,r,1):

			find_mem = etree.XPath(".//node[@id='bank:"+str(cont)+"']")

			for mem in find_mem(inventory):
			
				if mem.find('size')is not None :
					# busco la memoria ram
					##Se inserta la memoria Ram
					print "Memoria RAM"+str(cont)+""

					valor="Memoria RAM"+str(cont)
					fichero.write(valor)
					fichero.write(" \n")

					cursor=db.cursor()
					elemento_memoriaRam="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0003,"+str(id_padre)+",0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

					fichero.write(elemento_memoriaRam)
					fichero.write(" \n")

					cursor.execute(elemento_memoriaRam)
					id_max=id_max+1
					cursor.close()
			##Memoria Ram ->Caracterticas 
	
			##Tamanho=0012
					if mem.find('size')is not None :
						ram_tamanho = int(mem.find('size').text)
						print 'Capacidad:', ram_tamanho/(1024**2)

						valor="Capacidad"+str(ram_tamanho/(1024**2))
						fichero.write(valor)
						fichero.write(" \n")

						ram_tamanho=ram_tamanho/(1024**2)
		
						cursor=db.cursor()
						caracteristica_memoriaRam_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0012,0003,'"+str(ram_tamanho)+"')"  

						fichero.write(caracteristica_memoriaRam_tamanho)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_tamanho)
						cursor.close()
		
			##Descripcion=0010
					if mem.find('description') is not None:
						print 'Descripcion : ' ,mem.find('description').text

						valor="Descripcion"+mem.find('description').text
						fichero.write(valor)
						fichero.write(" \n")

						ram_descripcion=str(mem.find('description').text)
						cursor=db.cursor()
						caracteristica_memoriaRam_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0010,0003,'"+str(ram_descripcion.replace("\'",""))+"')"  
						fichero.write(caracteristica_memoriaRam_descripcion)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_descripcion)
						cursor.close()
	
			##Vendedor=0011
					if mem.find('vendor') is not None:
						print 'Vendedor : ' ,mem.find('vendor').text

						valor="Vendedor"+mem.find('vendor').text
						fichero.write(valor)
						fichero.write(" \n")

						ram_vendedor=str(mem.find('vendor').text)
						cursor=db.cursor()
						caracteristica_memoriaRam_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0011,0003,'"+str(ram_vendedor.replace("\'",""))+"')"  
						fichero.write(caracteristica_memoriaRam_vendedor)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_vendedor)
						cursor.close()

			##N Bits=0013
					if mem.find('width') is not None:
						print 'N Bits : ' ,mem.find('width').text

						valor="N Bits : "+mem.find('width').text
						fichero.write(valor)
						fichero.write(" \n")


						ram_bits=str(mem.find('width').text)
						cursor=db.cursor()
						caracteristica_memoriaRam_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0013,0003,'"+str(ram_bits)+"')" 


						fichero.write(caracteristica_memoriaRam_bits)
						fichero.write(" \n")
	 
						cursor.execute(caracteristica_memoriaRam_bits)
						cursor.close()
	
			##Frecuencia=0014
					if mem.find('clock') is not None:
						print 'Frecuencia(Hz) : ' ,mem.find('clock').text

						valor="Frecuencia(Hz) :  "+mem.find('clock').text
						fichero.write(valor)
						fichero.write(" \n")

						ram_frecuencia=int(mem.find('clock').text)
						ram_frecuencia=ram_frecuencia/1000000
						cursor=db.cursor()
						caracteristica_memoriaRam_frecuencia="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0014,0003,'"+str(ram_frecuencia)+"')"  
						cursor.execute(caracteristica_memoriaRam_frecuencia)

						fichero.write(caracteristica_memoriaRam_frecuencia)
						fichero.write(" \n")
						cursor.close()
	
			##Producto=0041
					if mem.find('product') is not None:
						print 'Producto : ' ,mem.find('product').text

						valor="Producto :  "+mem.find('product').text
						fichero.write(valor)
						fichero.write(" \n")

						ram_producto=str(mem.find('product').text)
						cursor=db.cursor()
						caracteristica_memoriaRam_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0041,0003,'"+str(ram_producto.replace("\'",""))+"')"  
						fichero.write(caracteristica_memoriaRam_producto)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_producto)
						cursor.close()
					print "-------------------------------------------------------------"
					print ""

					fichero.write("-------------------------------------------------------------")
					fichero.write(" \n")

	##----------------------------------------------------------------
	##----------------------------------------------------------------
	##Caso en que solo queramos insertar unos elementos predeterminados
	##----------------------------------------------------------------
	##----------------------------------------------------------------

	if opcion==1:

		print "_---------------_"
	
		fichero.write("_---------------_")
		fichero.write(" \n")

			##--------------------------------------------------
			##CDROM

		find_cdrom=etree.XPath(".//node[@id='cdrom']")
		cdrom_descripcion=''
		cdrom_vendedor=''
		cdrom_producto=''
		for cdrom in find_cdrom(inventory):
				##Como puede tener mas de un elemento primero hacemos el caso base para un solo elemento
				#Insertamos el elemento nuevo
		
		
	    		print 'CDROM'

			valor="CDROM"
			fichero.write(valor)
			fichero.write(" \n")

	    			# busco el cdrom
	    		if cdrom.find('description') is not None:
				print 'Descripcion : ' ,cdrom.find('description').text
			
				valor="Descripcion : "+cdrom.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				cdrom_descripcion = str(cdrom.find('description').text)
			
		
	    		if cdrom.find('vendor') is not None:
				print 'Vendedor : ' ,cdrom.find('vendor').text

				valor="Vendedor : "+cdrom.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				cdrom_vendedor=str(cdrom.find('vendor').text)
			
		
	    		if cdrom.find('product') is not None:
				print 'Producto : ' ,cdrom.find('product').text

				valor="Producto :  "+cdrom.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				cdrom_producto=str(cdrom.find('product').text)

			##Comprobacion si desea insertar el elemento o no
			opcion_insertar = raw_input("Desea insertar el elemento (s/n mas Enter): ")		
			print opcion_insertar		
			if opcion_insertar=="s":
				##Inserccion del elemento
				cursor=db.cursor()
				elemento_cdrom="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0005,0,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_cdrom)
				fichero.write(" \n")

				cursor.execute(elemento_cdrom)
				id_max=id_max+1
				cursor.close()

				##Descripcion=0035
				cursor=db.cursor()
				caracteristica_cdrom_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0035,0005,'"+cdrom_descripcion.replace("\'","")+"')"  
				fichero.write(caracteristica_cdrom_descripcion)
				fichero.write(" \n")
			
				cursor.execute(caracteristica_cdrom_descripcion)
				cursor.close()

				##Vendedor=0037
				cursor=db.cursor()
				caracteristica_cdrom_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0037,0005,'"+cdrom_vendedor.replace("\'","")+"')"  
				fichero.write(caracteristica_cdrom_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_cdrom_vendedor)
				cursor.close()
				##Producto=0036

				cursor=db.cursor()
				caracteristica_cdrom_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0036,0005,'"+cdrom_producto.replace("\'","")+"')"  
				fichero.write(caracteristica_cdrom_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_cdrom_producto)
				cursor.close()

				print"Insertado"
				fichero.write("Insertado")
			print "-------------------------------------------------------------"
			print""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")
		
		

	##Este es el caso en el que existan mas de un elemento de este tipo,hace un recorrido de 0-9
		r=10
		for cont in range(0,r,1):
			find_cdrom = etree.XPath(".//node[@id='cdrom:"+str(cont)+"']")
			cdrom_descripcion=''
			cdrom_vendedor=''
			cdrom_producto=''
			for cdrom in find_cdrom(inventory):
				print"CDROM="+str(cont)
			
				valor="CDROM"+str(cont)
				fichero.write(valor)
				fichero.write(" \n")
				
				id_max=id_max+1
				cursor.close()
	    				# busco el cdrom
	    			if cdrom.find('description')is not None:
					print 'Descripcion : ' ,cdrom.find('description').text

					valor="Descripcion : "+cdrom.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

					cdrom_descripcion = str(cdrom.find('description').text)
				
		
	    			if cdrom.find('vendor')is not None:
					print 'Vendedor : ' ,cdrom.find('vendor').text

					valor="Vendedor : "+cdrom.find('vendor').text
					fichero.write(valor)
					fichero.write(" \n")

					cdrom_vendedor=str(cdrom.find('vendor').text)
		
		
	    			if cdrom.find('product')is not None:
					print 'Producto : ' ,cdrom.find('product').text

					valor="Producto : "+cdrom.find('product').text
					fichero.write(valor)
					fichero.write(" \n")

					cdrom_producto=str(cdrom.find('product').text)
		
				print "-------------------------------------------------------------"

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")

				##Comprobacion si desea insertar el elemento o no
				opcion_insertar = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
				if opcion_insetar=='s':

					#Insertamos el elemento nuevo
					cursor=db.cursor()
					elemento_cdrom="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0005,0,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
				
					fichero.write(elemento_cdrom)
					fichero.write(" \n")

					cursor.execute(elemento_cdrom)

					##Descripcion=0035

					cursor=db.cursor()
					caracteristica_cdrom_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0035,0005,'"+cdrom_descripcion.replace("\'","")+"')" 
					fichero.write(caracteristica_cdrom_descripcion)
					fichero.write(" \n")

		 			cursor.execute(caracteristica_cdrom_descripcion)
					cursor.close()

					##Vendedor=0037
					cursor=db.cursor()
					caracteristica_cdrom_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0037,0005,'"+cdrom_vendedor.replace("\'","")+"')"  
					fichero.write(caracteristica_cdrom_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_cdrom_vendedor)
					cursor.close()

					##Producto=0036
					cursor=db.cursor()
					caracteristica_cdrom_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0036,0005,'"+cdrom_producto.replace("\'","")+"')"  
					fichero.write(aracteristica_cdrom_producto)
					fichero.write(" \n")

					cursor.execute(caracteristica_cdrom_producto)
					cursor.close()

					print"Insertado"

					fichero.write("Insertado")

				print "-------------------------------------------------------------"
				print""
		
				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")

	##--------------------------------------------------
	##Targeta de red
	##Como puede tener mas de un elemento primero hacemos el caso base para un solo elemento
		find_red = etree.XPath(".//node[@id='network']")
		red_descripcion=''
		red_vendedor=''
		red_producto=''
		red_bits=0

		##Targeta de red ->Caracterticas 
		for red in find_red(inventory):
		
			print "Tarjeta de red"

			fichero.write("Tarjeta de red")

	    	# busco la targeta de red
			##Descripcion=0022
			if red.find('description')is not None:
				print 'Descripcion : ' ,red.find('description').text

				valor="Descripcion : "+red.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				red_descripcion=str(red.find('description').text)
			
		
		##Vendedor=0024	
			if red.find('vendor')is not None:
				print 'Vendedor : ' ,red.find('vendor').text

				valor="Vendedor : "+red.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				red_vendedor=str(red.find('vendor').text)
			
	
		##Producto=0023	
			if red.find('product')is not None:
				print 'Producto : ' ,red.find('product').text

				valor="Producto : "+red.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				red_producto=str(red.find('product').text)
			

		##N Bits=0025	
			if red.find('width')is not None:
				print 'Bits : ' ,red.find('width').text

				valor="Bits : "+red.find('width').text
				fichero.write(valor)
				fichero.write(" \n")

				red_bits=int(red.find('width').text)
			
		
			##Comprobacion si desea insertar el elemento o no
			opcion_insertar_red = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_red=='s':

				##Insertamos el elemento
				cursor=db.cursor()
				elemento_targetared="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0004,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
			
				fichero.write(elemento_targetared)
				fichero.write(" \n")

				cursor.execute(elemento_targetared)
				id_max=id_max+1
				cursor.close()

				#Insertamos las caracteristicas
				cursor=db.cursor()
				caracteristica_red_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0022,0004,'"+str(red_descripcion.replace("\'",""))+"')"  
				fichero.write(caracteristica_red_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_red_descripcion)
				cursor.close()
			
				cursor=db.cursor()
				caracteristica_red_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0024,0004,'"+str(red_vendedor.replace("\'",""))+"')"  
				fichero.write(caracteristica_red_vendedor)
				fichero.write(" \n")


				cursor.execute(caracteristica_red_vendedor)
				cursor.close()

				cursor=db.cursor()
				caracteristica_red_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0023,0014,'"+str(red_producto.replace("\'",""))+"')"  
				fichero.write(caracteristica_red_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_red_producto)
				cursor.close()

				cursor=db.cursor()
				caracteristica_red_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0025,0004,'"+str(red_bits)+"')"  
			
				fichero.write(caracteristica_red_bits)
				fichero.write(" \n")

				cursor.execute(caracteristica_red_bits)
				cursor.close()
				print"Insertado"
				fichero.write("Insertado")

			print "-------------------------------------------------------------"
			print""
		
			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	##Este es el caso en el que existan mas de un elemento de este tipo,hace un recorrido de 0-9
		r=10
		for cont in range(0,r,1):
			find_red = etree.XPath(".//node[@id='network:"+str(cont)+"']")
			red_descripcion=''
			red_vendedor=''
			red_producto=''
			red_bits=0
	
		##Targeta de red ->Caracterticas 
			for red in find_red(inventory):
			
				print "Tarjeta de red:"+str(cont)+""

				valor="Tarjeta de red: "+str(cont)
				fichero.write(valor)
				fichero.write(" \n")

			# busco la targeta de red
			##Descripcion=0022
				if red.find('description')is not None:
					print 'Descripcion : ' ,red.find('description').text

					valor="Descripcion : "+red.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

					red_descripcion=str(red.find('description').text)
				
		
			##Vendedor=0024	
				if red.find('vendor')is not None:
					print 'Vendedor : ' ,red.find('vendor').text
					red_vendedor=str(red.find('vendor').text)
				
			##N Bits=0025	
				if red.find('width')is not None:
					print 'Bits : ' ,red.find('width').text

					valor="Bits :  "+red.find('width').text
					fichero.write(valor)
					fichero.write(" \n")

					red_bits=int(red.find('width').text)
				
		##Producto=0023	
				if red.find('product')is not None:
					print 'Producto : ' ,red.find('product').text

					valor="Producto :  "+red.find('product').text
					fichero.write(valor)
					fichero.write(" \n")

					red_producto=str(red.find('product').text)
				
				##Comprobacion si desea insertar el elemento o no
				opcion_insertar_red = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
				if opcion_insertar_red=='s':
					##Insertamos el elemento
					cursor=db.cursor()
					elemento_targetared="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0004,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				
					fichero.write(elemento_targetared)
					fichero.write(" \n")

					cursor.execute(elemento_targetared)
					id_max=id_max+1
					cursor.close()

				#Insertamos las caracteristicas
					cursor=db.cursor()
					caracteristica_red_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0022,0004,'"+str(red_descripcion.replace("\'",""))+"')"  
					fichero.write(caracteristica_red_descripcion)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_descripcion)
					cursor.close()
			
					cursor=db.cursor()
					caracteristica_red_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0024,0004,'"+str(red_vendedor.replace("\'",""))+"')"  
					fichero.write(caracteristica_red_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_vendedor)
					cursor.close()

					cursor=db.cursor()
					caracteristica_red_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0023,0014,'"+str(red_producto.replace("\'",""))+"')"  
					fichero.write(caracteristica_red_producto)
					fichero.write(" \n")


					cursor.execute(caracteristica_red_producto)
					cursor.close()

					cursor=db.cursor()
					caracteristica_red_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0025,0004,'"+str(red_bits)+"')"  

					fichero.write(caracteristica_red_bits)
					fichero.write(" \n")

					cursor.execute(caracteristica_red_bits)
					cursor.close()
					print"Insertado"
					fichero.write("Insertado")

				print "-------------------------------------------------------------"
				print ""

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")

	##--------------------------------------------------
	##Adaptador de display Id:0012 

		find_display = etree.XPath(".//node[@id='display']")
		display_descripcion=''
		display_vendedor=''
		display_producto=''
	##Adaptador de display ->Caracterticas 
		for display in find_display(inventory):
	    		print "Adaptador de display"
		
			fichero.write("Adaptador de display")

	    	# busco el adaptador de display
	
		##Descripcion=0046
	    		if display.find('description')is not None:
				print 'Descripcion : ' ,display.find('description').text

				valor="Descripcion :  "+display.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				display_descripcion=str(display.find('description').text)
			
		
		##Vendedor=0047	
	   		if display.find('vendor')is not None:
				print 'Vendedor : ' ,display.find('vendor').text

				valor="Vendedor : "+display.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				display_vendedor=str(display.find('vendor').text)
			
		
		##Producto=0045	
	    		if display.find('product')is not None:
				print 'Producto : ' ,display.find('product').text

				valor="Producto :  "+display.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				display_producto=str(display.find('product').text)
			
			##Comprobacion si desea insertar el elemento o no
			opcion_insertar_display = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_display=='s':
					##Insertamos el elemento
				cursor=db.cursor()
				elemento_display="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0012,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_display)
				fichero.write(" \n")

				cursor.execute(elemento_display)
				cursor.close()
				id_max=id_max+1

					##Insertamos las caracteristicas
				cursor=db.cursor()
				caracteristica_display_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0046,0012,'"+str(display_descripcion.replace("\'",""))+"')"  

				fichero.write(caracteristica_display_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_display_descripcion)
				cursor.close()
			
				cursor=db.cursor()
				caracteristica_display_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0047,0012,'"+str(display_vendedor.replace("\'",""))+"')"

				fichero.write(caracteristica_display_vendedor)
				fichero.write(" \n")
	  
				cursor.execute(caracteristica_display_vendedor)
				cursor.close()
			
				cursor=db.cursor()
				caracteristica_display_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0045,0012,'"+str(display_producto.replace("\'",""))+"')" 

				fichero.write(caracteristica_display_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_display_producto)
				cursor.close()
				print"Insertado"

				fichero.write("Insertado")
				fichero.write(" \n")

			print "-------------------------------------------------------------"
			print ""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")


	##--------------------------------------------------
	##Dispositivo multimedia Id:0013	
	##Caso en que solo exista una targeta multimedia

		find_multimedia = etree.XPath(".//node[@id='multimedia']")
		multimedia_descripcion=''
		multimedia_vendedor=''
		multimedia_producto=''


	##Multimedia ->Caracterticas 
		for multimedia in find_multimedia(inventory):
	    		print 'Dispositivo Multimedia'

			fichero.write("Dispositivo Multimedia")
			fichero.write(" \n")
		
	    # busco el dispositivo multimedia
	
		##Descripcion=0042
	    		if multimedia.find('description')is not None:
				print 'Descripcion : ' ,multimedia.find('description').text
			
				valor="Descripcion :  "+multimedia.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				multimedia_descripcion=str(multimedia.find('description').text)
			
		##Vendedor=0044	
	    		if multimedia.find('vendor')is not None:
				print 'Vendedor : ' ,multimedia.find('vendor').text

				valor="Vendedor :  "+multimedia.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				multimedia_vendedor=str(multimedia.find('vendor').text)
			
		##Producto=0043	
	    		if multimedia.find('product')is not None:
				print 'Producto : ' ,multimedia.find('product').text

				valor="Producto :  "+multimedia.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				multimedia_producto=str(multimedia.find('product').text)
			
			##Comprobacion si desea insertar el elemento o no
			opcion_insertar_multimedia = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_multimedia=='s':
					##Insertamos el elemento
				cursor=db.cursor()
				elemento_multimedia="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0013,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
			
				fichero.write(elemento_multimedia)
				fichero.write(" \n")

				cursor.execute(elemento_multimedia)
				id_max=id_max+1
				cursor.close()
					##Insertamos las caracteristicas

				cursor=db.cursor()
				caracteristica_multimedia_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0042,0013,'"+str(multimedia_descripcion.replace("\'",""))+"')" 

				fichero.write(caracteristica_multimedia_descripcion)
				fichero.write(" \n")
	 
				cursor.execute(caracteristica_multimedia_descripcion)
				cursor.close()
			
				cursor=db.cursor()
				caracteristica_multimedia_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0044,0013,'"+str(multimedia_vendedor.replace("\'",""))+"')"  
			
				fichero.write(caracteristica_multimedia_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_multimedia_vendedor)
				cursor.close()
		
				cursor=db.cursor()
				caracteristica_multimedia_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0043,0013,'"+str(multimedia_producto.replace("\'",""))+"')"  

				fichero.write(caracteristica_multimedia_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_multimedia_producto)
				cursor.close()
				print"Insertado"

				fichero.write("Insertado")
				fichero.write(" \n")

			print "-------------------------------------------------------------"
			print""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")


	##Caso en que exista mas de una targeta multimedia
		r=10
		for cont in range(0,r,1):
			find_multimedia = etree.XPath(".//node[@id='multimedia:"+str(cont)+"']")
			multimedia_descripcion=''
			multimedia_vendedor=''
			multimedia_producto=''

			for multimedia in find_multimedia(inventory):
				print 'Dispositivo Multimedia'

				fichero.write("Dispositivo Multimedia")
				fichero.write(" \n")

			# busco el dispositivo multimedia
			##Multimedia ->Caracterticas 
			##Descripcion=0042
				if multimedia.find('description')is not None:
					print 'Descripcion : ' ,multimedia.find('description').text

					valor="Descripcion :  "+multimedia.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

					multimedia_descripcion=str(multimedia.find('description').text)
				
		
			##Vendedor=0044	
				if multimedia.find('vendor')is not None:
					print 'Vendedor : ' ,multimedia.find('vendor').text

					valor="Vendedor :  "+multimedia.find('vendor').text
					fichero.write(valor)
					fichero.write(" \n")

					multimedia_vendedor=str(multimedia.find('vendor').text)
				
		
			##Producto=0043	
				if multimedia.find('product')is not None:
					print 'Producto : ' ,multimedia.find('product').text

					valor="Producto :  "+multimedia.find('product').text
					fichero.write(valor)
					fichero.write(" \n")

					multimedia_producto=str(multimedia.find('product').text)
				

				
			##Comprobacion si desea insertar el elemento o no
				opcion_insertar_multimedia = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
				if opcion_insertar_multimedia=='s':
					##Insertamos el elemento
					cursor=db.cursor()
					elemento_multimedia="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0013,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

					fichero.write(elemento_multimedia)
					fichero.write(" \n")


					cursor.execute(elemento_multimedia)
					id_max=id_max+1
					cursor.close()
					##Insertamos las caracteristicas

					cursor=db.cursor()
					caracteristica_multimedia_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0042,0013,'"+str(multimedia_descripcion.replace("\'",""))+"')"  

					fichero.write(caracteristica_multimedia_descripcion)
					fichero.write(" \n")

					cursor.execute(caracteristica_multimedia_descripcion)
					cursor.close()
			
					cursor=db.cursor()
					caracteristica_multimedia_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0044,0013,'"+str(multimedia_vendedor.replace("\'",""))+"')"  

					fichero.write(caracteristica_multimedia_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_multimedia_vendedor)
					cursor.close()
		
					cursor=db.cursor()
					caracteristica_multimedia_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0043,0013,'"+str(multimedia_producto.replace("\'",""))+"')" 

					fichero.write(caracteristica_multimedia_producto)
					fichero.write(" \n")
	 
					cursor.execute(caracteristica_multimedia_producto)
					cursor.close()
					print"Insertado"

					fichero.write("Insertado")
					fichero.write(" \n")


				print "-------------------------------------------------------------"
				print ""

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")

		##--------------------------------------------------
	##Placa base Id:0007  
		find_motherboard = etree.XPath(".//node[@id='core']")

	##Inicializamos variables 
		id_max=id_max+1
		placa_descripcion=''
		placa_vendedor=''
		placa_producto=''

		for motherboard in find_motherboard(inventory):
	    		print 'Placa Base'

			fichero.write("Placa Base")
			fichero.write(" \n")
		
		##Placa Base ->Caracterticas 
		# busco el adaptador de la placa base
	
		##Descripcion=0004
	    		if motherboard.find('description')is not None:
				print 'Descripcion : ' ,motherboard.find('description').text
		
				valor="Descripcion :  "+motherboard.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

				placa_descripcion=str(motherboard.find('description').text)
			
		
		##Vendedor=0005	
	    		if motherboard.find('vendor')is not None:
				print 'Vendedor : ' ,motherboard.find('vendor').text

				valor="Vendedor :  "+motherboard.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

				placa_vendedor=str(motherboard.find('vendor').text)
			
		
		##Producto=0039	
	    		if motherboard.find('product')is not None:
				print 'Producto : ' ,motherboard.find('product').text

				valor="Producto :  "+motherboard.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

				placa_producto=str(motherboard.find('product').text)
			



			opcion_insertar_placa = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_placa=='s':
					##Insertamos el elemento
				cursor=db.cursor()
				elemento_placa="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0007,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_placa)
				fichero.write(" \n")

				cursor.execute(elemento_placa)
				cursor.close()

				cursor=db.cursor()
				caracteristica_placa_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0004,0007,'"+str(placa_descripcion.replace("\'",""))+"')"

				fichero.write(caracteristica_placa_descripcion)
				fichero.write(" \n")
	  
				cursor.execute(caracteristica_placa_descripcion)
				cursor.close()

				cursor=db.cursor()
				caracteristica_placa_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0005,0007,'"+str(placa_vendedor.replace("\'",""))+"')"  

				fichero.write(caracteristica_placa_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_placa_vendedor)
				cursor.close()

				cursor=db.cursor()
				caracteristica_placa_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0039,0007,'"+str(placa_producto.replace("\'",""))+"')"  

				fichero.write(caracteristica_placa_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_placa_producto)
				cursor.close()
				print"Insertado"

				fichero.write("Insertado")
				fichero.write(" \n")

			print "-------------------------------------------------------------"
			print ""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")


		##--------------------------------------------------
	##Fuente de alimentacion Id:0015	
		find_energy = etree.XPath(".//node[@id='power']")

	##Inicializamos variables
		fuente_descripcion=''
		fuente_vendedor=''
		fuente_producto=''
		for energy in find_energy(inventory):
	    		print 'Fuente de alimentacion'
			fichero.write("Fuente de alimentacion")
			fichero.write(" \n")
		
	    # busco la fuente de alimentacion
		##Fuente de alimentacion ->Caracterticas 
	
		##Descripcion=0048
	    		if energy.find('description')is not None:
				print 'Descripcion : ' ,energy.find('description').text
				fuente_descripcion=str(energy.find('description').text)

				valor="Descripcion :  "+energy.find('description').text
				fichero.write(valor)
				fichero.write(" \n")
			
		
		##Vendedor=0049
	    		if energy.find('vendor')is not None:
				print 'Vendedor : ' ,energy.find('vendor').text
				fuente_vendedor=str(energy.find('vendor').text)
			
				valor="Vendedor :  "+energy.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")
			
		
		##Producto=0050	
	    		if energy.find('product')is not None:
				print 'Producto : ' ,energy.find('product').text
				fuente_producto=str(energy.find('product').text)

				valor="Producto :  "+energy.find('product').text
				fichero.write(valor)
				fichero.write(" \n")
			



			opcion_insertar_fuente = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_fuente=='s':
					##Insertamos el elemento

				cursor=db.cursor()
				elemento_fuente="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0015,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_fuente)
				fichero.write(" \n")

				cursor.execute(elemento_fuente)
				id_max=id_max+1
				cursor.close()
					##Insertamos las caracteristicas
				cursor=db.cursor()
				caracteristica_fuente_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0048,0015,'"+str(fuente_descripcion.replace("\'",""))+"')"  

				fichero.write(caracteristica_fuente_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_fuente_descripcion)
				cursor.close()

				cursor=db.cursor()
				caracteristica_fuente_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0049,0015,'"+str(fuente_vendedor.replace("\'",""))+"')"  

				fichero.write(caracteristica_fuente_vendedor)
				fichero.write(" \n")


				cursor.execute(caracteristica_fuente_vendedor)
				cursor.close()
			
				cursor=db.cursor()
				caracteristica_fuente_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0050,0015,'"+str(fuente_producto.replace("\'",""))+"')"  

				fichero.write(caracteristica_fuente_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_fuente_producto)
				cursor.close()
				print"Insertado"

				fichero.write("Insertado")
				fichero.write(" \n")
			
			print "-------------------------------------------------------------"
			print ""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")




		## ------------------------------------------------------------------------------------
	##Procesador Id:0002

		find_cpu = etree.XPath(".//node[@id='cpu']")

	##Inicializamos variables
		cpu_descripcion=''
		cpu_vendedor=''
		cpu_producto=''
		cpu_bits=''

		for cpu in find_cpu(inventory):
	    		print 'Procesador'
			fichero.write("Procesador")
			fichero.write(" \n")
		
	    	# busco el procesador
		##Procesador ->Caracterticas 
	
		##N Descripcion=0040
	    		if cpu.find('description')is not None:
				print 'Descripcion : ' ,cpu.find('description').text
				cpu_descripcion=str(cpu.find('description').text)
			
				valor="Descripcion :  "+cpu.find('description').text
				fichero.write(valor)
				fichero.write(" \n")

		
		##Vendedor=0007	
	    		if cpu.find('vendor')is not None:
				print 'Vendedor : ' ,cpu.find('vendor').text
				cpu_vendedor=str(cpu.find('vendor').text)
			
				valor="Vendedor :  "+cpu.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")
	
		##Producto=0006	
	   		if cpu.find('product')is not None:
				print 'Producto : ' ,cpu.find('product').text
				cpu_producto=str(cpu.find('product').text)
			
				valor="Producto :  "+cpu.find('product').text
				fichero.write(valor)
				fichero.write(" \n")

		##N Bits=0009	
	   		if cpu.find('width')is not None:

				print 'Bits : ' ,cpu.find('width').text
				cpu_bits=str(cpu.find('width').text)

				valor="Bits :  "+cpu.find('width').text
				fichero.write(valor)
				fichero.write(" \n")
			
		
			opcion_insertar_cpu = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_cpu=='s':
					##Insertamos el elemento
				cursor=db.cursor()
				elemento_procesador="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0002,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_procesador)
				fichero.write(" \n")

				cursor.execute(elemento_procesador)
				cursor.close()
				id_max=id_max+1

					##Insertamos las caracteristicas
				
				cursor=db.cursor()
				caracteristica_procesador_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0040,0002,'"+str(cpu_descripcion.replace("\'",""))+"')"  

				fichero.write(caracteristica_procesador_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_descripcion)
				cursor.close()

				cursor=db.cursor()
				caracteristica_procesador_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0007,0002,'"+str(cpu_vendedor.replace("\'",""))+"')"  
				fichero.write(caracteristica_procesador_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_vendedor)
				cursor.close()

				cursor=db.cursor()
				caracteristica_procesador_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0006,0002,'"+str(cpu_producto.replace("\'",""))+"')"  
				fichero.write(caracteristica_procesador_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_procesador_producto)
				cursor.close()

				cursor=db.cursor()
				caracteristica_procesador_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0009,0002,'"+str(cpu_bits)+"')"  
				cursor.execute(caracteristica_procesador_bits)

				fichero.write(caracteristica_procesador_bits)
				fichero.write(" \n")

				cursor.close()
				print"Insertado"
			
				fichero.write("Insertado")
				fichero.write(" \n")
			print "-------------------------------------------------------------"
			print ""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")


	#Caso en que solo exista un disco duro
	##Disco Duro Id:0006
		find_disks = etree.XPath(".//node[@class='disk']")
		disk_tamanho = 0
		numdisks = 0
		disk_descripcion=''
		disk_vendedor=''
		disk_producto=''

		for disk in find_disks(inventory):
	    # has to be a hard-disk
	    		if disk.find('size') is not None:
				print "Disco Duro "+str(numdisks)+""

				valor="Disco Duro "+str(numdisks)
				fichero.write(valor)
				fichero.write(" \n")


				numdisks = numdisks + 1
				##Si encontramos un class='disk' que tenga la caracteristica size,significa que es un disco duro,entonces ya encontramos uno
			
			##Disco Duro ->Caracterticas 
		
			##Tamanho=0033
				disk_tamanho = int(disk.find('size').text)
				print 'Capacidad(GB):', disk_tamanho/(1024*1024**2)
				disk_tamanho=disk_tamanho/(1024*1024**2)
			
				valor="Capacidad(GB):"+str(disk_tamanho)
				fichero.write(valor)
				fichero.write(" \n")
		
			##Descripcion =0030
				if disk.find('description') is not None:
					print 'Descripcion : ' ,disk.find('description').text
					disk_descripcion=str(disk.find('description').text)
				
					valor="Descripcion:"+disk.find('description').text
					fichero.write(valor)
					fichero.write(" \n")

		
			##Producto =0031		
				if disk.find('product') is not None:
					print 'Producto : ' ,disk.find('product').text
					disk_producto=str(disk.find('product').text)
				
					valor="Producto :"+disk.find('product').text
					fichero.write(valor)
					fichero.write(" \n")
			
			##Vendedor=0032	
				if disk.find('vendor') is not None:
					print 'Vendedor : ' ,disk.find('vendor').text
					disk_vendedor=str(disk.find('vendor').text)
				
					valor="Vendedor :"+disk.find('vendor').text
					fichero.write(valor)
					fichero.write(" \n")

				opcion_insertar_disk = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
				if opcion_insertar_disk=='s':
					##Insertamos el elemento

					cursor=db.cursor()
					elemento_discoduro="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0006,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"
				
					fichero.write(elemento_discoduro)
					fichero.write(" \n")
				
					cursor.execute(elemento_discoduro)
					id_max=id_max+1
					cursor.close()
					##Insertamos las caracteristicas


					cursor=db.cursor()
					caracteristica_discoduro_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0033,0006,'"+str(disk_tamanho)+"')"

					fichero.write(caracteristica_discoduro_tamanho)
					fichero.write(" \n")
	  
					cursor.execute(caracteristica_discoduro_tamanho)
					cursor.close()


					cursor=db.cursor()
					caracteristica_discoduro_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0030,0006,'"+str(disk_descripcion.replace("\'",""))+"')" 

					fichero.write(caracteristica_discoduro_descripcion)
					fichero.write(" \n")
	 
					cursor.execute(caracteristica_discoduro_descripcion)
					cursor.close()

					cursor=db.cursor()
					caracteristica_discoduro_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0031,0006,'"+str(disk_producto.replace("\'",""))+"')"  

					fichero.write(caracteristica_discoduro_producto)
					fichero.write(" \n")

					cursor.execute(caracteristica_discoduro_producto)
					cursor.close()

					cursor=db.cursor()
					caracteristica_discoduro_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0032,0006,'"+str(disk_vendedor.replace("\'",""))+"')"  
					fichero.write(caracteristica_discoduro_vendedor)
					fichero.write(" \n")

					cursor.execute(caracteristica_discoduro_vendedor)
					cursor.close()
					print"Insertado"

					fichero.write("Insertado")
					fichero.write(" \n")

			
				print "-------------------------------------------------------------"
				print ""

				fichero.write("-------------------------------------------------------------")
				fichero.write(" \n")
	
	##Caso en que exista mas de un disco duro
		r=10
		for cont in range(0,r,1):
			find_disks = etree.XPath(".//node[@class='disk:"+str(cont)+"']")
			disk_tamanho = 0
			numdisks = 0
			disk_descripcion=''
			disk_vendedor=''
			disk_producto=''

			for disk in find_disks(inventory):
			# has to be a hard-disk
				if disk.find('size') is not None:
					print "Disco Duro "+str(numdisks)+""

					valor="Disco Duro"+str(numdisks)
					fichero.write(valor)
					fichero.write(" \n")

					numdisks = numdisks + 1
				##Si encontramos un class='disk' que tenga la caracteristica size,significa que es un disco duro,entonces ya encontramos uno
				
				##Disco Duro ->Caracterticas 
		
				##Tamanho=0033
					disk_tamanho = int(disk.find('size').text)
					print 'Capacidad:', disk_tamanho/(1024*1024**2)
					disk_tamanho=disk_tamanho/(1024*1024**2)
				
					valor="Capacidad: "+str(disk_tamanho/(1024*1024**2))
					fichero.write(valor)
					fichero.write(" \n")
				

				##Descripcion =0030
					if disk.find('description') is not None:
						print 'Descripcion : ' ,disk.find('description').text
						disk_descripcion=str(disk.find('description').text)
					
						valor="Descripcion: "+disk.find('description').text
						fichero.write(valor)
						fichero.write(" \n")
					
		
				##Producto =0031		
					if disk.find('product') is not None:
						print 'Producto : ' ,disk.find('product').text
						disk_producto=str(disk.find('product').text)
					
						valor="Producto: "+disk.find('product').text
						fichero.write(valor)
						fichero.write(" \n")
			
				##Vendedor=0032	
					if disk.find('vendor') is not None:
						print 'Vendedor : ' ,disk.find('vendor').text
						disk_vendedor=str(disk.find('vendor').text)

						valor="Vendedor: "+disk.find('vendor').text
						fichero.write(valor)
						fichero.write(" \n")
			
					
					opcion_insertar_disk = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
					if opcion_insertar_disk=='s':
						##Insertamos el elemento

						cursor=db.cursor()
						elemento_discoduro="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0006,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

						fichero.write(elemento_discoduro)
						fichero.write(" \n")

						cursor.execute(elemento_discoduro)
						id_max=id_max+1
						cursor.close()
					##Insertamos las caracteristicas


						cursor=db.cursor()
						caracteristica_discoduro_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0033,0006,'"+str(disk_tamanho)+"')"

						fichero.write(caracteristica_discoduro_tamanho)
						fichero.write(" \n")
	  
						cursor.execute(caracteristica_discoduro_tamanho)
						cursor.close()


						cursor=db.cursor()
						caracteristica_discoduro_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0030,0006,'"+str(disk_descripcion.replace("\'",""))+"')"  

						fichero.write(caracteristica_discoduro_descripcion)
						fichero.write(" \n")

						cursor.execute(caracteristica_discoduro_descripcion)
						cursor.close()

						cursor=db.cursor()
						caracteristica_discoduro_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0031,0006,'"+str(disk_producto.replace("\'",""))+"')"  

						fichero.write(caracteristica_discoduro_producto)
						fichero.write(" \n")

						cursor.execute(caracteristica_discoduro_producto)
						cursor.close()

						cursor=db.cursor()
						caracteristica_discoduro_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0032,0006,'"+str(disk_vendedor.replace("\'",""))+"')"  
					
						fichero.write(caracteristica_discoduro_vendedor)
						fichero.write(" \n")

						cursor.execute(caracteristica_discoduro_vendedor)
						cursor.close()
						print"Insertado"
					
						fichero.write("Insertado")
						fichero.write(" \n")

					print "-------------------------------------------------------------"
					print ""

					fichero.write("-------------------------------------------------------------")
					fichero.write(" \n")
	


		##Memoria Ram Id:0003


	##Inicializamos variables
		ram_descripcion=''
		ram_vendedor=''
		ram_producto=''
		ram_tamanho=0
		ram_frecuencia=0
		ram_bits=''

	##Primero el caso de que solo tenga una memoria RAM
		find_mem = etree.XPath(".//node[@id='bank']")


		for mem in find_mem(inventory):
	    # busco la memoria ram
		##Se inserta la memoria Ram
			print "Memoria RAM"
		
			fichero.write("Memoria RAM")
			fichero.write(" \n")
	
		##Memoria Ram ->Caracterticas 
	
		##Tamanho=0012
	    		if mem.find('size')is not None :
				ram_tamanho = int(mem.find('size').text)
				print 'Capacidad:', ram_tamanho/(1024**2)
				ram_tamanho=ram_tamanho/(1024**2)
		
				valor="Capacidad: "+str(ram_tamanho/(1024**2))
				fichero.write(valor)
				fichero.write(" \n")
		
		##Descripcion=0010
			if disk.find('description') is not None:
				print 'Descripcion : ' ,disk.find('description').text
				ram_descripcion=str(disk.find('description').text)
			
				valor="Descripcion: "+disk.find('description').text
				fichero.write(valor)
				fichero.write(" \n")
	
		##Vendedor=0011
			if disk.find('vendor') is not None:
				print 'Vendedor : ' ,disk.find('vendor').text
				ram_vendedor=str(disk.find('vendor').text)
			
				valor="Vendedor: "+disk.find('vendor').text
				fichero.write(valor)
				fichero.write(" \n")

		##N Bits=0013
			if disk.find('width') is not None:
				print 'N Bits : ' ,disk.find('width').text
				ram_bits=str(disk.find('width').text)
				
				valor="N Bits: "+disk.find('width').text
				fichero.write(valor)
				fichero.write(" \n")
			
	
		##Frecuencia=0014
			if disk.find('clock') is not None:
				print 'Frecuencia(Hz) : ' ,disk.find('clock').text
				ram_frecuencia=str(disk.find('clock').text)
				ram_frecuencia=ram_frecuencia/1000000
			
				valor="Frecuencia(Hz) : "+ram_frecuencia
				fichero.write(valor)
				fichero.write(" \n")

		##Producto=0041
			if disk.find('product') is not None:
				print 'Producto : ' ,disk.find('product').text
				ram_producto=str(disk.find('product').text)

				valor="Producto : "+disk.find('product').text
				fichero.write(valor)
				fichero.write(" \n")
			

			opcion_insertar_disk = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
			if opcion_insertar_disk=='s':
					##Insertamos el elemento	
		

				cursor=db.cursor()
				elemento_memoriaRam="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0003,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

				fichero.write(elemento_memoriaRam)
				fichero.write(" \n")

				cursor.execute(elemento_memoriaRam)
				id_max=id_max+1
				cursor.close()

					##Insertamos las caracteristicas

				cursor=db.cursor()
				caracteristica_memoriaRam_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0012,0003,'"+str(ram_tamanho)+"')"

				fichero.write(caracteristica_memoriaRam_tamanho)
				fichero.write(" \n")
	  
				cursor.execute(caracteristica_memoriaRam_tamanho)
				cursor.close()
			
				cursor=db.cursor()
				caracteristica_memoriaRam_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0010,0003,'"+str(ram_descripcion.replace("\'",""))+"')"  
			
				fichero.write(caracteristica_memoriaRam_descripcion)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_descripcion)
				cursor.close()

				cursor=db.cursor()
				caracteristica_memoriaRam_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0011,0003,'"+str(ram_vendedor.replace("\'",""))+"')"  

				fichero.write(caracteristica_memoriaRam_vendedor)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_vendedor)
				cursor.close()	


				cursor=db.cursor()
				caracteristica_memoriaRam_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0013,0003,'"+str(ram_bits)+"')" 

				fichero.write(caracteristica_memoriaRam_bits)
				fichero.write(" \n")
	 
				cursor.execute(caracteristica_memoriaRam_bits)
				cursor.close()


				cursor=db.cursor()
				caracteristica_memoriaRam_frecuencia="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0014,0003,'"+str(ram_frecuencia)+"')"  
			
				fichero.write(caracteristica_memoriaRam_frecuencia)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_frecuencia)
				cursor.close()


				cursor=db.cursor()
				caracteristica_memoriaRam_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0041,0003,'"+str(ram_producto.replace("\'",""))+"')"  

				fichero.write(caracteristica_memoriaRam_producto)
				fichero.write(" \n")

				cursor.execute(caracteristica_memoriaRam_producto)
				cursor.close()
				print"Insertado"
			
				fichero.write("Insertado")
				fichero.write(" \n")
			
			print "-------------------------------------------------------------"
			print""

			fichero.write("-------------------------------------------------------------")
			fichero.write(" \n")

	##Caso en que exista mas de una memoria Ram
	## ------------------------------------------------------------------------------------
		r=10
		for cont in range(0,r,1):

			find_mem = etree.XPath(".//node[@id='bank:"+str(cont)+"']")
			
			for mem in find_mem(inventory):
			# busco la memoria ram
			##Se inserta la memoria Ram
				if mem.find('size')is not None :
					print "Memoria RAM"+str(cont)+""

					valor="Memoria RAM"+str(cont)
					fichero.write(valor)
					fichero.write(" \n")
		
			##Memoria Ram ->Caracterticas 
	
			##Tamanho=0012
					if mem.find('size')is not None :
						ram_tamanho = int(mem.find('size').text)
						print 'Capacidad:', ram_tamanho/(1024**2)
						ram_tamanho=ram_tamanho/(1024**2)
				
						valor="Capacidad:"+str(ram_tamanho/(1024**2))
						fichero.write(valor)
						fichero.write(" \n")
				
			##Descripcion=0010
					if mem.find('description') is not None:
						print 'Descripcion : ' ,mem.find('description').text
						ram_descripcion=str(mem.find('description').text)
				
						valor="Descripcion:"+mem.find('description').text
						fichero.write(valor)
						fichero.write(" \n")
				
			##Vendedor=0011
					if mem.find('vendor') is not None:
						print 'Vendedor : ' ,mem.find('vendor').text
						ram_vendedor=str(mem.find('vendor').text)
				
						valor="Vendedor :"+mem.find('vendor').text
						fichero.write(valor)
						fichero.write(" \n")

			##N Bits=0013
					if mem.find('width') is not None:
						print 'N Bits : ' ,mem.find('width').text
						ram_bits=str(mem.find('width').text)
				
						valor="N Bits :"+mem.find('width').text
						fichero.write(valor)
						fichero.write(" \n")
	
			##Frecuencia=0014
					if mem.find('clock') is not None:
						print 'Frecuencia(Hz) : ' ,mem.find('clock').text
						ram_frecuencia=int(mem.find('clock').text)
						ram_frecuencia=ram_frecuencia/1000000
				
						valor="Frecuencia(Hz):"+mem.find('clock').text
						fichero.write(valor)
						fichero.write(" \n")

			##Producto=0041
					if mem.find('product') is not None:
						print 'Producto : ' ,mem.find('product').text
						ram_producto=str(mem.find('product').text)
				
						valor="Producto:"+mem.find('product').text
						fichero.write(valor)
						fichero.write(" \n")


					opcion_insertar_ram = raw_input("Desea insertar el elemento (s/n mas Enter): ")	
					if opcion_insertar_ram=='s':
						##Insertamos el elemento	
		

						cursor=db.cursor()
						elemento_memoriaRam="insert into element(id_type_element,id_padre,carbono,existe,id_destino_origen,fecha_alta) values (0003,0000,0.00,'S',"+str(id_destino_origen)+",'"+str(hoy)+"')"

						fichero.write(elemento_memoriaRam)
						fichero.write(" \n")

						cursor.execute(elemento_memoriaRam)
						id_max=id_max+1
						cursor.close()
		
					##Insertamos las caracteristicas

						cursor=db.cursor()
						caracteristica_memoriaRam_tamanho="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0012,0003,'"+str(ram_tamanho)+"')"

						fichero.write(caracteristica_memoriaRam_tamanho)
						fichero.write(" \n")
	  
						cursor.execute(caracteristica_memoriaRam_tamanho)
						cursor.close()
			
						cursor=db.cursor()
						caracteristica_memoriaRam_descripcion="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0010,0003,'"+str(ram_descripcion.replace("\'",""))+"')"  

						fichero.write(caracteristica_memoriaRam_descripcion)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_descripcion)
						cursor.close()

						cursor=db.cursor()
						caracteristica_memoriaRam_vendedor="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0011,0003,'"+str(ram_vendedor.replace("\'",""))+"')"  

						fichero.write(caracteristica_memoriaRam_vendedor)
						fichero.write(" \n")


						cursor.execute(caracteristica_memoriaRam_vendedor)
						cursor.close()	


						cursor=db.cursor()
						caracteristica_memoriaRam_bits="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0013,0003,'"+str(ram_bits)+"')"  

						fichero.write(caracteristica_memoriaRam_bits)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_bits)
						cursor.close()


						cursor=db.cursor()
						caracteristica_memoriaRam_frecuencia="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0014,0003,'"+str(ram_frecuencia)+"')"

						fichero.write(caracteristica_memoriaRam_frecuencia)
						fichero.write(" \n")
	  
						cursor.execute(caracteristica_memoriaRam_frecuencia)
						cursor.close()
	

						cursor=db.cursor()
						caracteristica_memoriaRam_producto="insert into data_charac_element(id_element,id_charac_type,id_type_element,value_charac) values ("+str(id_max)+" ,0041,0003,'"+str(ram_producto.replace("\'",""))+"')"  

						fichero.write(caracteristica_memoriaRam_producto)
						fichero.write(" \n")

						cursor.execute(caracteristica_memoriaRam_producto)
						cursor.close()
						print"Insertado"
				
						fichero.write("Insertado")
						fichero.write(" \n")
					print "-------------------------------------------------------------"

					fichero.write("-------------------------------------------------------------")
					fichero.write(" \n")
					print ""




	

else:
	cursor.close()
	print "-------------------------------------------------------------"
	fichero.write("-------------------------------------------------------------")
	fichero.write(" \n")
	print "-------------------------------------------------------------"
	print "---------------------No existe el identificador------------------------"
	fichero.write("----------------------No existe el identificador----------------------------------")
	fichero.write(" \n")
	print "-------------------------------------------------------------"
	print "-------------------------------------------------------------"

	##Guardo en el log la ip fallida
	valor="La ip con la que se intento conectar es :"+ip
	fichero.write(valor)
	fichero.write(" \n")


#Renombro el fichero de log con el id del padre como ultimo elemento
fichero_aux_final=fichero_aux.split('_')[0]
fichero_aux_final=fichero_aux_final+"_"+str(id_padre)+".log"
os.rename(fichero_aux,fichero_aux_final)


#Renombro el fichero de xml con el id del padre como ultimo elemento
xml_aux_final=xml_aux.split('_')[0]
xml_aux_final=xml_aux_final+"_"+str(id_padre)+".xml"
os.rename(xml_aux,xml_aux_final)


##Muevo los ficheros a sus respectivas carpetas



fichero_aux_xml=xml_aux_final.split('/')[-1]

shutil.copyfile(fichero_aux_final,"/home/lector/lshwXmlFiles/"+fichero_aux_final)
shutil.copyfile(xml_aux_final,"/home/lector/lshwXmlFiles/"+fichero_aux_xml)

##Borro los ficheros iniciales

os.remove(fichero_aux_final)


os.remove(fichero_aux_xml)

##Fin