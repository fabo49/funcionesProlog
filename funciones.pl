%--- maximo/3(+V1, +V2, -Resultado)
%Indica cual es mayor entre las dos opciones que recibe.
maximo(V1, V2, Resultado):-
    (V1>=V2 ->  Resultado is V1; Resultado is V2).

%--- tamano/2(+Lista, -Tamano)
%Retorna en "Tamano" la cantidad de elementos
%que tiene "Lista"
tamano([], 0).
tamano([_|Cola], T) :-
    tamano(Cola, R), T is R+1.

%--- miembro/2(+Elemento, +Lista)
%Retorna true si "Elemento" pertenece a "Lista"
miembro(_, []) :- false.
miembro(Elem, [Cabeza|_]) :-
    Elem == Cabeza.
miembro(Elem, [Cabeza|Cola]):-
    Elem \== Cabeza, miembro(Elem, Cola).

%--- nesimo/3(+Indice, +Lista, -Elemento)
%Retorna el elemento que se encuentra en la n-esima
%posicion de la lista.
%Si la lista esta vacia o el indice del elemento es mayor que el tamaño de la lista
%entonces retorna false.
nesimo(_, [], false).%retorna false si la lista esta vacia
nesimo(Indice, Lista, false) :-
    tamano(Lista, Tama), Indice > Tama.%Retorna false si el indice es mayor que el tamano de la lista
nesimo(1, [Cabeza|_], Cabeza). %Si busca el primer elemento, retorna la cabeza
nesimo(Indice, [_|Cola], Retorno) :-
    SegundoIndice is Indice-1, nesimo(SegundoIndice, Cola, Retorno).

%--- maximo/2(+Lista, -Elemento)
%Retorna en "Elemento" el máximo elemento de "Lista"
%Si la lista viene vacia entonces retorna true.
maximo([Cabeza], Cabeza).
maximo([Cabeza|Cola], Max) :-
    maximo(Cola, MaxTmp),
    ((Cabeza >= MaxTmp, Max is Cabeza); Max is MaxTmp), !.

%--- sumalista/2(+Lista, -Resultado)
%Suma todos los elementos de la lista "Lista" y lo retorna en "Resultado"
sumalista([Cabeza], Cabeza).
sumalista([Cabeza|Cola], Resultado) :-
    sumalista(Cola, ResultadoTmp),
    Resultado is ResultadoTmp + Cabeza, !.

%--- concatena/3(+Lista1, +Lista2, -Concatenadas)
%Se encarga de concatenar la Lista1 con la Lista2 y lo retorna en
%"Concatenadas".
concatena([], L2, L2).
concatena(L1, [], L1).
concatena([Cabeza|Cola], L2, [Cabeza|Resto]) :-
    concatena(Cola, L2, Resto), !.

%--- ultimo/2(+Lista, -Retorno)
%Retorna el ultimo elemento de la lista que recibe.
ultimo([Cabeza], Cabeza).
ultimo([_|C], Elem) :-
    ultimo(C, Elem), !.

%--- palindromo/2(+Lista, -Resultado)
%Se encarga de ver si lo que viene en la lista es un palindromo.
palindromo([Cabeza], true).
palindromo(Lista, Resultado) :-
    reversa(Lista, ListaAlrevez),
    palindromo_aux(Lista, ListaAlrevez, Resultado).

%--- palindromo_aux/3(+Lista, +ListaReversa, -Resultado)
%Ayudante de palindromo que revisa si las listas son iguales.
palindromo_aux([Cabeza], [Cabeza2], Resultado):-
    ((Cabeza == Cabeza2) -> Resultado = true; Resultado = false).
palindromo_aux([C1|T1], [C2|T2], Resultado):-
    ((C1 == C2) ->  palindromo_aux(T1, T2, Resultado); Resultado = false), !.

%--- reversa/2(+Lista, -ListaInversa)
%Se encarga de invertir una lista.
reversa([Elemento], Elemento).
reversa(Lista, Retorno) :-
        reversa_aux(Lista, [], Retorno).

%--- reversa_aux/3(+ARevertir, +Pila, -ListaInversa)
%Auxiliar de reversa, lleva una pila para poder darle la vuelta
%a la lista que se desea.
reversa_aux([], Pila, Pila).
reversa_aux([Cabeza|Cola], Pila, Retorno) :-
    reversa_aux(Cola, [Cabeza|Pila], Retorno).

%--- union/3(+Conjunto1, +Conjunto2, -Resultado)
%Retorna la union del Conjunto1 con el Conjunt2
union(Conjunto1, [], Conjunto1) :- !.
union([], Conjunto2, Conjunto2) :- !.
union(Conjunto1, Conjunto2, Resultado) :-
    union_aux(Conjunto1, Conjunto2, Conjunto2, Resultado).

%--- union_aux/4(+Conjunto1, +Conjunto2, +Pila, -Resultado)
%Metodo auxiliar de union que va acomulando en la pila el resultado
union_aux([], _, Pila, Pila) :- !.
union_aux([], Conjunto2, [], Conjunto2) :- !.
union_aux([Cabeza|Cola], Conjunto2, Pila, Resultado) :-
    ((miembro(Cabeza, Conjunto2)) ->  union_aux(Cola, Conjunto2, Pila, Resultado);
    union_aux(Cola, Conjunto2, [Cabeza|Pila], Resultado)), !.

%--- interseccion/3(+Conjunto1, +Conjunto2, -Resultado)
%Metodo que encuentra la interseccion entre dos conjuntos representados por una lista.
interseccion(_, [], Resultado) :- Resultado = [], !.
interseccion([], _, Resultado) :- Resultado = [], !.
interseccion(C1, C2, Resultado) :-
    interseccion_aux(C1, C2, [], Resultado).

%--- interseccion_aux/4(+Conjunto1, +Conjunto2, +Pila, -Resultado)
%Ayudante de interseccion que tiene una pila donde va creando la interseccion de los
%conjuntos y lo retorna en "Resultado"
interseccion_aux([], _, Pila, Pila) :- !.
interseccion_aux([Cabeza|Cola], Conjunto2, Pila, Resultado) :-
    ((miembro(Cabeza, Conjunto2),
    interseccion_aux(Cola, Conjunto2, [Cabeza|Pila], Resultado));
    interseccion_aux(Cola, Conjunto2, Pila, Resultado)), !.
