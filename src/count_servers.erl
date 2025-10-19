-module(count_servers).

-export([count_servers/1]).

% 统计参与通信的服务器
count_servers(Grid) ->
    {R, C} = loop_row(Grid, 0, #{}, #{}),
    io:format("R ~p C ~p ~n", [R, C]),
    loop_row_1(Grid, 0, R, C, 0).

loop_col([C | Next], I, J, RowsMap, ColsMap) when C == 1 ->
    RowsMap1 = RowsMap#{I => maps:get(I, RowsMap, 0) + 1},
    ColsMap1 = ColsMap#{J => maps:get(J, ColsMap, 0) + 1},
    loop_col(Next, I, J + 1, RowsMap1, ColsMap1);
loop_col([_ | Next], I, J, RowsMap, ColsMap) ->
    loop_col(Next, I, J + 1, RowsMap, ColsMap);
loop_col([], _, _, RowsMap, ColsMap) ->
    {RowsMap, ColsMap}.

loop_row([Rows | Next], I, RowsMap, ColsMap) ->
    {RowsMap1, ColsMap1} = loop_col(Rows, I, 0, RowsMap, ColsMap),
    loop_row(Next, I + 1, RowsMap1, ColsMap1);
loop_row([], _, RowsMap, ColsMap) ->
    {RowsMap, ColsMap}.

loop_col_1([C | Next], I, J, RMap, CMap, Count) when C == 1 ->
    Count1 =
        case (maps:get(I, RMap, 0) > 1) or (maps:get(J, CMap, 0) > 1) of
            true ->
                Count + 1;
            false ->
                Count
        end,
    loop_col_1(Next, I, J + 1, RMap, CMap, Count1);
loop_col_1([_ | Next], I, J, RMap, CMap, Count) ->
    loop_col_1(Next, I, J + 1, RMap, CMap, Count);
loop_col_1([], _, _, _, _, Count) ->
    Count.

loop_row_1([Rows | Next], I, RowsMap, ColsMap, Count) ->
    Count1 = loop_col_1(Rows, I, 0, RowsMap, ColsMap, Count),
    loop_row_1(Next, I + 1, RowsMap, ColsMap, Count1);
loop_row_1([], _, _, _, Count) ->
    Count.
