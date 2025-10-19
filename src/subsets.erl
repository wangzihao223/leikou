-module(subsets).

% 子集
% subsets(Nums) ->
-export([subsets/1]).

subsets(Nums) ->
    select(Nums, Nums, [], []).

select([N | Next], S, Row, R) ->
    Next1 = S -- [N],
    R1 = select(Next1, Next1, [N | Row], R),
    select(Next, Next1, Row, R1);
select([], _Remain, Row, R) ->
    io:format("Row ~p ~n", [Row]),
    [Row | R].
