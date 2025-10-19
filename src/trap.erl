%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. 7月 2023 13:10
%%%-------------------------------------------------------------------
-module(trap).

-author("wangzihao").

% 接雨水

%% API
-export([container/4]).
-export([trap/1]).

trap([H | NextH]) ->
    container([{H, 0}], 0, NextH, 1).

container([{Top, TopIndex} | Stack], Counter, [H | NextHeight], Index) when Top > H ->
    container([{H, Index}, {Top, TopIndex} | Stack], Counter, NextHeight, Index + 1);
container([{Top, TopIndex} | Stack], Counter, [H | NextHeight], Index) ->
    {NewCounter, NewStack} = counter(Counter, [{Top, TopIndex} | Stack], {H, Index}),
    container(NewStack, NewCounter, NextHeight, Index + 1);
container(_, Counter, [], _) ->
    Counter.

counter(Counter, [{Top, _}, {Second, SecondIndex} | Stack], {H, Index}) when H > Top ->
    NewCounter = (min(Second, H) - Top) * (Index - SecondIndex - 1) + Counter,
    counter(NewCounter, [{Second, SecondIndex} | Stack], {H, Index});
counter(Counter, [{Top, _}], {H, Index}) when H > Top ->
    {Counter, [{H, Index}]};
counter(Counter, Stack, {H, Index}) ->
    {Counter, [{H, Index} | Stack]}.
