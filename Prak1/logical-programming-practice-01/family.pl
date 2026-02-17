male(petro).
male(ivan).
male(oleksii).
male(andrii).
male(danylo).

female(olena).
female(maria).
female(nataliia).
female(marta).

married(petro, olena).
married(ivan, nataliia).
married(oleksii, maria).

parent(petro, ivan).
parent(petro, maria).
parent(olena,ivan). 
parent(olena, maria).

parent(ivan, andrii).
parent(ivan, marta).
parent(nataliia, andrii).
parent(nataliia, marta).

parent(maria, danylo).
parent(oleksii, danylo).

grandparent(GP, GC) :- 
    parent(GP, P), 
    parent(P, GC).

sibling(X, Y) :- 
    parent(P, X), 
    parent(P, Y), 
    X \= Y.