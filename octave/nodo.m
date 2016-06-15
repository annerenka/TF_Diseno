# Uso:
#
#	y=nodo(i,j)
#
# Donde i y j deben ser %*números*) enteros, o vectores columna de 
# enteros del mismo %*tamaño*).
# Dados i y j, indices de aristas del grafo, si las aristas 
# i(k) y j(k) comparten el nodo n,entonces y(k)=n, sino 
# y(k)=0.
# Se tiene que 'y' %*será*) un vector de 1x(rows(i))
#
function y=nodo(i,j)
	indice_aristas=load("indice_aristas");
	I=find(i.*j);
	for k = I'
		if (length(intersect(indice_aristas(i(k),:),indice_aristas(j(k),:)))==0)
			y(k)=0;
		else
			y(k)=intersect(indice_aristas(i(k),:),indice_aristas(j(k),:));
		endif
	endfor
	z=zeros(1,rows(i)-columns(y));
	y=[y z];
endfunction 
