%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 8月 2023 9:10
%%%-------------------------------------------------------------------
-module(circular_game_losers).
-author("16009").

% 找出转圈游戏输家
%% API
-export([circular_game_losers/2]).


-spec circular_game_losers(N :: integer(), K :: integer()) -> [integer()].

circular_game_losers(N, K) ->
    S = sets:new(),
    CountSet = start_game(sets:add_element(0, S), 1, K, 0, N),
    get_losers(CountSet, N - 1, []).


start_game(CountSet, Round, K, PlayerId, PlayerNum) ->
    % 计算下一个接球的 PlayerId
    NextPlayerId = (K * Round + PlayerId) rem PlayerNum,
    % io:format("the next player is ~p ~n", [NextPlayerId + 1]),
    case sets:is_element(NextPlayerId, CountSet) of
        true -> CountSet;
        false ->
            start_game(sets:add_element(NextPlayerId, CountSet), Round + 1, K, NextPlayerId, PlayerNum)
    end.

get_losers(CountSet, PlayerNum, Res) when PlayerNum >= 0 ->
    case sets:is_element(PlayerNum, CountSet)  of
        true -> get_losers(CountSet, PlayerNum - 1, Res);
        false -> get_losers(CountSet, PlayerNum - 1, [PlayerNum + 1 | Res])
    end;
get_losers(_CountSet, _PlayerNum, Res) -> Res.