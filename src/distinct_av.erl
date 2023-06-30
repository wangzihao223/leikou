-module(distinct_av).

-export([main/1]).

% 不同的平均值数目
main(Nums) ->
    S = erlang:length(Nums),
    L1 = lists:sort(Nums),
    {L2, L3} = split(S div 2, L1, []),
    loop(L2, L3, sets:new()).

split(0, L1, L2) ->
    {L2, L1};
split(S, [H | Next], L2) ->
    io:format("S ~p ~n", [S]),
    split(S - 1, Next, [H | L2]).

loop([], [], Set) ->
    sets:size(Set);
loop([N1 | Next1], [N2 | Next2], Set) ->
    M = (N1 + N2) / 2,
    Set1 = sets:add_element(M, Set),
    loop(Next1, Next2, Set1).
