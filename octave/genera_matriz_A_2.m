# Uso:
#
#	genera_matriz_A_2(input1,input2)
#
# Donde "input1" e "input2" deben ser rutas a un archivos.
# input1=lineas
# input2=matriz_A
# Toma el archivo input1, una matriz de (m+1)x2n de 
# %*descripción*) de paradas de las lineas, y el archivo input2, 
# una matriz de 2kx3, de %*descripción*) de la matriz de incidencia 
# del grafo, y genera 6 archivos:
#	1- "paradas": un archivo que contiene una matriz de 1xp, 
#		donde p es la cantidad de paradas que hay en total en 
#		el grafo. Cada entrada es el %*índice*) del nodo sobre el 
#		que %*está*) la parada.
#	2- "indice_paradas": un archivo que contiene una matriz 
#		de nxm, donde n es la cantidad de lineas, y m es la 
#		cantidad %*máxima*) de paradas. Cada fila contiene los 
#		%*índices*) de las paradas de esa linea, %*según*) el archivo 
#		'paradas', en el orden en el que son recorridas, 
#		completadas con ceros de ser necesario.
#	3- "nodos_paradas": un archivo que contiene una matriz de 
#		px4, donde p es la cantidad de paradas. Cada fila se 
#		inicia con el indice del nodo en el que se encuentra 
#		la parada en el grafo, y a %*continuación*) los indices de 
#		los tres nodos que genera para cada parada, i_1, i_2 
#		e i_3. Estos nuevos nodos %*están*) conectados de la 
#		siguiente manera:
#
#           p -- > i_1 --> i_2 --> i_3
#           |                       ^
#           |                       |
#           -------------------------
#
#		Donde la arista i_1 --> i_2 es la arista de 
#		transbordo, y el resto tienen costo 0. Ademas, las 
#		aristas que tenian origen en p ahora tienen origen en 
#		el nodo i_3.
#	4- "nodos_lineas": un archivo que contiene una matriz de 
#		nx(2m+2), donde n es la cantidad de lineas, y m es la 
#		cantidad %*máxima*) de paradas. Cada fila contiene los 
#		indices de los nodos que genera para cada linea. 
#		Estos nuevos nodos %*están*) conectados de la siguiente 
#		manera:
#			El primer nodo es el nodo de inicio de la linea, 
#		y se conecta al segundo:
#
#       s --> 'primer parada'
#
#		A partir de %*ahí*), en cada parada hay dos nodos, 
#		conectados a los nodos de las paradas de la siguiente 
#		manera:
#
#       'parada ant.' --> i_4 --> i_5 --> 'parada sig.'
#                          |       ^
#                          v       |
#                   p --> i_1 --> i_2 --> i_3
#
#		Y el %*último*) nodo es el nodo de fin de linea y se 
#		conecta al de la %*última*) parada:
#
#       '%*última*) parada' --> f
#
#		La primera y la %*última*) arista generada tienen costo 
#		cero. Las aristas i_4 --> i_5, i_4 --> i_1 e 
#		i_2 --> i_5 tienen costo cero.
#	5- "matriz_A_2": un archivo que contiene una matriz de 
#		2*(k_2)x3, donde k_2 es la cantidad de aristas del 
#		nuevo grafo. De los tres elementos de cada fila, los 
#		primeros dos son la %*posición*) del elemento en la 
#		matriz_A_2, cuyo valor es el tercer elemento de la 
#		fila correspondiente. 
# sparse(matriz_A_2(:,1),matriz_A_2(:,2),matriz_A_2(:,3)) 
#		%*será*) una matriz de (k_2)x(l_2), donde k_2 es la 
#		cantidad de aristas del nuevo grafo y l_2 es la 
#		cantidad de nodos del nuevo grafo. Las filas de 
#		matriz_A_2 siguen el mismo criterio que las de 
#		matriz_A.
#	6- "reg_A": un archivo que contiene una matriz de 1x4. 
#		Cada entrada representa la cantidad de aristas que 
#		%*tenía*) el grafo a medida que se iban agregando en los 
#		distintos pasos.
#
#	NOTA: usa nodo.m
#
function y=genera_matriz_A_2(input1,input2)

# listar los nodos donde hay paradas

	lineas=load(input1);
	A=load(input2);
	A=sparse(A(:,1),A(:,2),A(:,3));
	cant_lineas=columns(lineas)/2;
	cant_paradas=reshape(lineas,rows(lineas),2,[]);
	cant_paradas=permute(cant_paradas,[1 3 2])(1,:,1);
	lineas=reshape(lineas,rows(lineas),2,[]);
	lineas=permute(lineas,[1 3 2]);
	lineas=reshape(lineas,[],2);
	paradas=nodo(lineas(:,1),lineas(:,2));
	[paradas,I,indice_paradas]=unique(paradas);
	paradas=paradas(2:columns(paradas));
	indice_paradas=reshape(indice_paradas-1,[],cant_lineas)';
	indice_paradas=indice_paradas(:,2:columns(indice_paradas));
	dlmwrite("paradas",paradas,'	')
	dlmwrite("indice_paradas",indice_paradas,'	')
	
