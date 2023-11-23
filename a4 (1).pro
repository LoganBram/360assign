% CISC 360 a4, Fall 2023
%
% See a4.pdf for instructions

/*
 * Replace  this is a syntax error  with your student ID number:
 */
student_id( this is a syntax error ).
% second_student_id( 20298549 ).
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



upto(X, X, [X]).
upto(X, Y, [X | Zs]) :-
    X < Y,
    Xplus1 is X + 1,
    upto(Xplus1, Y, Zs).

/*
  primes_list(M, N, Primes)
    Primes = all prime numbers between M and N, in increasing order.
    Example:
      ?- primes_list(60, 80, Primes).
      Primes = [61, 67, 71, 73, 79] .

 (Return only one solution.)

 Q1c. Replace the word "change_this" in the rule below.
      HINT: Use upto and find_primes.
*/

primes_list(M, N, Primes) :-
   change_this.



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

  Consider the tree     (We are *not* representing
                          trees with Empty "leaves":
             4                         4
            / \                      /   \
           2   5                   2       5
          / \                    /  \     / \
         1   3                 1     3   E   E
                              / \   / \
                          Empty  E E   E            )
                 
  We will express the above tree in Prolog as

    node( 4, node( 2, leaf(1), leaf(3)), leaf(5))
  
  This kind of tree is similar to this Haskell type:
  
    data A4Tree = Node Integer A4Tree A4Tree
                | Leaf Integer

  In this question, a  key at level L  is a key that appears at level L of the tree,
  counting the root as level 0, the root's children as level 1, and so on.

  For example, in the tree

                         4          Level 0
                        / \      
                       2   5        Level 1
                      / \        
                     1   3          Level 2

  the key 4 is at level 0, the keys 2 and 5 are at level 1, and the keys 1 and 3 are at level 2.

  In this question, define a Prolog predicate

    atlevel(L, T, K)

  that is true iff key K appears at level L of tree T.

  For example:
  
    ?- atlevel( 0, node(2, leaf(1), leaf(3)), 2).
    true

    ?- atlevel( 1, node( 4, node( 2, leaf(1), leaf(3)), leaf(5)), 5).
    true

  Your predicate should be written so that when the first argument is a specific integer
  (like 0, 1, etc.), the second argument is a specific tree (containing no variables),
  and the third argument is a variable,
  typing ; returns *all* keys at that level in the tree.
  For example:

    ?- atlevel( 1, node( 4, node( 2, leaf(1), leaf(3)), leaf(5)), Key).
    Key = 2 ;
    Key = 5 ;
    false

    (Also acceptable:
    ?- atlevel( 1, node( 4, node( 2, leaf(1), leaf(3)), leaf(5)), Key).
    Key = 2 ;
    Key = 5. )

  If the level "goes below" the tree, atlevel should be false.
  For example, the tree  leaf(1000)  has only level 0:

    ?- atlevel( 1, leaf(1000), K).
    false

  Define clauses for 'atlevel' below.
*/


