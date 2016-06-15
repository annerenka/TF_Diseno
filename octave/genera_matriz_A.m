# Uso:
#
#	genera_matriz_A(input)
#
# Donde "input" debe ser una ruta a un archivo.
# Toma el archivo input, una matriz de nx2 de %*índices*) de 
# aristas, y genera 1 archivo:
#	1- "matriz_A": un archivo que contiene una matriz de 
#		2nx3, donde n es la cantidad de aristas. De los tres
#		elementos de cada fila, los primeros dos son la 
#		%*posición*) del elemento en la matriz_A, cuyo valor es el
#		tercer elemento de la fila correspondiente.
#			
# sparse(matriz_A(:,1),matriz_A(:,2),matriz_A(:,3)) %*será*)
# una matriz de nxm, donde n es la cantidad de aristas y 
# m es la cantidad de nodos. Cada fila tiene un 1 en la 
# columna correspondiente al nodo donde se incia la 
# arista, un -1 en la columna correspondiente al nodo 
# donde finaliza la arista, y 0 en el resto de las 
# entradas.
#
function genera_matriz_A(input)
J=load(input);
A1=sparse(1:rows(J),J(:,1),1);
A2=sparse(1:rows(J),J(:,2),-1);
A=A1+A2;
[i,j,x]=find(A);
dlmwrite("matriz_A",[i j x],'	')
endfunction
