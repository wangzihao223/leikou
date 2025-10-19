%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 8月 2023 10:49
%%%-------------------------------------------------------------------
-module(search_insert).

-author("16009").

% 搜索插入位置

%% API
-export([search_insert/2]).

search_insert(Nums, Target) ->
    Array = array:from_list(Nums),
    split(Array, 0, length(Nums) - 1, Target).

split(Array, L, R, Target) when L == R ->
    N = array:get(L, Array),
    io:format("N is ~p Array ~p ~n", [N, L]),
    if N >= Target ->
           L;
       true ->
           L + 1
    end;
split(Array, L, R, Target) ->
    P = (R + L) div 2,
    io:format("Len is ~p ~n", [P]),
    N = array:get(P, Array),
    if N > Target ->
           split(Array, L, max(P - 1, L), Target);
       N == Target ->
           P;
       true ->
           split(Array, min(P + 1, R), R, Target)
    end.
