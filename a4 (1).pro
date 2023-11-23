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


/*
 * Q2. Translate the spiral function from Assignment 1:
 *
  `spiral': given two integers `dir' and `span',
  returns 1 if `dir' is less than or equal to 0,
  and otherwise returns (span - dir) * spiral (span - dir) (span - 4).

  Here is a Haskell solution:
  
    spiral :: Integer -> Integer -> Integer
    spiral dir span = if dir <= 0 then 1
                      else (span - dir) * spiral (span - dir) (span - 4)

  Write a Prolog predicate

    spiral

  such that  spiral(Dir, Span, R) is true  iff  R = (spiral Dir Span)
                                                (in Haskell)

  Hint: It may be useful to rewrite 'spiral' using 'let' and/or 'where'.

  We have written one clause, corresponding to the "then" part of
  the Haskell function, for you.
*/

spiral(Dir, _, 1) :- Dir =< 0.



/*
  To test: ?- spiral(0, 32, 1).
           true ;                % type ;
           false.
           ?- spiral(-32, 5, 1).
           true ;                % type ;
           false.
           ?- spiral(13, 3, R).
           R = -10 .             % type .
           ?- spiral(7, 6000, R).
           R = -107676231;       % type ;
           false.

  Hint: The last query (and similar queries) should give
        only one solution.
*/


/*
  Q3: Trees
*/

atlevel(0, node(Key, _, _), Key).
