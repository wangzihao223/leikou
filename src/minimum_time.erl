%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 7月 2023 9:31
%%%-------------------------------------------------------------------
-module(minimum_time).
-author("wangzihao").

%% API
-export([minimum_time/3]).
-spec minimum_time(N :: integer(), Relations :: [[integer()]], Time :: [integer()]) -> integer().
minimum_time(N, Relations, Time) ->
  TimeMap = time_map(Time, 1, #{}),
  {OutMap, InMap} = make_graph(Relations, #{}, #{}),
  Zero = in_degree_zero(InMap, 1, N, []),
  Q = queue:from_list(Zero),

  MinMap = loop(#{}, TimeMap, OutMap, InMap, Q, sets:from_list(Zero), N, sets:from_list(range(1, N, []))),
  find_max(MinMap, 2, N, map_get(1, MinMap)).

range(L, R, Res) when R >= L->
  range(L+1, R, [L | Res]);
range(_L, _R, Res) -> Res.

f(_, [], Res)-> Res;
f(InMap, [C | Next],Res) ->
  case maps:is_key(C, InMap) of
    false -> f(InMap, Next, [C | Res]);
    true -> f(InMap, Next, Res)
  end.



loop(MinTimeMap, TimeMap, OutMap, InMap, Q, F, N, Sets) ->

  case queue:is_empty(Q) of
    true ->
      MinTimeMap;
    false ->
      {{value, Item}, Q2} = queue:out(Q),
      {MinTime1, InMap1} = learn_in_degree_zero(Item, MinTimeMap, TimeMap, OutMap, InMap),
      S1 = sets:subtract(Sets, F),
      Z = f(InMap1, sets:to_list(S1), []),
      Z1_S = sets:subtract(sets:from_list(Z), F),
      Z1 = sets:to_list(Z1_S),
      Q3 = loop_in_queue(Z1, Q2),
      loop(MinTime1, TimeMap, OutMap, InMap1, Q3, sets:union(Z1_S, F), N, Sets)
  end.



loop_in_queue([], Q) -> Q;
loop_in_queue([L | NextL], Q)->
  loop_in_queue(NextL, queue:in(L, Q)).

% graph
make_graph([[P, N] | NextR], OutMap, InMap) ->
  V1 = maps:get(P, OutMap, sets:new()),
  V2 = maps:get(N, InMap, sets:new()),
  make_graph(NextR, OutMap#{P => sets:add_element(N, V1)}, InMap#{N => sets:add_element(P, V2)});
make_graph([], OutMap, InMap) -> {OutMap, InMap}.

in_degree_zero(_, C, N, Res) when C > N -> Res;
in_degree_zero(InMap, C, N, Res) ->
  case maps:get(C, InMap, null) of
    null -> in_degree_zero(InMap, C + 1, N, [C | Res]);
    _ -> in_degree_zero(InMap, C + 1, N, Res)
  end.

time_map([T | NextT], C, Map) ->
  time_map(NextT, C + 1, Map#{C=>T});
time_map([], _, Map) -> Map.

learn_in_degree_zero(C, MinTimeMap, TimeMap, OutMap, InMap) ->
  NewMinMap = MinTimeMap#{C => map_get(C, TimeMap) + maps:get(C, MinTimeMap, 0)},
  {InMap1, MinTimeMap1} = del_node_from_out_degree(C, OutMap, InMap, NewMinMap),
  {MinTimeMap1, InMap1}.

del_node_from_out_degree(Node, OutMap, InMap, MinTimeMap) ->
  case maps:get(Node, OutMap, null) of
    null -> {InMap, MinTimeMap};
    V ->
      {InMap1, MinTimeMap1} = loop_del(sets:to_list(V), InMap, Node, MinTimeMap),
      {InMap1, MinTimeMap1}
  end.

loop_del([C | NextC], InMap, Node, MinTimeMap) ->
  case maps:get(C, InMap, null) of
    null -> {InMap, MinTimeMap};
    V ->
        case maps:get(C, MinTimeMap, null) of
          null -> MTM = MinTimeMap#{C => map_get(Node, MinTimeMap)};
          V1 -> MTM = MinTimeMap#{C := max(V1, map_get(Node, MinTimeMap))}
        end,
      S = sets:del_element(Node, V),
      case sets:is_empty(S) of
        true ->
          InMap1 = maps:remove(C, InMap);
        _ ->
          InMap1 = InMap#{C := S}
      end,
      loop_del(NextC, InMap1, Node, MTM)
  end;
loop_del([], InMap, _, MinTimeMap) -> {InMap, MinTimeMap}.

find_max(MinMap, C, N, Max) when C =< N  ->
  find_max(MinMap, C + 1, N, max(Max, map_get(C, MinMap)));
find_max(_, _, _, Max) -> Max.