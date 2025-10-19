-module(summar_ranges).

% 汇总区间
-spec summary_ranges(Nums :: [integer()]) -> [unicode:unicode_binary()].
summary_ranges(Nums) ->
    lists:reverse(loop(Nums, [], [])).

loop([N, N2 | Next], Res, S) ->
    if N + 1 == N2, S == [] ->
           loop([N2 | Next], Res, [integer_to_binary(N)]);
       N + 1 =/= N2, S == [] ->
           loop([N2 | Next], [integer_to_binary(N) | Res], []);
       N + 1 =/= N2, S =/= [] ->
           [N1] = S,
           N2_Bin = integer_to_binary(N),
           R = <<N1/binary, "->", N2_Bin/binary>>,
           loop([N2 | Next], [R | Res], []);
       true ->
           loop([N2 | Next], Res, S)
    end;
loop([N], Res, S) ->
    if S == [] ->
           [integer_to_binary(N) | Res];
       true ->
           [N1] = S,
           N2_Bin = integer_to_binary(N),
           R = <<N1/binary, "->", N2_Bin/binary>>,
           [R | Res]
    end.
