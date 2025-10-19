-module(max_product).

-export([max_product/1]).

% 乘积最大子数组

max_product([N]) ->
    N;
max_product([N | Num]) ->
    find_max(Num, N, N, N).

find_max([N | Next], Max, Min, R) ->
    Max1 = lists:max([Max * N, Min * N, N]),
    Min1 = lists:min([Max * N, Min * N, N]),
    find_max(Next, Max1, Min1, max(Max1, R));
find_max([], _, _, R) ->
    R.
