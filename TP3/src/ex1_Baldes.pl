:-use_module(library(lists)).

estado_inicial(b(0,0)).

estado_final(b(2,0)).

%transições entre estados
sucessor(b(X, Y), b(4, Y), C):- 
    X < 4, 
    C is 4 - X.

sucessor(b(X, Y), b(X, 3), C):- 
    Y < 3, 
    C is 3 - Y.

sucessor(b(X, Y), b(0, Y), C):- 
    X > 0, 
    C is X.

sucessor(b(X, Y), b(X, 0), C):- 
    Y > 0,
    C is Y.

sucessor(b(X, Y), b(4, Y1), C):-
    X + Y >= 4,
    X < 4,
    Y1 is Y - (4 - X),
    C is 4 - X.

sucessor(b(X, Y), b(X1, 3), C):- 
    X + Y >= 3, 
    Y < 3,
    X1 is X - (3 - Y),
    C is 3 - Y.

sucessor(b(X, Y), b(X1, 0), C):- 
    X + Y < 4,
    Y > 0,
    X1 is X + Y,
    C is Y.

sucessor(b(X, Y), b(0, Y1), C):-
    X + Y < 3,
    X > 0,
    Y1 is X + Y,
    C is X.

h(b(X, Y), H) :-
    estado_final(b(Xf, Yf)),
    H is max(abs(X - Xf), abs(Y - Yf)).

a_star([(F, _, [E|Path])|_], (F, [E|Path])):- 
    estado_final(E).

a_star([(_, G, [E|Path])|R], S) :- 
    findall((F2, G2, [E2, E|Path]), 
            (
                sucessor(E, E2, C),
                \+ member(E2, [E|Path]),
                h(E2, H2), 
                G2 is G + C,
                F2 is G2 + H2
            ),
            LS
    ),
    append(R, LS, L2),
    sort(L2, L2Ord),
    a_star(L2Ord, S).

solve_a_star(S):-
    estado_inicial(Ei),
    h(Ei, Hi),
    a_star([(Hi, 0, [Ei])], (Value, SR)),
    reverse(S, SR),
    write('Peso: '), write(Value),
    write('; Solucao: '), write(S), nl,
    fail.