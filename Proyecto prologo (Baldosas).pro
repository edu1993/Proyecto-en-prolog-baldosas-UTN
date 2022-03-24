/* R = baldosa a examinar, D = baldosa derecha ya examinada, I = baldosa izquierda aun no examinada
Z = demás baldosas de la vereda
reparar(cantdad_blancos, cantidad_negros, cantidad_grises, vereda_rota, vereda_raparada) */

domains

 vereda=baldosas*
baldosas=char
b=integer
n=integer
g=integer
   
predicates
nondeterm reparar(integer,integer,integer,vereda,vereda)

clauses
/* si el primer elemento es 'r' */
reparar(B,N,G, [R,D|Z], Z1):- R = 'r', R1='b', R1 <> D, B > 0, B1=B-1, reparar(B1, N, G,[R1,D|Z],Z1).
reparar(B,N,G, [R,D|Z], Z1):- R = 'r', R1='n',  R1 <> D, N > 0, N1=N-1, reparar(B, N1, G,[R1,D|Z],Z1).
reparar(B,N,G, [R,D|Z], Z1):- R = 'r', R1='g', R1 <> D, G > 0, G1=G-1, reparar(B, N, G1,[R1,D|Z],Z1).



/* si un elemento intermedio es 'r' */
reparar(B,N,G,[I,R,D|Z], [I|Z1]):- R = 'r', R1='b', R1 <> D,R1 <> I, B > 0, B1=B-1,reparar(B1,N,G,[I,R1,D|Z], [I|Z1]).
reparar(B,N,G,[I,R,D|Z], [I|Z1]):- R = 'r', R1='n', R1 <> D,R1 <> I, N > 0, N1=N-1,reparar(B,N1,G,[I,R1,D|Z], [I|Z1]).
reparar(B,N,G,[I,R,D|Z], [I|Z1]):- R = 'r', R1='g', R1 <>D,R1 <> I, G > 0, G1=G-1,reparar(B,N,G1,[I,R1,D|Z], [I|Z1]).

/* si el elemento intermedio no es 'r' */
reparar(B,N,G,[I,R,D|Z], [I|Z1]):-not( R = 'r'),reparar(B,N,G,[I,R,D|Z], [I|Z1]).

/* si el elemento final es 'r' */						  
reparar(B,N,G,[I|R],[I,R1]):- R=['r'], R1='b',B > 0,N=0, G=0,B=B-1,R1<>I.
reparar(B,N,G,[I|R],[I,R1]):- R=['r'], R1='n',B=0,N > 0, G=0,N=N-1,R1<>I.
reparar(B,N,G,[I|R],[I,R1]):- R=['r'], R1='g',B=0,N=0, G > 0,G=G-1,R1<>I.
 /*si el elemento final no es 'r'*/
reparar(0,0,0,[I|R],[I|R]).                           
goal
reparar(3,1,3,['r','g','n','r','r','n','r','r','r','b','r','n'],W).