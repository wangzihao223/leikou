-module(diameter_of_binary_tree).

-export([diameter_of_binary_tree/1]).

-record(tree_node,
        {val = 0 :: integer(),
         left = null :: null | #tree_node{},
         right = null :: null | #tree_node{}}).

% 二叉树直径
-spec diameter_of_binary_tree(Root :: #tree_node{} | null) -> integer().
diameter_of_binary_tree(Root) ->
    depth(Root, 0).

depth(#tree_node{left = Left, right = Right}, Max) ->
    {Count1, Max1} = depth(Left, Max),
    {Count2, Max2} = depth(Right, Max),
    {max(Count1, Count2), lists:max([Max1, Max2, Count1 + Count2])};
depth(null, Max) ->
    {0, Max}.
