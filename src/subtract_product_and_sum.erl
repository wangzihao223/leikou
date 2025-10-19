%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 8月 2023 10:29
%%%-------------------------------------------------------------------
-module(subtract_product_and_sum).

-author("16009").

% 整数的各位积和之差
%% API
-export([subtract_product_and_sum/1]).

subtract_product_and_sum(N) ->
    L = digits(N, []),
    product(L, 1) - sum(L).

digits(N, L) when N > 0 ->
    digits(N div 10, [N rem 10 | L]);
digits(_, L) ->
    L.

sum(L) ->
    lists:sum(L).

product([N | Next], Res) ->
    product(Next, Res * N);
product([], Res) ->
    Res.
