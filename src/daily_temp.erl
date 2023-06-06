-module(daily_temp).

-export([test/1]).

% 每日温度

main(Temp) ->
    R = loop(Temp, [], [], 0),
    R1 = lists:sort(R),
    creat_answer(R1, []).


loop([], Stack, R, _)->
    clear_stack(Stack, R);
loop([T|NextT], Stack, R, I) ->
    if Stack == [] ->
       NewStack = [{T, I}|Stack],
       loop(NextT, NewStack, R, I+1);
    true ->
        {NR, NewStack} = loop_pop(Stack, R, {T, I}),
        loop(NextT, NewStack, NR, I+1)
    end.
loop_pop([], R, {T, TIndex}) ->
    {R, [{T,TIndex}]};
loop_pop([{Top, TopIndex}|NextStack], R, {T, TIndex}) ->
    if T > Top ->
        NewR = [{TopIndex, (TIndex - TopIndex)} | R],
        loop_pop(NextStack, NewR, {T, TIndex});
    true ->
        NewStack = [{T,TIndex}|[{Top, TopIndex}|NextStack]],
        {R, NewStack}
    end.

clear_stack([], R)-> R;
clear_stack([{_, I}| NextStack], R) ->
    NewR = [{I, 0}|R],
    clear_stack(NextStack, NewR).

creat_answer([], R) ->
    lists:reverse(R);
creat_answer([{_, V}|Next], R) ->
    creat_answer(Next, [V|R]).


test(L) ->
    R = main(L),
    io:format("res ~p ~n", [R]).
