## Copyright (C) 2015 Nicolás Jares
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

# Uso:
#
#	genera_lineas(n)
#
# Donde "n" debe ser un número entero.
# Toma archivos de la forma "linea_i", donde i va desde 1 
# hasta n. Cada archivo debe contener una matriz de (m_i)x2, 
# donde en cada fila esten los indices de dos aristas que 
# compartan el nodo de una parada que pertenezca a la 
# linea_i. Las paradas así descritas deben estar en el orden 
# en el que son recorridas. Se genera 1 archivo:
#	1- "lineas": un archivo que contiene una matriz de 
#		(m+1)x2n, donde m es el mayor m_i encontrado. Cada 
#		par de columnas del archivo es de la forma:
#
#				m_i	0
#				---------
#				linea_i
#				---------
#				zeros(m-m_i,2)
#
function genera_lineas(n)
	for i = 1:n
		input = ["linea_" mat2str(i)];
		clear linea_aux;
		linea_aux=load(input);
		lineas(1,2*i-1)=rows(linea_aux);
		lineas(2:rows(linea_aux)+1,2*i-1:2*i)=linea_aux;
	endfor
	dlmwrite("lineas",lineas,'	')
endfunction
