%%%-------------------------------------------------------------------
%%% @author wangZiHao
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 7月 2023 14:49
%%%-------------------------------------------------------------------
-module(halve_array).
-author("wangzihao").

% 将数组和减半的最少操作次数

%% API
-export([halve_array/1]).
-spec halve_array(Nums :: [integer()]) -> integer().
halve_array(Nums) ->
  Sum = lists:sum(Nums),
  Q = push_all2queue(nil, Nums),
  halve(Q, Sum, 0, Sum/2).

push_all2queue(Q, [N | NextNums]) ->
  push_all2queue(insert(N, Q),NextNums);
push_all2queue(Q, []) -> Q.

halve(_, NowSum, Counter, Halve) when NowSum =< Halve ->
  Counter;
halve(Q, NowSum, Counter, Halve) ->
  {K, NextQ} = delete_max(Q),
  halve(insert(K/2, NextQ), NowSum - K / 2, Counter + 1, Halve).



new_tree() -> nil.

insert(K, Tree) ->
  merge({K, nil, nil}, Tree).

delete_max(nil) -> {empty_error};
delete_max({K, C, nil}) ->
  {K, ccm_ccm(ccm(C, []), nil)}.


merge(nil, T2) -> T2;
merge(T1, nil) -> T1;
merge({K1, C1, nil}, {K2, C2, nil}) when K1 < K2 ->
  {K2, {K1, C1, C2}, nil};
merge({K1, C1, nil}, {K2, C2, nil}) ->
  {K1, {K2, C2, C1}, nil}.

% child_and_child_merge
ccm({K1, C1, {K2, C2, B}}, R) ->
  NewTree = merge({K1, C1, nil}, {K2, C2, nil}),
  ccm(B, [NewTree | R]);
ccm({K1, C1, nil}, R) -> [{K1, C1, nil} | R];
ccm(nil, R) -> R.

% child_and_child_merge result merge
ccm_ccm([T | NextT], ResultTree) ->
  ccm_ccm(NextT, merge(T, ResultTree));
ccm_ccm([], ResultTree) -> ResultTree.
