## Copyright (C) 2015 Nicolás Jares
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

nombre_de_mapa = "mapa"
encabezado = "<?xml version='1.0' encoding='UTF-8'?><kml xmlns='http://www.opengis.net/kml/2.2'><Document><name>"+nombre_de_mapa+"</name><description><![CDATA[]]></description><Folder><name>Carpeta</name>"
read_data = open('input')
lineas = read_data.readlines()
print (encabezado)
for i in range(len(lineas)):
	coordinates = lineas[i].split(" ")
	print("<Placemark><name>Linea "+str(i+1)+"</name><styleUrl>#line-000000-"+str(coordinates[0])+"-nodesc</styleUrl><ExtendedData></ExtendedData><LineString><tessellate>1</tessellate>")
	print("<coordinates>"+str(coordinates[1])+","+str(coordinates[2])+","+str(coordinates[3])+" "+str(coordinates[4])+","+str(coordinates[5])+","+str(coordinates[6])+"</coordinates></LineString></Placemark>")
print("</Folder>")
print("</Document>")
print("</kml>")
