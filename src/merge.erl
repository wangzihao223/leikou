-module(merge).

-export([merge/1]).

% 合并区间
merge(Intervals) ->
    [Head | Next] = lists:sort(Intervals),
    merge1(Next, [Head]).

merge1([[L1, R1] | Next], [[L2, R2] | Next1]) when R2 >= L1 ->
    merge1(Next, [[L2, max(R2, R1)] | Next1]);
merge1([[L1, R1] | Next], [[L2, R2] | Next1]) ->
    merge1(Next, [[L1, R1], [L2, R2] | Next1]);
merge1([], Res) ->
    lists:reverse(Res).
