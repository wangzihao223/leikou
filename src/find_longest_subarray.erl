-module(find_longest_subarray).

-export([find_longest_subarray/1]).
-export([string_to_bin/1]).

% 字母与数字

find_longest_subarray(Array) ->
    Length = erlang:length(Array),
    {_, S, MS} = erlang:timestamp(),
    io:format("S is ~p, MS is ~p", [S, MS]),
    put(0, -1),
    case loop(Array, 0, 0, Length) of
        error ->
            erase(),
            [];
        {L, R} ->
            {_, S2, MS2} = erlang:timestamp(),
            io:format("time is ~p ~n", [(S2 - S) * 1000_000 + (MS2 - MS)]),

            {_, S1, MS1} = erlang:timestamp(),
            io:format("S is ~p, MS is ~p", [S1, MS1]),
            io:format("time is ~p ~n", [(S1 - S) * 1000_000 + (MS1 - MS)]),
            Res = array_split(L + Length + 1, R + Length + 1, []),
            erase(),
            Res
    end.

array_split(L, R, Res) when R >= L ->
    % E = array:get(R, A),
    E = get(R),
    NewR = [E | Res],
    array_split(L, R - 1, NewR);
array_split(_, _, Res) ->
    Res.

string_to_bin(L) ->
    [unicode:characters_to_binary(X) || X <- L].

loop([], _Index, _, _) ->
    case get("max_length") of
        undefined ->
            error;
        Res ->
            Res
    end;
loop(Array, Index, N, Length) ->
    [Element | NextArray] = Array,
    put(Index + Length + 1, Element),
    %A1 = array:set(Index, Element, A),
    E = binary:part(Element, 0, 1),
    if E >= <<48>>, E =< <<57>> ->
           look_up_sum(N + 1, Index),
           loop(NextArray, Index + 1, N + 1, Length);
       true ->
           look_up_sum(N - 1, Index),
           loop(NextArray, Index + 1, N - 1, Length)
    end.

look_up_sum(N, Index) ->
    case get(N) of
        undefined ->
            put(N, Index);
        LeftIndex ->
            % 维护最大长度
            % io:format("找到N ~B ~n", [LeftIndex]),
            get_bigest(Index - LeftIndex, LeftIndex + 1, Index)
    end.

get_bigest(Length, Left, Right) ->
    case get("max_length") of
        undefined ->
            put("max_length", {Left, Right});
        {L1, R1} ->
            if Length > R1 - L1 + 1 ->
                   put("max_length", {Left, Right});
               true ->
                   ok
            end
    end.
