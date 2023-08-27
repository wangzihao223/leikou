%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 8月 2023 18:49
%%%-------------------------------------------------------------------
-module(min_window).
-author("16009").

%% API
%% 最小覆盖子串
%%-export([min_window/2]).
%%
-export([min_window/2]).

% @doc sd
min_window(S, T) ->
    if byte_size(T) > byte_size(S) ->
        <<"">>;
    true ->
        S1 = binary_to_list(S),
        T1 = binary_to_list(T),
        Map = hash_t(T1, #{}),
        list_to_binary(move_window(S1, queue:new(), #{}, Map, null))
    end.

hash_t([N | Next], Map) ->
    Map1 = Map#{N => maps:get(N, Map, 0) + 1},
    hash_t(Next, Map1);
hash_t([], Map) -> Map.

move_window([N | Next], Win, WinMap, Map, Res) -> 
    case maps:is_key(N, Map) of
        false ->
            Win1 = conditon1(Win, N),
            move_window(Next, Win1, WinMap, Map, Res);
        true ->
           {Win1, WinMap1, Res1} = conditon2(Win, N, WinMap, Map, Res),
           move_window(Next, Win1, WinMap1, Map, Res1)
    end;
move_window([], _, _, _, Res) -> Res.

is_res(Win, null) -> queue:to_list(Win);
is_res(Win, Res) ->
    io:format("Res is  ~p ~n", [Res]),
    case length(Res) =< queue:len(Win) of 
        true -> Res;
        false -> queue:to_list(Win)
    end.
    

conditon1(Win, N) ->
    case queue:is_empty(Win) of
        true -> Win;
        false -> queue:in(N, Win)
    end.

conditon2(Win, N, WinMap, Map, Res) ->
    Win1 = queue:in(N, Win),
    WinMap1 = WinMap#{N => maps:get(N, WinMap, 0) + 1},
    case is_full(WinMap1, maps:iterator(Map)) of
        true -> 
            {Win2, WinMap2} = resize_window(Win1, WinMap1, Map),
            {Win2, WinMap2, is_res(Win2, Res)};
        false -> {Win1, WinMap1, Res}
    end.


is_full(_, none) -> true; 
is_full(WinMap, MapIter) ->
    {K1, V1, MapI2} = maps:next(MapIter),
    V2 = maps:get(K1, WinMap, 0),
    if V2 >= V1 -> is_full(WinMap, MapI2);
        true -> false
    end.

resize_window(Win, WinMap, Map) ->
    {{_, V}, Win1} = queue:out(Win),
    N1 = maps:get(V, WinMap),
    N2 = maps:get(V, Map),
    if N1 > N2 ->
        Win2 = clear_uselese(Win1, Map),
        resize_window(Win2, WinMap#{V=>N1 - 1}, Map);
        true-> {Win, WinMap}
    end.


clear_uselese(Win, Map) ->
    case queue:is_empty(Win) of
        false ->
            {{_, N}, Win1} = queue:out(Win),
            case maps:is_key(N, Map) of
                true -> Win;
                false -> clear_uselese(Win1, Map)
            end;
        true -> 
            Win
    end.

