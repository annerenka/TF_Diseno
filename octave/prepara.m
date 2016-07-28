## Copyright (C) 2015 Nicolás Jares
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

# Uso:
#   prepara(input,p)
#
# Donde input es una ruta a un archivo y p un vector
# Toma el archivo en input, que debe ser un vector de flujos
# por arista de un grafo, y un vector p de 5 componentes que
# marca los extremos de los intervalos dentro de los cuales
# se les asignaran los distintos estilos a cada arista en
# funcion de su volumen de flujo.
# Genera dos archivos, mapa1 y mapa2, que contienen matrices
# de ax7, donde a es la cantidad de aristas del grafo, y cada
# fila contiene en la primera entrada el estilo de esa arista
# y en las siguientes 6 entradas las coordenadas (x,y,z) de 
# los nodos extremos de esa arista.
#
function prepara(input,p)
reg_A=load('reg_A');
aristas_redondeado=load('aristas_redondeado');
v_1=load(input);
v_1=round(v_1_1);
mapa1=[];
mapa2=[];
for i=1:2000
	if v_1(i)==0
		estilo=1;
	elseif v_1(i)<p(1)
		estilo=2;
	elseif v_1(i)>=p(1) && v_1(i)<p(2)
		estilo=3;
	elseif v_1(i)>=p(2) && v_1(i)<p(3)
		estilo=4;
	elseif v_1(i)>=p(3) && v_1(i)<p(4)
		estilo=5;
	elseif v_1(i)>=p(4) && v_1(i)<p(5)
		estilo=6;
	elseif v_1(i)>=p(5)
		estilo=7;
	end
	mapa1=[mapa1;[estilo aristas_redondeado(i,:)]];
end
for i=2001:reg_A(1)
	if v_1(i)==0
		estilo=1;
	elseif v_1(i)<p(1)
		estilo=2;
	elseif v_1(i)>=p(1) && v_1(i)<p(2)
		estilo=3;
	elseif v_1(i)>=p(2) && v_1(i)<p(3)
		estilo=4;
	elseif v_1(i)>=p(3) && v_1(i)<p(4)
		estilo=5;
	elseif v_1(i)>=p(4) && v_1(i)<p(5)
		estilo=6;
	elseif v_1(i)>=p(5)
		estilo=7;
	end
	mapa2=[mapa2;[estilo aristas_redondeado(i,:)]];
end
dlmwrite('mapa1',mapa1,' ')
dlmwrite('mapa2',mapa2,' ')
endfunction
