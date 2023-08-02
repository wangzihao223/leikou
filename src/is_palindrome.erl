
-module(is_palindrome).

-export([is_palindrome/1]).

-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).
-spec is_palindrome(Head :: #list_node{} | null) -> boolean().

is_palindrome(Head) ->
    L = copy_to_list(Head, []),
    L == lists:reverse(L).

copy_to_list(null, L) -> L;
copy_to_list(Node, L) ->
    #list_node{next = Next, val = Val} = Node,
    copy_to_list(Next, [ Val | L]).
