% 字符串解码
%
%
-module(string_decode).

-export([decode_string/1]).

decode_string(S) ->
    list_to_binary(lists:reverse(read_str(S, []))).

decode_str(<<C:8, Next/binary>>, Box, Res) when C > 47, C < 58 ->
    decode_str(Next, [C - 48 | Box], Res);
decode_str(<<C:8, Next/binary>>, Box, Res) when C == 91 ->
    Count = to_integer(Box, 0, 1),
    io:format("Count is ~p ~n", [Count]),
    {Next1, Res1} = read_str(Next, []),
    io:format("Res1 is ~p ~n", [Res1]),
    Res2 = lists:reverse(merge_str(Count, Res1, [], Res1)),
    io:format("Res2 is ~p ~n", [Res2]),
    Res3 = merge_list(lists:reverse(Res2), Res),
    {Res3, Next1}.

merge_str(Count, _, R, _) when Count =< 0 ->
    R;
merge_str(Count, [S | Next], R, Source) ->
    merge_str(Count, Next, [S | R], Source);
merge_str(Count, [], R, Source) ->
    io:format("count ~p ~n", [Count]),
    merge_str(Count - 1, Source, R, Source).

merge_list([N | Next], L2) ->
    merge_list(Next, [N | L2]);
merge_list([], L2) ->
    L2.

read_str(<<C:8, Next/binary>>, Res) when C == 93 ->
    {Next, Res};
read_str(<<C:8, Next/binary>>, Res) when C =< 47; C >= 58 ->
    read_str(Next, [C | Res]);
read_str(<<C:8, Next/binary>>, Res) when C > 47, C < 58 ->
    {Res1, Str} = decode_str(<<C:8, Next/binary>>, [], Res),
    read_str(Str, Res1);
read_str(<<>>, Res) ->
    Res.

to_integer([N | Next], Res, M) ->
    to_integer(Next, Res + M * N, M * 10);
to_integer([], Res, _M) ->
    Res.
