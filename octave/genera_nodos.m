## Copyright (C) 2015 Nicolás Jares
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

# Uso:
#
#	genera_nodos(input)
#
# Donde "input" debe ser una ruta a un archivo.
# Toma el archivo input, una matriz de nx6 de aristas, y 
# genera 3 archivos:
#	1- "indice_aristas": un archivo con una matriz de nx2, 
# 		donde cada fila contiene los %*índices*) de los nodos
# 		incial y final de esa arista, respectivamente.
#	2- "nodos": un archivo con una matriz de mx2, donde m es 
#		la cantidad de nodos del grafo. En cada fila estan 
#		las coordenadas del nodo en el mapa.
#	3- "aristas_redondeado": reescribe el archivo input, con 
# 		menos cantidad de %*dígitos*), pero aun suficientes, para 
#		que sea manipulable %*después*).
#
function genera_nodos(input)
X=load(input);
[nodos, I, J] = unique([X(:,1:2);X(:,4:5)],'rows','first');
J=reshape(J,[],2);
dlmwrite("indice_aristas",J,'	')
dlmwrite("nodos",nodos,'	')
dlmwrite("aristas_redondeado",X,'	')
endfunction
