:- consult('9.pl').

coprimos(X,Y) :-
    desdeReversible(0,X),
    between(0,X,N),
    Y is N + X,
    1 is gcd(X,Y).
    

