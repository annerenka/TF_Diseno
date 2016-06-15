# Uso:
#
#	genera_g_OD(input1,input2,input3)
#
# Donde "input1", "input2" e "input3" deben ser direcciones 
# de archivos.
# input1 = lugares_UNC
# input2 = nodos_paradas
# input3 = nodos_lineas
# Toma el archivo input1, una matriz de nx2, de nodos 
# descriptos por indices de pares de aristas que tengan ese 
# nodo en %*común*); el archivo input2, una matriz de mx4, de 
# indices de nodos de paradas como el generado por 
# 'genera_matriz_A_2', y el archivo input3, una matriz de 
# pxl, de indices de nodos de lineas como el generado por 
# 'genera_matriz_A_2' y genera 1 archivo:
#	1- "g_OD": un archivo que contiene una matriz de gx2, 
#		donde g es la cantidad de pares origen-destino. Cada 
#		fila consta de dos elementos, que son los indices de 
#		los nodos de origen y destino, respectivamente.
#
# NOTA: usa nodo.m
#
function genera_g_OD(input1,input2,input3)
	lugares_UNC=load(input1);
	nodos_paradas=load(input2);
	nodos_lineas=load(input3);
	lugares_UNC=sort(nodo(lugares_UNC(:,1),lugares_UNC(:,2)));

# pares OD con origen en una linea de colectivo y destino en UNC

	origenes=nodos_lineas(:,1);
	destinos=lugares_UNC';
	g1(:,1)=reshape(repmat(origenes,1,rows(destinos))',[],1);
	g1(:,2)=repmat(destinos,rows(origenes),1);
	
# pares OD con origen en UNC y destino en una linea de colectivo

	origenes=-destinos;
	destinos=-max(nodos_lineas')';
	g2(:,1)=reshape(repmat(origenes,1,rows(destinos))',[],1);
	g2(:,2)=repmat(destinos,rows(origenes),1);
	g_OD=[g1;g2];
	dlmwrite("g_OD",g_OD,'	')
endfunction
