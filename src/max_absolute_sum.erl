%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. 8月 2023 9:25
%%%-------------------------------------------------------------------
-module(max_absolute_sum).
-author("16009").

%% API
-export([max_absolute_sum/1]).
-spec max_absolute_sum(Nums :: [integer()]) -> integer().
max_absolute_sum(Nums) ->
  max(-1 * signed(Nums, 0, 0), unsigned(Nums, 0, 0)).


unsigned([N | Next], Sum, Max) when N >= 0 ->
  unsigned(Next, Sum + N, max(Sum + N, Max));
unsigned([N | Next], Sum, Max) ->
  if N + Sum > 0 -> unsigned(Next, Sum + N, max(Sum + N, Max));
    true -> unsigned(Next, 0, Max)
  end;
unsigned([], Sum, Max) -> max(Sum, Max).

signed([N | Next], Sum, Max) when N =< 0 ->
  signed(Next, Sum + N, min(Sum + N, Max));
signed([N | Next], Sum, Max) ->
  if N + Sum < 0 -> signed(Next, Sum + N, min(Sum + N, Max));
    true -> signed(Next, 0, Max)
  end;
signed([], Sum, Max) -> min(Sum, Max).


