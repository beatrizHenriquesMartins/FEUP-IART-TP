:-use_module(library(lists)).

% alinea a
estado_inicial((10, max)).

estado_final((0, max), 1).
estado_final((0, min), 0).

sucessor((N, max), max, (N1, min)):-
        N > 0,
        N1 is N - 1.

sucessor((N, max), max, (N1, min)):-
        N > 1,
        N1 is N - 2.

sucessor((N, max), max, (N1, min)):-
        N > 2,
        N1 is N - 3.

sucessor((N, min), min, (N1, max)):-
        N > 0,
        N1 is N - 1.

sucessor((N, min), min, (N1, max)):-
        N > 1,
        N1 is N - 2.

sucessor((N, min), min, (N1, max)):-
        N > 2,
        N1 is N - 3.

minimax(E, _, Valor, _):-
        estado_final(E, Valor).
% procura o maior
minimax(E, max, Valor, Jogador):-
        findall(E2, sucessor(E, max, E2), LS),
        max_value(LS, Valor, Jogador).
% procura o menor
minimax(E, min, Valor, Jogador):-
        findall(E2, sucessor(E, min, E2), LS),
        min_value(LS, Valor, Jogador).

max_value([E], Valor, E):-
        minimax(E, min, Valor, _).
max_value([E1|Es], MV, ME):-
        minimax(E1, min, V1, _),
        max_value(Es, V2, E2),
        (
            % 1º estado
            V1 > V2,
            !,
            MV = V1, % como não é uma expressão então não é necessário usar o is
            ME = E1;
            % 2º estado
            MV = V2,
            ME = E2
        ).

min_value([E], Valor, E):-
        minimax(E, max, Valor, _).
min_value([E1|Es], MV, ME):-
        minimax(E1, max, V1, _),
        min_value(Es, V2, E2),
        (
            % 1º estado
            V1 < V2,
            !,
            MV = V1, % como não é uma expressão então não é necessário usar o is
            ME = E1;
            % 2º estado
            MV = V2,
            ME = E2
        ).

% alinea b
minimax(E, _, _,Valor, _):-
        estado_final(E, Valor).

minimax(E, _, 0, Valor, _):-
        avalia(E, Valor).

% procura o maior
minimax(E, max, P, Valor, Jogador):-
        findall(E2, sucessor(E, max, E2), LS),
        P1 is P - 1,
        max_value(LS, P1, Valor, Jogador).

% procura o menor
minimax(E, min, P, Valor, Jogador):-
        findall(E2, sucessor(E, min, E2), LS),
        P1 is P - 1,
        min_value(LS, P1, Valor, Jogador).

max_value([E], P, Valor, E):-
        minimax(E, min, P, Valor, _).
max_value([E1|Es], P, MV, ME):-
        minimax(E1, min, P, V1, _),
        max_value(Es, P, V2, E2),
        (
            % 1º estado
            V1 > V2,
            !,
            MV = V1, % como não é uma expressão então não é necessário usar o is
            ME = E1;
            % 2º estado
            MV = V2,
            ME = E2
        ).

min_value([E], P, Valor, E):-
        minimax(E, max, P, Valor, _).
min_value([E1|Es], P, MV, ME):-
        minimax(E1, max, P, V1, _),
        min_value(Es, P, V2, E2),
        (
            % 1º estado
            V1 < V2,
            !,
            MV = V1, % como não é uma expressão então não é necessário usar o is
            ME = E1;
            % 2º estado
            MV = V2,
            ME = E2
        ).

avalia((N, max), V):-
        1 is N mod 4,
        !,
        V = 0;
        V = 1.


/*
Como testar
minimax((10, max), max, V, J).
*/