%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 8月 2023 16:11
%%%-------------------------------------------------------------------
-module(max_sliding_window).

-author("16009").

% 滑动窗口最大值

%% API
-export([max_sliding_window/2]).

-spec max_sliding_window(Nums :: [integer()], K :: integer()) -> [integer()].
max_sliding_window(Nums, K) ->
    {Remain, Win1, Heap1, Index} = init_window(Nums, queue:new(), nil, 0, K),
    {Max, _} = top(Heap1),
    move_window(Remain, Win1, Heap1, Index, [Max], K).

init_window([N | NextN], Window, Heap, Index, Length) when Length > 0 ->
    init_window(NextN,
                queue:in({N, Index}, Window),
                insert(N, Index, Heap),
                Index + 1,
                Length - 1);
init_window(Nums, Window, Heap, Index, _) ->
    {Nums, Window, Heap, Index}.

move_window([N | NextN], Win, Heap, Index, Res, Length) ->
    {{value, {_N1, I1}}, Win1} = queue:out(Win),
    Win2 = queue:in({N, Index}, Win1),
    Heap1 = insert(N, Index, Heap),
    {Max, MaxI} = top(Heap1),
    if MaxI =/= I1 ->
           % 不需要改变heap
           move_window(NextN, Win2, Heap1, Index + 1, [Max | Res], Length);
       true ->
           % 需要改变 heap
           Heap2 = check_heap(N, Index - Length + 1, Heap1),
           {Max1, _MaxI1} = top(Heap2),
           move_window(NextN, Win2, Heap2, Index + 1, [Max1 | Res], Length)
    end;
move_window([], _, _, _, Res, _) ->
    lists:reverse(Res).

% 维护heap
check_heap(N, LIndex, Heap) ->
    case top(Heap) of
        {_MaxN, MaxI} ->
            if LIndex > MaxI ->
                   % 弹出
                   {_, _, Heap1} = delete_min(Heap),
                   check_heap(N, LIndex, Heap1);
               true ->
                   Heap
            end;
        nil ->
            Heap
    end.

% heap

empty() ->
    nil.

insert(K, V, Tree) ->
    merge({K, V, nil, nil}, Tree).

delete_min(nil) ->
    {empty_error};
delete_min({K, V, C, nil}) ->
    {K, V, ccm_ccm(ccm(C, []), nil)}.

top(nil) ->
    nil;
top({K, V, _, nil}) ->
    {K, V}.

merge(nil, T2) ->
    T2;
merge(T1, nil) ->
    T1;
merge({K1, V1, C1, nil}, {K2, V2, C2, nil}) when K1 < K2 ->
    {K2, V2, {K1, V1, C1, C2}, nil};
merge({K1, V1, C1, nil}, {K2, V2, C2, nil}) ->
    {K1, V1, {K2, V2, C2, C1}, nil}.

% child_and_child_merge
ccm({K1, V1, C1, {K2, V2, C2, B}}, R) ->
    NewTree = merge({K1, V1, C1, nil}, {K2, V2, C2, nil}),
    ccm(B, [NewTree | R]);
ccm({K1, V1, C1, nil}, R) ->
    [{K1, V1, C1, nil} | R];
ccm(nil, R) ->
    R.

% child_and_child_merge result merge
ccm_ccm([T | NextT], ResultTree) ->
    ccm_ccm(NextT, merge(T, ResultTree));
ccm_ccm([], ResultTree) ->
    ResultTree.
