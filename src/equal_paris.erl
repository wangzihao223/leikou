-module(equal_paris).
-export([test/0]).

main(Grid) ->
    Map = loop(Grid, #{}),
    % io:format("Map ~p ~n", [Map]),
    Grid1 = create_empty_grid(erlang:length(Grid), []),
    % io:format("grid ~p ~n", [Grid1]),
    Grid2 = loop_row(Grid, Grid1, []),
    Grid3 = reverse_every_one(Grid2, erlang:length(Grid), []),
    % io:format("grid2 ~p ~n", [Grid3]),
    counter(Grid3, Map, 0).
    


loop([], Map) -> Map;
loop([Row|NextRow], Map) ->
    Value = maps:get(Row, Map, 0),
    NMap = maps:put(Row, Value+1, Map),
    loop(NextRow, NMap).



create_empty_grid(0, Grid) -> Grid;
create_empty_grid(L, Grid) ->
    create_empty_grid(L-1, [[]|Grid]).
loop_row([], Out, _) -> Out;
loop_row([Raw|NextRow], Grid1, Out)->
    NewOut = put_num_to_grid(Raw, Grid1, Out),
    loop_row(NextRow, NewOut, []).

put_num_to_grid([], _, Out) -> lists:reverse(Out);
put_num_to_grid([N|Next], [L|NextL], Out) ->
    Out1 = [[N|L]|Out],
    % io:format("out1 ~p ~n ", [Out1]),
    put_num_to_grid(Next, NextL, Out1).

reverse_every_one([], 0, R) -> R;
reverse_every_one([L|Next], Size, R) ->
    L1 = lists:reverse(L),
    reverse_every_one(Next, Size-1, [L1|R]).

counter([], _Map, N) -> N;
counter([C|NextC], Map, N) ->
    % io:format("C ~p ~n", [C]),
    Num = maps:get(C, Map, 0),
    N1 = Num + N,
    counter(NextC, Map, N1).

test() ->
    Grid =[[3,1,2,2],[1,4,4,5],[2,4,2,2],[2,4,2,2]],

    R = main(Grid),
    io:format("R ~p ~n", [R]).