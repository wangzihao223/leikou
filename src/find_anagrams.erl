%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 8月 2023 17:32
%%%-------------------------------------------------------------------
-module(find_anagrams).

-author("wangzihao").

% 438. 找到字符串中所有字母异位词

%% API
-export([find_anagrams/2]).

find_anagrams(S, P) ->
    SL = binary_to_list(S),
    PL = binary_to_list(P),
    Map = make_map(PL, #{}),
    start(SL, length(PL), Map, []).

make_map([L | NextL], Map) ->
    make_map(NextL, Map#{L => maps:get(L, Map, 0) + 1});
make_map([], Map) ->
    Map.

start(SL, Length, Map, Res) ->
    init_and_move(SL, Length, Map, 0, Res).

init_and_move(L, Length, Map, I, Res) ->
    case init_window(queue:new(), #{}, L, Length, Map, I, Length) of
        false ->
            Res;
        {Win1, WinMap1, Remain, I1} ->
            Res1 = update_res(Res, Map, WinMap1, Win1),
            move_window(Win1, WinMap1, Map, Remain, I1, Res1, Length)
    end.

init_window(_Window, _WinMap, [], Length, _Map, _Index, _SourceLength) when Length > 0 ->
    false;
init_window(Window, WinMap, [L | NextL], Length, Map, Index, SourceLength)
    when Length > 0 ->
    case maps:is_key(L, Map) of
        true ->
            init_window(queue:in([L, Index], Window),
                        WinMap#{L => maps:get(L, WinMap, 0) + 1},
                        NextL,
                        Length - 1,
                        Map,
                        Index + 1,
                        SourceLength);
        false ->
            init_window(queue:new(), #{}, NextL, SourceLength, Map, Index + 1, SourceLength)
    end;
init_window(Window, WinMap, Remain, _, _, Index, _SourceLength) ->
    {Window, WinMap, Remain, Index}.

move_window(Win, WinMap, Map, [L | NextL], I, Res, Length) ->
    case maps:is_key(L, Map) of
        false ->
            init_and_move(NextL, Length, Map, I + 1, Res);
        true ->
            {{value, [K, _]}, Win1} = queue:out(Win),
            Win2 = queue:in([L, I], Win1),
            WinMap1 = WinMap#{K := map_get(K, WinMap) - 1},
            WinMap2 = WinMap1#{L => maps:get(L, WinMap1, 0) + 1},
            Res1 = update_res(Res, Map, WinMap2, Win2),
            move_window(Win2, WinMap2, Map, NextL, I + 1, Res1, Length)
    end;
move_window(_, _, _, [], _, Res, _) ->
    Res.

equal(Map, WinMap) ->
    case maps:next(Map) of
        none ->
            true;
        {K, V, Next} ->
            case maps:is_key(K, WinMap) of
                true ->
                    case V == map_get(K, WinMap) of
                        true ->
                            equal(Next, WinMap);
                        false ->
                            false
                    end;
                false ->
                    false
            end
    end.

update_res(Res, Map, WinMap, Win) ->
    case equal(maps:iterator(Map), WinMap) of
        true ->
            [_, I2] = queue:head(Win),
            [I2 | Res];
        false ->
            Res
    end.
