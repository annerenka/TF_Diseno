# Uso:
#
#	genera_costo_aristas(in1,in2,in3,in4,in5,in6)
#
# Donde, "in1", "in2", "in3", "in4", "in5" e "in6" deben ser 
# direcciones de archivos.
# in1 = reg_A
# in2 = nodos_lineas
# in3 = aristas_redondeado
# in4 = indice_paradas
# in5 = paradas
# in6 = nodos
# Toma el archivo in1, una matriz de 1x4, de registro del 
# %*tamaño*) de matriz_A luego de agregar aristas en 
# genera_matriz_A_2'; el archivo in2, una matriz de 
# nx(2*m+2), de indices de los nodos que recorre cada linea; 
# el archivo in3, una matriz de ax6, de coordenadas de inicio
# y fin de cada arista; el archivo in4, una matriz de nxm, de
# %*índices*) de las paradas (%*según*) 'paradas') de las paradas que
# recorre cada linea; el archivo in5, una matriz de 1xp, de
# indices de los nodos a donde %*está*) cada parada en el grafo;
# y el archivo in6, una matriz de lx2, de coordenadas en las
# que se encuentra cada nodo; y genera 1 archivo:
#   "costo_aristas": un archivo que contiene una matriz de 
#       kx1, donde k es la cantidad de aristas del grafo dado
#       por 'matriz_A_2', donde cada entrada contiene el 
#       costo de recorrer esa arista en el grafo.
#
function genera_costo_aristas(in1,in2,in3,in4,in5,in6)
	reg_A=load(in1);
	nodos_lineas=load(in2);
	a_red=load(in3);
	indice_paradas=load(in4);
	paradas=load(in5);
	nodos=load(in6);

# encontrar las aristas que tengan costo cero

	A_0_1=repmat([1;3;4],1,(reg_A(2)-reg_A(1))/4);
	A_0_2=repmat([0:(reg_A(2)-reg_A(1))/4-1]*4+reg_A(1),3,1);
	A_0=A_0_1+A_0_2;
	A_0=reshape(A_0,[],1); 
	cant_lineas=rows(nodos_lineas);
	i_n_r=[nodos_lineas(:,2:columns(nodos_lineas)) > 0,zeros(cant_lineas,1)];
	A_0_3=i_n_r.*repmat([1 2],cant_lineas,columns(nodos_lineas)/2);
	A_0_3(:,1)=A_0_3(:,1)*2;
	A_0_3=A_0_3+full(sparse(1:cant_lineas,sum(i_n_r')',1,cant_lineas,columns(A_0_3)));
	A_0_3=reshape(A_0_3',[],1);
	A_0_3=A_0_3(find(A_0_3))-1;
	A_0_3=find(A_0_3)+reg_A(2);
	A_0=[A_0;A_0_3];
	A_0_4=[reg_A(3)+1:reg_A(4)]';
	A_0=[A_0;A_0_4];
	
# asignarle a cada arista del grafo original su peso

	costo_g_o=sum(abs(a_red(:,4:6)-a_red(:,1:3))');
	costo_g_o(reg_A(4))=0;

# asignarle a cada arista de transbordo su costo

	A_T_i=setdiff((reg_A(1)+1):reg_A(2),A_0);
	A_T=sparse(A_T_i,1,10*mean(costo_g_o(find(costo_g_o))),reg_A(4),1);

# asignarle a cada arista de linea su peso

	A_l_i=setdiff([reg_A(2)+1:reg_A(3)],A_0);
	C_l_1=indice_paradas(:,[1:columns(indice_paradas)-1]);
	C_l_2=indice_paradas(:,2:columns(indice_paradas));
	C_l=[C_l_1,C_l_2];
	C_l=reshape(C_l,cant_lineas,[],2);
	C_l=permute(C_l,[3 2 1]);
	C_l=reshape(C_l,2,[])';
	C_l_i=prod((C_l != 0)')';
	C_l_i=find(C_l_i);
	C_l=C_l(C_l_i,:);
	C_l(:,1)=paradas(C_l(:,1));
	C_l(:,2)=paradas(C_l(:,2));
	A_l_1(:,1:2)=nodos(C_l(:,1),:);
	A_l_1(:,3:4)=nodos(C_l(:,2),:);
	A_l=sparse(A_l_i,1,sum(abs(A_l_1(:,1:2)-A_l_1(:,3:4))')',reg_A(4),1);
	costo_aristas=costo_g_o'+A_T+A_l;
	dlmwrite("costo_aristas",costo_aristas,'	')	
endfunction
