-module(circular_game_losers).

-export([circular_game_losers/2]).

circular_game_losers(N, K) ->
    % S = sets:new(),
    % CountSet = start_game(sets:add_element(0, S), 1, K, 0, N),
    % get_losers(CountSet, N - 1, []).
    Array = loop(create_array(N), N, 0, 1, K),
    get_res(Array, N - 1, []).

start_game(CountSet, Round, K, PlayerId, PlayerNum) ->
    % 计算下一个接球的 PlayerId
    NextPlayerId = (K * Round + PlayerId) rem PlayerNum,
    io:format("the next player is ~p ~n", [NextPlayerId + 1]),
    case sets:is_element(NextPlayerId, CountSet) of
        true ->
            CountSet;
        false ->
            start_game(sets:add_element(NextPlayerId, CountSet),
                       Round + 1,
                       K,
                       NextPlayerId,
                       PlayerNum)
    end.

get_losers(CountSet, PlayerNum, Res) when PlayerNum >= 0 ->
    case sets:is_element(PlayerNum, CountSet) of
        true ->
            get_losers(CountSet, PlayerNum - 1, Res);
        false ->
            get_losers(CountSet, PlayerNum - 1, [PlayerNum + 1 | Res])
    end;
get_losers(_CountSet, _PlayerNum, Res) ->
    Res.

create_array(N) ->
    A = array:new([{size, N}, {default, 0}]),
    array:set(0, 1, A).

loop(Array, PlayerNum, PlayerId, Round, K) ->
    NextPlayerId = (K * Round + PlayerId) rem PlayerNum,
    V = array:get(NextPlayerId, Array),
    io:format("the next player is ~p ~n", [NextPlayerId + 1]),
    if V =/= 0 ->
           Array;
       true ->
           loop(array:set(NextPlayerId, V + 1, Array), PlayerNum, NextPlayerId, Round + 1, K)
    end;
loop(Array, _, _, _, _) ->
    Array.

get_res(Array, PlayerNum, Res) when PlayerNum >= 0 ->
    V = array:get(PlayerNum, Array),
    if V == 0 ->
           get_res(Array, PlayerNum - 1, [PlayerNum + 1 | Res]);
       true ->
           get_res(Array, PlayerNum - 1, Res)
    end;
get_res(_, _, Res) ->
    Res.
