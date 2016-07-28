## Copyright (C) 2015 Nicolás Jares
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

# Uso:
#       [f,Df]=T(x,der)
#       f=T(x)
#
# Donde x es un vector, y der es un vector logico.
# Si der es especificado, el valor lógico de su primer y 
# segunda componente indican si calcular o no el valor de la
# funcion y su gradiente en el punto, respectivamente.
# Si der no es especificado, devuelve solo el valor de la 
# función en el punto.
#
# NOTA: para llamarla deben estar definidas como globales las
#   variables reg_A, c_a y delta
#
function [f,Df]=T(h,der)
f=[]; Df=[];
d=[true;false];
if nargin>1, d(1:length(der))=der; end
h=h(:);
global reg_A c_a Delta
v=Delta'*h;
if d(1)
	w=v;
	w(1:reg_A(1))=v(1:reg_A(1))-exp(-v(1:reg_A(1)));
	f=sum(c_a.*w);
endif
if d(2)
	z=[1+exp(-v(1:reg_A(1)));ones(length(v)-reg_A(1),1)];
	z=c_a.*z;
	Df=Delta*z;
endif
endfunction
