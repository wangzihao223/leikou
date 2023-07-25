%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 7月 2023 10:19
%%%-------------------------------------------------------------------
-module(heapq).
-author("wangzihao").

%% API
-export([empty/0]).
-export([insert/3]).
-export([delete_min/1]).


% type

-type p_tree_node(K, V) :: 'nil' |
  {K, V, p_tree_node(K, V), p_tree_node(K,V)}.

-type p_tree() :: p_tree_node(_, _).

-spec empty() -> p_tree().

empty() -> nil.

-spec insert(K, V, Tree) -> p_tree() when
    K :: integer(),
    V :: any(),
    Tree :: p_tree().

insert(K, V, Tree) ->
  merge({K, V, nil, nil}, Tree).

-spec delete_min(Tree) -> {K, V, p_tree()} when
  Tree :: p_tree(),
  K :: integer(),
  V :: any().

delete_min(nil) -> {empty_error};
delete_min({K, V, C, nil}) ->
  {K, V, ccm_ccm(ccm(C, []), nil)}.


merge(nil, T2) -> T2;
merge(T1, nil) -> T1;
merge({K1, V1, C1, nil}, {K2, V2, C2, nil}) when K1 > K2 ->
  {K2, V2, {K1, V1, C1, C2}, nil};
merge({K1, V1, C1, nil}, {K2, V2, C2, nil}) ->
  {K1, V1, {K2, V2, C2, C1}, nil}.

% child_and_child_merge
ccm({K1, V1, C1, {K2, V2, C2, B}}, R) ->
  NewTree = merge({K1, V1, C1, nil}, {K2, V2, C2, nil}),
  ccm(B, [NewTree | R]);
ccm({K1, V1, C1, nil}, R) -> [{K1, V1, C1, nil} | R];
ccm(nil, R) -> R.

% child_and_child_merge result merge
ccm_ccm([T | NextT], ResultTree) ->
  ccm_ccm(NextT, merge(T, ResultTree));
ccm_ccm([], ResultTree) -> ResultTree.
