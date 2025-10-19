-module(good_nodes).

-export([good_nodes/1]).

%% Definition for a binary tree node.
-record(tree_node,
        {val = 0 :: integer(),
         left = null :: null | #tree_node{},
         right = null :: null | #tree_node{}}).

-spec good_nodes(Root :: #tree_node{} | null) -> integer().
good_nodes(Root) ->
    travel_node(Root, -10000, []).

travel_node(null, _, Res) ->
    Res;
travel_node(#tree_node{left = Left,
                       right = Right,
                       val = Val},
            Max,
            Res) ->
    if Val >= Max ->
           Res1 = Res + 1;
       true ->
           Res1 = Res
    end,
    Max1 = max(Max, Val),
    Res2 = travel_node(Left, Max1, Res1),
    Res3 = travel_node(Right, Max1, Res2),
    Res3.
