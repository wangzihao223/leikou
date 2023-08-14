
-module(remove_nth_from_end).

-export([remove_nth_from_end/2]).
-export([test/2]).

-record(list_node, {val = 0, next = null }).


% 删除链表的倒数第N个节点
remove_nth_from_end(#list_node{val = _, next = null}, 1) -> null;
remove_nth_from_end(Head, N) ->
    {Q, Head1, List} = init_queue(queue:new(), Head, N, []),
    {Q1, After} = find_node(Head1, Q, List),
    [H | Next] = remain_node(Q1, After),
    reinstall(Next, #list_node{val = H, next = null}).

init_queue(Q, #list_node{next = Next, val = Val}, N, List) when N > 0 ->
    Q1 = queue:in({Val, List}, Q),
    init_queue(Q1, Next, N - 1, [Val | List]);
init_queue(Q, Head, 0, List) -> {Q, Head, List}.


find_node(#list_node{val = V, next = Next}, Q, List)->
    {_, Q1} =  queue:out(Q),
    Q2 = queue:in({V, List}, Q1),
    find_node(Next, Q2, [V | List]);
find_node(null, Q, _List) ->
    {{value, {_, L}}, Q1} = queue:out(Q),
    io:format("L is ~p ~n", [L]),
    {Q1, L}.

remain_node(Q, List) ->
    case queue:out(Q) of
        {{value, {V, _}}, Q1} -> remain_node(Q1, [V | List]);
        {empty, _} -> List
    end.

reinstall([L | Next], Head) ->
    reinstall(Next, #list_node{val = L, next = Head});
reinstall([], Head) -> Head.



create_node(L) -> 
    [H | Next] = lists:reverse(L),
    create_node1(Next, #list_node{next = null, val = H}).

create_node1([N | Next], Res) ->
    create_node1(Next, #list_node{next = Res, val = N});
create_node1([], Res) -> Res.


test(L, N) ->
    Head = create_node(L),
    remove_nth_from_end(Head, N).