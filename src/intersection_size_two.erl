-module(intersection_size_two).

-export([intersection_size_two/1]).

%757
%
intersection_size_two(Intervals) ->
    loop([-1, -1], lists:sort(fun compare/2, Intervals), 0).

compare([_S1, E1], [_S2, E2]) when E1 < E2 ->
    true;
compare([S1, E], [S2, E]) when S1 > S2 ->
    true;
compare(_, _) ->
    false.

loop([S, E], [[A, _B] | Next], R) when S >= A ->
    loop([S, E], Next, R);
loop([S, E], [[A, B] | Next], R) when A > S, A =< E ->
    loop([E, B], Next, R + 1);
loop([_S, E], [[A, B] | Next], R) when A > E ->
    loop([B - 1, B], Next, R + 2);
loop(_, [], R) ->
    R.
