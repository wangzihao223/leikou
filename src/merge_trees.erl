%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 8月 2023 11:56
%%%-------------------------------------------------------------------
-module(merge_trees).

-author("16009").

% 合并二叉树

%% API
-export([]).

%Definition for a binary tree node.

-record(tree_node,
        {val = 0 :: integer(),
         left = null :: null | #tree_node{},
         right = null :: null | #tree_node{}}).

-spec merge_trees(Root1 :: #tree_node{} | null, Root2 :: #tree_node{} | null) ->
                     #tree_node{} | null.
merge_trees(Root1, Root2) ->
    travel_tree(Root1, Root2).

travel_tree(#tree_node{val = V1,
                       left = L1,
                       right = R1},
            #tree_node{val = V2,
                       left = L2,
                       right = R2}) ->
    #tree_node{val = V1 + V2,
               left = travel_tree(L1, L2),
               right = travel_tree(R1, R2)};
travel_tree(null, T2) ->
    T2;
travel_tree(T1, null) ->
    T1.
