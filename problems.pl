member([X|_], X).
member([_|T], X):- member(T, X).

%p01
last([X], X).
last([_|T], X) :-
  last(T, X).

%p02
%last_but_one(List, Element)
last_but_one([X,_], X).
last_but_one([_|T], X) :-
  last_but_one(T, X).

%p03
%k_th_element(List, Number, Result).
kth_element([H|_], 0, H).
kth_element([_|T], N, R) :-
  N2 is N - 1,
  kth_element(T, N2, R).

%p04
%count(List, Count)
count([], 0).
count([_|T], Count) :-
  count(T, Count2),
  Count is Count2 + 1.

%p05
%reverse(Normal, Reversed).
my_rev(List, Result) :- reverse(List, Result, []).
reverse([], R, R).
reverse([H|T], R, Temp) :- reverse(T, R, [H|Temp]).

%p06
palindrome(List):- reverse(List, List).

%p07
%flatten(List, Result).
% flattened list is a list which elements aren't lists
flatten(L,R1) :-
  X = [],
  flatten(L, X, R),
  reverse(R, R1).
flatten([], X, X).
flatten([[IH|IL]|_], X, R) :-
  flatten(IL, [IH|X], R).
flatten([H|T], X, R) :-
  H == [],
  flatten(T, X, R).
flatten([H|T], X, R) :-
  flatten(T, [H|X], R).

%p08
%uniq(List, Result).
uniq_u(L,X1) :-
  uniq(L,[],R),
  my_rev(R, X1).
uniq([],X, X).
uniq([E], X, R) :-
  uniq([], [E|X], R).
uniq([H1, H2|L], X, R) :-
  H1 == H2,
  uniq([H2|L], X, R).
uniq([H1, H2|L], X, R) :-
  uniq([H2|L], [H1|X], R).

%p09
% pack(List, Result).
% packs repeated elements in their own sublists.

pack(List, Result) :-
  X = [],
  pack(List, X, ReversedResult),
  my_rev(ReversedResult, Result).
pack([], R, R).
pack([H1,H2|T], [[IXH|IXT]|XT], R) :-
  H1 == IXH,
  pack([H2|T], [[H1, IXH|IXT]|XT], R).
pack([E], [[IXH|IXT]|XT], R) :-
  E == IXH,
  pack([], [[E, IXH|IXT]|XT], R).
pack([H1, H2|T], X, R) :-
  H1 == H2,
  pack([H2|T], [[H1]|X], R).
pack([H|T], X, R):-
  pack(T, [H|X], R).

%p10 / 11
% run length encoding data compression
% encode [a,a,a,a,a,b,b,b,c] to [[a, 5], [b, 3], [c, 1]]

%encode(List, Result)
encode(L, A):-
  A = [],
  X = [],
  pack(L, X, ReversedResult),
  countBuild(ReversedResult, A).

countBuild([], []).
countBuild([[IH|IT]|T], A):-
  count([IH|IT], N),
  countBuild(T, A1),
  A = [[N, IH] | A1].
countBuild([El|T], A) :-
  countBuild(T, A1),
  A = [[1, El] | A1].


