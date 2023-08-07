%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 8月 2023 11:54
%%%-------------------------------------------------------------------
-module(sort_array).
-author("16009").

%% API
-export([]).
-record(list_node, {val = 0, next= null}).
sort_list(List) ->
  L = to_list(List, []),
  L1 = lists:sort(L),
  to_link(lists:reverse(L1), null).

to_list(null, List) -> List;
to_list(#list_node{val = V, next = Next}, List) ->
  to_list(Next, [V | List]).

to_link([V | Next], Link) ->
  to_link(Next, #list_node{val = V, next = Link});
to_link([], Link) -> Link.