# por cada nodo i con parada, agregar tres nodos, i_1, i_2 e i_3

	nodos_paradas=[paradas' repmat((3*(1:columns(paradas))'.+columns(A)),1,3).+repmat([-2 -1 0],columns(paradas),1)];
	dlmwrite("nodos_paradas",nodos_paradas,'	')

# Cada arista con origen en el nodo i, ponerle origen en el nodo i_3

	A(:,nodos_paradas(:,4))=0.5*(abs(A(:,paradas))+A(:,paradas));
	A(:,paradas(:))=0.5*(A(:,paradas)-abs(A(:,paradas)));

# Crear 4 aristas para cada parada:
# 	i -> i_1	con costo cero
#	i_1 -> i_2	con costo de transbordo
#	i_2 -> i_3	con costo cero
#	i -> i_3	con costo cero

	reg_A(1)=rows(A);
	B1_i=reshape([(1:columns(paradas))*4-3;(1:columns(paradas))*4],[],1);
	B1_j=reshape([paradas;paradas],[],1);
	B1=sparse(B1_i,B1_j,1);
	if (columns(B1)!=columns(A)-size(paradas,2)*3)
		B1(rows(B1),columns(A)-size(paradas,2)*3)=0;
	endif
	C=sparse([1 2 2 3 3 4],[1 1 2 2 3 3],[-1 1 -1 1 -1 1]);
	C1=[C,zeros(4,3*columns(paradas))];
	C1=[repmat(C1,1,columns(paradas)-1),C];
	C1=full(C1);
	C1=reshape(permute(reshape(C1,4,3*columns(paradas),[]),[1 3 2]),4*columns(paradas),[]);
	[i j x]=find(C1);
	C1=sparse(i,j,x);
	A=[A;B1,C1];

# Agregar las lineas al grafo
# Para cada linea, crear nodos de inicio y fin, s y f
# Para cada parada, crear dos nodos, i_4 e i_5
	
	c_p_max=max(2*cant_paradas.+2);
	nodos_lineas=repmat(1:c_p_max,cant_lineas,1);
	indices_n_l= (nodos_lineas <= repmat(2*cant_paradas'.+2,1,columns(nodos_lineas)));
	nodos_lineas =  indices_n_l.* nodos_lineas;
	aux_n_l=columns(A).+2*(1:cant_lineas)'.-2+2*sum(triu(repmat(cant_paradas',1,cant_lineas),1))';
	nodos_lineas=nodos_lineas+repmat(aux_n_l,1,columns(nodos_lineas));
	nodos_lineas =  indices_n_l.* nodos_lineas;
	dlmwrite("nodos_lineas",nodos_lineas,'	')

# Crear 4 aristas para cada parada:
#	i-1 -> i_4
#	i_4 -> i_5	con costo cero
# crear arista final e incial con costo cero

	reg_A(2)=rows(A);
	C2_j1=(indices_n_l+sparse(1:cant_lineas,2*cant_paradas.+2,-1)).*nodos_lineas;
		%los que llevan 1
	C2_j2=nodos_lineas;
	C2_j2(:,1)=zeros(rows(C2_j2),1);
		% los que llevan -1
	C2_j1=sort(reshape(C2_j1,[],1)(find(reshape(C2_j1,[],1))));
	C2_j2=sort(reshape(C2_j2,[],1)(find(reshape(C2_j2,[],1))));
	C2_i=1:rows(C2_j1);
	C2_1=[sparse(C2_i,C2_j1,1),zeros(rows(C2_j1),1)];
	C2_2=sparse(C2_i,C2_j2,-1);
	C2=C2_1+C2_2;
	A(rows(A),columns(C2))=0;
	A=[A;C2];

#	i_4	-> i_1	con costo cero
#	i_2 -> i_5	con costo cero

	reg_A(3)=rows(A);
	i_p_aux=reshape(indice_paradas',[],1);
	i_p_aux=i_p_aux(find(i_p_aux));
	C3_i1=nodos_paradas(i_p_aux,2:3);
	C3_i1=reshape(C3_i1',[],1);
	C3_1=sparse([1:sum(cant_paradas)*2],C3_i1,repmat([-1 1],1,sum(cant_paradas)));
	C3_i2=(indices_n_l+sparse(1:cant_lineas,2*cant_paradas.+2,-1)).*nodos_lineas;
	C3_i2(:,1)=zeros(rows(C3_i2),1);
	C3_i2=reshape(C3_i2',[],1);
	C3_i2=C3_i2(find(C3_i2));
	C3_2=sparse([1:sum(cant_paradas)*2],C3_i2,repmat([1 -1],1,sum(cant_paradas)));
	C3_1(rows(C3_2),columns(C3_2))=0;
	C3=C3_1+C3_2;
	C3(rows(C3),columns(A))=0;
	%C3=int8(full(C3));
	A=[A;C3];
	reg_A(4)=rows(A);
	[i j x]=find(A);
	dlmwrite("matriz_A_2",[i j x],'	')
	dlmwrite("reg_A",reg_A,'	')
endfunction
