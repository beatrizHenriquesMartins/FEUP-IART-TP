/* ***********
 * Gramatica *
 *********** */

determinante(s-m) --> [o].
determinante(p-m) --> [os].
determinante(s-f) --> [a].

preposicao(_) --> [de].
preposicao(s-f) --> [da].

nome(p-m,rapazes) --> [rapazes].
nome(s-m,rapaz) --> [rapaz].
nome(s-m,rui) --> [rui].
nome(s-m,luis) --> [luis].
nome(s-f,rita) --> [rita].
nome(s-f,ana) --> [ana].
nome(s-f,maria) --> [maria].
nome(s-m,elefante) --> [elefante].
nome(p-m,caes) --> [caes].
nome(p-m,gatos) --> [gatos].
nome(s-m,cao) --> [cao].
nome(s-m,gato) --> [gato].
nome(s-m,futebol) --> [futebol].
nome(p-m,morangos) --> [morangos].
nome(p-m,amendoins) --> [amendoins].
nome(p-m,bolachas) --> [bolachas].
nome(p-m,humanos) --> [humanos].
nome(p-f,pessoas) --> [pessoas].

verbo(s,a) --> [joga],[jogar].
verbo(p,a) --> [jogam],[jogar].
verbo(s,a) --> [gosta],[gostar].
verbo(p,a) --> [gostam],[gostar].
verbo(s,a) --> [come],[comer].
verbo(p,a) --> [comem],[comer].
verbo(p,a) --> [sao],[ser].

/* ***************
 * base de dados *
 *************** */

humano(rapaz).
humano(rui).
humano(maria).
humano(rita).
humano(ana).
humano(luis).
humano(humano).
humano([]).
humano([H|T]) :- 
    humano(H), 
    humano(T).

jogar(rapaz, futebol).
jogar(rui, futebol).
jogar(pokemon, futebol).

gostar(luis, morango).
gostar(rita, morango).
gostar(ana, morango).
gostar(rui, maria).
gostar(cao, bolacha).
gostar(gato, bolacha).

comer(elefante, amendoim).

ser(rui, rapaz).
ser(X, humano) :- 
    humano(X).

/* EXERCICIO 8.1. */

frase --> 
    sn(N),
    sv(N,A,Obj,S).

sn(N) --> 
    determinante(N-G), 
    nome(N-G,S).
sn(N) --> 
    nome(N-_,S).

sv(N,gostar,Obj,S) -->
    verbo(N,gostar,S),
    {!}, % clausula bcg
    predicate(N1-G1),
    nome(N1-G1,Obj).
sv(N,A,Obj,S) --> 
    verbo(N,A,S), 
    sn(_,Obj).    

/* testar */
% |? - frase([o, rui, joga, futebol],[]).
% yes

% |? - frase(A,S,Ob, [o, rui, joga, futebol],[]).
% A = jorge
% S = rui
% Obj = futebol

concorda_frase(A,S,Obj):-
    P =.. [A,S,Ob],
    (
        P,
        !,
        write('concordo')
    );
    write('discordo').

determinante(s-m) -->
    [o].

nome(s-m,rui) -->
    [rui].

valor(s,jorge,S) -->
    [joga],
    {humano(S)}. % clausula bcg para ter 3 argumentos, 1 explicito e 2 implicitos