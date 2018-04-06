:-use_module(library(lists)).
:-use_module(library(between)).

slots(4). 
disciplinas(12). 
disciplina(1,[1,2,3,4,5]). % Os alunos 1,2,3,4,5 estão inscritos à disciplina 1 
disciplina(2,[6,7,8,9]). 
disciplina(3,[10,11,12]). 
disciplina(4,[1,2,3,4]). 
disciplina(5,[5,6,7,8]). 
disciplina(6,[9,10,11,12]). 
disciplina(7,[1,2,3,5]). 
disciplina(8,[6,7,8]). 
disciplina(9,[4,9,10,11,12]). 
disciplina(10,[1,2,4,5]). 
disciplina(11,[3,6,7,8]). 
disciplina(12,[9,10,11,12]). 

%Algumas solucoes iniciais para experimentar... 
sol_inicial([1,1,1,1,1,1,1,1,1,1,1,1]). % Mudar isto para gerar a solucao! Solucao aleatoria? 
%sol_inicial([1,1,1,2,2,2,3,3,3,4,4,1]). % Quase a solucao 
%sol_inicial([1,1,4,2,2,2,3,3,3,4,4,1]). % Minimo Local? 
%sol_inicial([1,2,3,4,1,2,3,4,1,2,3,4]). % E agora? Outro minimo local? Experimentar outras

incompat(D1, D2, NA):-
        disciplina(D1, LA1),
        disciplina(D2, LA2),
        findall(A, (member(A,LA1),member(A, LA2))),
        length(LA12, NA).

/*
?- incompat(1,2,N).
N=0

?- incompat(D1,D2,N).
D1=1,
D2=1,
N=5
*/

/* função de avaliação */
f_avaliacao():-
        findall(N,
                (
                        nth1(D1, L, Slot),
                        nth1(D2, L, Slot),
                        D1 < D2,
                        incompat(D1, D2, N)
                ),
        L_Incompat),
        sumlist(L_Incompat, V).

/*
?- f_avaliacao([1,1,1,1],V).
V = 4
*/

best(X, Y):-
    X < Y.

vizinho(L. L2):-
    slot(NSlots),
    nth1(D, L, Slot),
    between(1, NSlots, NovoSlot),
    Slot \= NovoSlot,
    /* Novo horario por backtracking */
    D1 is D-1,
    length(1, NSlots, NovoSlot),
    append(Prefix, [Slot|Suffix], L),
    append(Prefix, [NovoSlot|Suffix], L2).

/* subir a coluna */
hillclimbing(S, LocalOpt):-
    f_avaliacao(S, V1),
    vizinho(S, S2),
    f_avaliacao(S2, V2),
    best(V2, V1),
    !, /*no algortimo subir a colina, não pode ter backtracing*/
    write(S2: V2), nl,
    hillclimbing(S2, LocalOpt).
hillclimbing(S, S). /* melhor solução ser a actual */

/*
sol_inicial(S),hillclimbing(S, Sol)
*/