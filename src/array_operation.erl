-module(array_operation).

-export([main/1]).
-export([test/1]).
main(Nums) ->
    {L, N} = loop(Nums, [], 0),
    full_zero(N, L).

loop([0, N | Next], Buff, ZeroN)->
    loop([N|Next], Buff, ZeroN+1);
loop([N, N | Next], Buff, _N) ->
    Buff1 = [N*2|Buff],
    loop([0|Next], Buff1, _N);
loop([N, N1 | Next], Buff, _N) ->
    loop([N1|Next], [N|Buff], _N);
loop([0], Buff, ZeroN) -> {Buff, ZeroN+1};
loop([N], Buff, ZeroN) -> {[N|Buff], ZeroN}.

full_zero(0, L) -> lists:reverse(L);
full_zero(N, L) ->
    full_zero(N-1, [0|L]).

test(L) ->

    R = main(L),
    io:format("R ~p ~n", [R]).