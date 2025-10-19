-module(path_sum).

-export([path_sum/2]).

% 路径总和 III
-record(tree_node,
        {val = 0 :: integer(),
         left = null :: null | #tree_node{},
         right = null :: null | #tree_node{}}).

-spec path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> integer().
path_sum(Root, TargetSum) ->
    {R, _} = preorder(Root, #{0 => 1}, 0, TargetSum),
    R.

preorder(#tree_node{val = Val,
                    left = Left,
                    right = Right},
         Map,
         Curr,
         Target) ->
    Curr1 = Curr + Val,
    % 距离 = 前缀和2 - 前缀和1
    Ret = maps:get(Curr1 - Target, Map, 0),
    Map1 = Map#{Curr1 => 1 + maps:get(Curr1, Map, 0)},
    {Ret1, Map2} = preorder(Left, Map1, Curr1, Target),
    Ret2 = Ret1 + Ret,
    {Ret3, Map3} = preorder(Right, Map2, Curr1, Target),
    Ret4 = Ret3 + Ret2,
    {Ret4, Map3#{Curr1 => maps:get(Curr1, Map3, 0) - 1}};
preorder(null, Map, _, _) ->
    {0, Map}.
