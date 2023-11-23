% CISC 360 a4, Fall 2023
%
% See a4.pdf for instructions

/*
 * Replace  this is a syntax error  with your student ID number:
 */
student_id( 20244382 ).
second_student_id( 20298549 ).
% If in a group, uncomment the second_student_id line
%   and put the second student's ID between the ( )
check_that_you_added_your_student_id_above().


/*
 * Q1: Prime numbers
 */

/*
  factors_loop(N, Start, Factors):
      Given integers N > 1 and Start > 1,
          return in Factors a list of all F such that
                 (F >= Start)
             and F < N
             and (N mod F) = 0.

  This predicate is already used within `factors`.
  You probably don't need to call `factors_loop` yourself.
*/
factors_loop( N, Start, []) :- N > 1, Start > 1, Start >= N.

factors_loop( N, Start, [Start | Rest]) :-
      N > 1, Start > 1, Start < N,
      (N mod Start) =:= 0,
      Next is Start + 1,
      factors_loop( N, Next, Rest).

factors_loop( N, Start, Rest) :-
      N > 1, Start > 1, Start < N,
      (N mod Start) =\= 0,
      Next is Start + 1,
      factors_loop( N, Next, Rest).

factors(N, Factors) :- N > 1, factors_loop( N, 2, Factors).

len([], LenResult):-
    LenResult is 0.

len([X|Y], LenResult):-
    len(Y, L),
    LenResult is L + 1.

/*
  Q1a.
 */
is_prime(N, prime) :-
    factors(N, []).
    
is_prime(N, composite(PrimeFactors)) :-
    factors(N,Factors),
    Factors \= []
    find_primes(Factors, Primes),
    PrimeFactors = Primes.
    

 /* Q1.B */   
find_primes([], []).

find_primes([X | Xs], [X | Ys]) :-
    X>1,
    factors(X,Factors),
    len(Factors, L),
    L == 0,
    !,
    find_primes(Xs,Ys).

find_primes([X | Xs], Ys) :-
    find_primes(Xs, Ys).





/* Q1.c */

primes_list(M, N, Primes) :-
  upto(M,N,Range),
  find_primes(Range, PrimeFactors),
  Primes = PrimeFactors.

upto(X, X, [X]).
upto(X, Y, [X | Zs]) :-
    X < Y,
    Xplus1 is X + 1,
    upto(Xplus1, Y, Zs).


/* Q2 */
spiral(Dir, _, 1) :- Dir =< 0.


spiral(Dir, Span, R) :-
    Dir > 0,
    NextDir is Span-Dir,
    NextSpan is Span - 4,
    spiral(NextDir, NextSpan, R2),
    R is (Span - Dir) * R2.

/*
  Q3: Trees
*/

<<<<<<< HEAD
 */
atlevel(0, node(Key, _, _), Key).
atlevel(0, leaf(Key), Key).
atlevel(Level, node(_, Left, Right), Key) :-
    Level > 0,
    NextLevel is Level - 1,
    (   atlevel(NextLevel, Left, Key);
        atlevel(NextLevel, Right, Key)
    ).
=======
atlevel(0, node(Key, _, _), Key).
atlevel(0, leaf(Key), Key).
>>>>>>> d919ad9f09396fff3a2623f1ce58e38b372fcd78
