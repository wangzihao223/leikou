%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. 7月 2023 16:09
%%%-------------------------------------------------------------------
-module(min_interval).
-author("wangzihao").

%% API
-export([min_interval/2]).
-spec min_interval(Intervals :: [[integer()]], Queries :: [integer()]) -> [integer()].

min_interval([[L, R] | NextIntervals], Queries) ->
  M = init_map(L, R, R - L + 1, #{}),
  io:format("M is ~p ~n", [M]),
  Map = make_map(M, NextIntervals, L, R),
  search(Map, Queries, []).

search(_, [], Res) -> lists:reverse(Res);
search(Map, [Q | NextQ], Res) ->
   search(Map, NextQ, [maps:get(Q, Map, -1) | Res]).


init_map(L, R, Length, Map) when R >= L ->
  init_map(L+1, R, Length, Map#{L => Length});
init_map(_, _, _, Map) -> Map.

make_map(Map, [], _, _) -> Map;
make_map(Map, [[L, R] | NextIntervals], Min, Max) ->
  NewMap = record_to_map(Map, L, R, Min, Max, R - L + 1, L),
  make_map(NewMap, NextIntervals, min(L, Min), max(Max, R)).

record_to_map(Map, _, R, _, _, _, I) when R < I -> Map;
record_to_map(Map, L, R, Min, Max, Length, Index) when L > Max ->
  record_to_map(Map#{Index => Length}, L, R, Min, Max, Length, Index + 1);
record_to_map(Map, L, R, Min, Max, Length, Index) when L > Min , R < Max ->
  NewMap = Map#{Index := min(maps:get(Index, Map, Length), Length)},
  record_to_map(NewMap, L, R, Min, Max, Length, Index + 1);
record_to_map(Map, L, R, Min, Max, Length, Index) ->
  if Index > Max ; Index < Min -> NewMap = Map#{Index => Length};
    true -> NewMap = Map#{Index := min(maps:get(Index, Map, Length), Length)}
  end,
  record_to_map(NewMap, L, R, Min, Max, Length, Index + 1).