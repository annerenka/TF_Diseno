nombre_de_mapa = "paradas"
encabezado = "<?xml version='1.0' encoding='UTF-8'?><kml xmlns='http://www.opengis.net/kml/2.2'><Document><name>"+nombre_de_mapa+"</name><description><![CDATA[]]></description><Folder><name>NombreFolder</name>"
read_data = open('paradas_maps')
lineas = read_data.readlines()
print (encabezado)
for i in range(len(lineas)):
	coordinates = lineas[i].split(" ")
	print("<Placemark><name>Parada "+str(i+1)+"</name><styleUrl>#icon-503-DB4436-nodesc</styleUrl><ExtendedData></ExtendedData><Point><coordinates>"+str(coordinates[0])+","+str(coordinates[1])+","+"0</coordinates></Point></Placemark>")
print("</Folder>")
print("</Document>")
print("</kml>")
