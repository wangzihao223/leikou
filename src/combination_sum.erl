-module(combination_sum).
% 组合总和
-export([combination_sum/2]).

combination_sum(Candiates, Target) -> 
    Candiates1 = lists:reverse(lists:sort(Candiates)),
    Candiates2 = [H || H <-Candiates1, H =< Target],
    % Set = select(Candiates2, Target, Target, [], sets:new([{version, 2}])),
    {_,_, Res} = select(Candiates2, Target, Target, [], sets:new([{version, 2}])),
    sets:to_list(Res).

select([N | Next], Sum, Target, R, Res) when Sum > N ->
    io:format("R2 is ~p  N is ~p Sum is ~p ~n", [R, [N|R], Sum -N]),
    {Sum1, _R1, Res1}= select([N | Next], Sum - N , Target, [N | R], Res),
    select(Next, Sum -Sum1 , Target,  R, Res1);
select([N | Next], Sum, Target, R, Res) when Sum == N ->
    io:format("R1 is ~p  N is ~p Sum ~p ~n", [R, [N|R], Sum]),
    select(Next, Target, Target,  R, sets:add_element([N | R], Res));
    % select(Next, Sum, Target, R, Res1);
select([_ | Next], Sum, Target,  N, Res) ->
    % io:format("R is ~p  N is ~p Sum ~p ~n", [R, N, Sum]),
    select(Next, Sum,  Target, N, Res);
select([], Sum, _Target, R, Res) -> {Sum, R, Res}.
