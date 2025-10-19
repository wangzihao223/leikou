%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. 7月 2023 10:24
%%%-------------------------------------------------------------------
-module(delete_greatest_value).

-author("wangzihao").

%% API
-export([delete_greatest_value/1]).

delete_greatest_value(Grid) ->
    GridSort = sort_rows(Grid, []),
    [Row | _] = GridSort,
    EmptyGrid = empty_col_grid(Row, []),
    ColGrid = col_grid(GridSort, EmptyGrid),
    loop_col_grid(ColGrid, 0).

sort_rows([Row | NextRows], Grid) ->
    sort_rows(NextRows, [lists:sort(Row) | Grid]);
sort_rows([], Grid) ->
    Grid.

loop_col_grid([Col | NextCol], Answer) ->
    [M | _] = Col,
    loop_col_grid(NextCol, max_num(Col, M) + Answer);
loop_col_grid([], Answer) ->
    Answer.

max_num([N | NextN], Max) when N > Max ->
    max_num(NextN, N);
max_num([_ | NextN], M) ->
    max_num(NextN, M);
max_num([], Max) ->
    Max.

col_grid([Row | NextRows], R) ->
    col_grid(NextRows, loop_row(Row, R, []));
col_grid([], R) ->
    R.

loop_row([N | NextN], [Columns | NextColumns], R) ->
    loop_row(NextN, NextColumns, [[N | Columns] | R]);
loop_row([], [], R) ->
    lists:reverse(R).

empty_col_grid([_ | NextC], R) ->
    empty_col_grid(NextC, [[] | R]);
empty_col_grid([], R) ->
    R.
