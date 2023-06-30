-module(can_make_pali).

-export([main/2]).

%构建回文串检测

init_letter_array(0, Array) ->
    Array;
init_letter_array(N, Array) ->
    init_letter_array(N - 1, Array#{N - 1 => 0}).

init_letter_array() ->
    init_letter_array(26, #{}).

init_table(LArray, L) ->
    array:new(L + 1, [{default, LArray}]).

make_table([], _, Table) ->
    Table;
make_table([Letter | NextS], Index, Table) ->
    LArray = array:get(Index - 1, Table),
    NewLArray = maps_update(LArray, Letter - 97),
    NewTable = array:set(Index, NewLArray, Table),
    make_table(NextS, Index + 1, NewTable).

maps_update(Map, Key) ->
    V = maps:get(Key, Map) + 1,
    Map#{Key => V}.

seach_table(I1, I2, Table) ->
    LArray = array:get(I1, Table),
    maps:get(I2, LArray).

check_one([_L, _R, K], _Table, 26, Sum) ->
    % io:format("Sum ~p ~n", [Sum]),
    case Sum div 2 =< K of
        true ->
            true;
        false ->
            false
    end;
check_one([L, R, K], Table, N, Sum) ->
    NewSum = (seach_table(R + 1, N, Table) - seach_table(L, N, Table)) band 1 + Sum,
    check_one([L, R, K], Table, N + 1, NewSum).

check_all([], _Table, R) ->
    lists:reverse(R);
check_all([Q | NextQs], Table, R) ->
    E = check_one(Q, Table, 0, 0),
    check_all(NextQs, Table, [E | R]).

main(S, Queries) ->
    Len = erlang:byte_size(S),
    SL = binary:bin_to_list(S),
    A = init_letter_array(),
    T = init_table(A, Len),
    NewT = make_table(SL, 1, T),
    check_all(Queries, NewT, []).
