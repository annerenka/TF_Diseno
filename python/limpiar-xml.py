# Importar la biblioteca que se va a usar
import xml.etree.ElementTree as etree 
# Cargar el árbol del archivo
tree = etree.parse('./Grafo-terminado.kml')
# Buscar los <Document> en el árbol
document_list = tree.findall('./Document') 
# Buscar los <Folder> en cada <Document>
for document in document_list:
	folder_list = document.findall('./Folder') 
# Buscar los <Placemark> en cada <Folder>
	for folder in folder_list:
		placemark_list = folder.findall('./Placemark') 
# Buscar los <coordinates> adentro de <LineString> en cada   <Placemark>
		for placemark in placemark_list:
			coordinate_list = placemark.findall('./LineString/coordinates') 
# Convertir a texto cada <coordinate>
			for coordinate in coordinate_list:
				coordinate_text = coordinate.text 
# Cortar la cadena de texto en cada caracter ' ' y guardarlo en values
				values = coordinate_text.split(' ')
# Cortar la cadena de texto en cada caracter ',' y guardarlo en x1, y1 y a1
				x1,y1,a1 = values[0].split(',') 
# IDEM, y guardarlo en x2, y2 y a2
				x2,y2,a2 = values[1].split(',')
# Imprimir el resultado
				print (x1+" "+y1+" "+" "+a1+" "+x2+" "+y2+" "+a2) 
