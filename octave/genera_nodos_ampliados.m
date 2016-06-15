# Uso:
#
#	genera_nodos_ampliados(input1,input2,input3)
#
# Donde "input1", "input2" e "input3" deben ser direcciones
# de archivos.
# input1 = nodos
# input1 = indice_paradas
# input1 = paradas
# Dados input1, una matriz de nx2 de coordenadas de los nodos
# de un grafo, input2, una matriz de rxp de indices de 
# paradas (de %*ubicación*) en 'paradas') de las paradas que 
# recorre cada linea de colectivos, e input3, una matriz de
# 1xm, de indices de los nodos en los que %*está*) cada parada,
# genera un archivo:
#   'nodos_amp': un archivo que contiene una matriz de n_2x2,
#       de las coordenadas de los nodos de matriz_A_2, aunque
#       sean 'ficticios'
#
function genera_nodos_ampliados(input1,input2,input3)
	nodos=load(input1);
	indice_paradas=load(input2);
	paradas=load(input3);
	nodos_i=reshape(repmat(paradas,3,1),[],1);
	n_i_aux=reshape(repmat(indice_paradas,2,1),rows(indice_paradas),[]);
	n_i_aux=[n_i_aux(:,1) n_i_aux,zeros(rows(n_i_aux),1)];
	for i=1:rows(n_i_aux)
		i_aux=max(find(n_i_aux(i,:)));
		n_i_aux(i,i_aux+1)=n_i_aux(i,i_aux);
	endfor
	n_i_aux=reshape(n_i_aux',[],1);
	n_i_aux=n_i_aux(find(n_i_aux));
	nodos_i=[nodos_i;paradas(n_i_aux)'];
	nodos=[nodos;nodos(nodos_i,:)];
	dlmwrite("nodos_amp",nodos,'	')
endfunction
