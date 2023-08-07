%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 8月 2023 13:18
%%%-------------------------------------------------------------------
-module(merge_sort).
-author("16009").

% 归并排序

%% API
-export([sort/1]).

sort(L) ->
  SL = split(L, []),
  pair(SL, []).

split([L1, L2 | NextL], Res) when L1 > L2 ->
  split(NextL, [[L2, L1] | Res]);
split([L1, L2 | NextL], Res) ->
  split(NextL, [[L1, L2] | Res]);
split([L], Res) -> [[L] | Res];
split([], Res) -> Res.

pair([L1, L2 | NextL], Res) ->
  L = merge(L1, L2, []),
  pair(NextL, [L | Res]);
pair([L], Res) -> pair([L | Res], []);
pair([], [R]) -> R;
pair([], Res) -> pair(Res, []).

merge(L, [], Res) ->
  lists:reverse(merge1(L, Res));
merge([], R, Res) ->
  lists:reverse(merge1(R, Res));
merge([L | NextL], [R | NextR], Res) when L =< R ->
  merge(NextL, [R | NextR], [L | Res]);
merge([L | NextL], [R | NextR], Res) when L > R->
  merge([L | NextL], NextR, [R | Res]).

merge1([N | Next], R) ->
  merge1(Next, [N | R]);
merge1([], R) -> R.


