-module(path_sum).
-export([path_sum/2]).

-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> integer().
path_sum(Root, TargetSum) ->
  ok.


preorder(#tree_node{val = Val, left = Left, right = Right}, Res) ->
    prefix 
    preorder(Left),
    preorder(Right);
preorder(null) -> ok.