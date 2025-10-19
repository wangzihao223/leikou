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

-spec minimum_time(N :: integer(), Relations :: [[integer()]], Time :: [integer()]) ->
                      integer().
minimum_time(N, Relations, Time) ->
    TimeMap = time_map(Time, 1, #{}),
    {OutMap, InMap} = make_graph(Relations, #{}, #{}),
    io:format("Inmap ~p ~n", [InMap]),
    Zero = in_degree_zero(InMap, 1, N, []),
    Q = queue:from_list(Zero),

    MinMap = loop(#{}, TimeMap, OutMap, InMap, Q),
    find_max(MinMap, 2, N, map_get(1, MinMap)).

loop(MinTimeMap, TimeMap, OutMap, InMap, Q) ->
    case queue:is_empty(Q) of
        true ->
            MinTimeMap;
        false ->
            {{value, Item}, Q2} = queue:out(Q),
            {MinTimeMap1, InMap1, Q1} =
                learn_in_degree_zero(Item, MinTimeMap, TimeMap, OutMap, InMap, Q2),
            loop(MinTimeMap1, TimeMap, OutMap, InMap1, Q1)
    end.

% graph
make_graph([[P, N] | NextR], OutMap, InMap) ->
    V1 = maps:get(P, OutMap, sets:new()),
    V2 = maps:get(N, InMap, sets:new()),
    make_graph(NextR,
               OutMap#{P => sets:add_element(N, V1)},
               InMap#{N => sets:add_element(P, V2)});
make_graph([], OutMap, InMap) ->
    {OutMap, InMap}.

in_degree_zero(_, C, N, Res) when C > N ->
    Res;
in_degree_zero(InMap, C, N, Res) ->
    case maps:get(C, InMap, null) of
        null ->
            in_degree_zero(InMap, C + 1, N, [C | Res]);
        _ ->
            in_degree_zero(InMap, C + 1, N, Res)
    end.

time_map([T | NextT], C, Map) ->
    time_map(NextT, C + 1, Map#{C => T});
time_map([], _, Map) ->
    Map.

learn_in_degree_zero(C, MinTimeMap, TimeMap, OutMap, InMap, Q) ->
    NewMinMap = MinTimeMap#{C => map_get(C, TimeMap) + maps:get(C, MinTimeMap, 0)},
    {InMap1, MinTimeMap1, Q1} = del_node_from_out_degree(C, OutMap, InMap, NewMinMap, Q),
    {MinTimeMap1, InMap1, Q1}.

del_node_from_out_degree(Node, OutMap, InMap, MinTimeMap, Q) ->
    case maps:get(Node, OutMap, null) of
        null ->
            {InMap, MinTimeMap, Q};
        V ->
            {InMap1, MinTimeMap1, Q1} = loop_del(sets:to_list(V), InMap, Node, MinTimeMap, Q),
            {InMap1, MinTimeMap1, Q1}
    end.

loop_del([C | NextC], InMap, Node, MinTimeMap, Q) ->
    case maps:get(C, InMap, null) of
        null ->
            {InMap, MinTimeMap};
        V ->
            case maps:get(C, MinTimeMap, null) of
                null ->
                    MTM = MinTimeMap#{C => map_get(Node, MinTimeMap)};
                V1 ->
                    MTM = MinTimeMap#{C := max(V1, map_get(Node, MinTimeMap))}
            end,
            S = sets:del_element(Node, V),
            case sets:is_empty(S) of
                true ->
                    Q2 = queue:in(C, Q),
                    InMap1 = maps:remove(C, InMap),
                    loop_del(NextC, InMap1, Node, MTM, Q2);
                _ ->
                    InMap1 = InMap#{C := S},
                    loop_del(NextC, InMap1, Node, MTM, Q)
            end
    end;
loop_del([], InMap, _, MinTimeMap, Q) ->
    {InMap, MinTimeMap, Q}.

find_max(MinMap, C, N, Max) when C =< N ->
    find_max(MinMap, C + 1, N, max(Max, map_get(C, MinMap)));
find_max(_, _, _, Max) ->
    Max.
