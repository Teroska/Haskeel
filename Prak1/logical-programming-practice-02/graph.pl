edge(kyiv, lviv).
edge(lviv, uzhhorod).
edge(uzhhorod, odessa).
edge(odessa, lviv).
edge(lviv, ternopil).
edge(ternopil, chernivtsi).


path(A, B) :- 
    edge(A, B).

path(A, B) :- 
    edge(A, X), 
    path(X, B).

path_length(A, B, 1) :-
    edge(A, B).

path_length(A, B, L) :- 
    edge(A, X), 
    path_length(X, B, L1), 
    L is L1 + 1.