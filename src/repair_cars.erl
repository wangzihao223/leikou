-module(repair_cars).
-export([reszie_range/3]).
-export([time_range/2]).

% binary_search() 

% 生成时间范围
time_range(L, H) -> lists:seq(L, H).

%调整范围
reszie_range(S, L, H) ->
    [X || X <- S,  X >= L , X =< H].

% 当前时间是否能够做完
time_is_enough(Count, [Capacity | Next], Time) ->
    Count1 = Count - trunc(math:sqrt(Time / Capacity)),
    time_is_enough(Count1, Next, Time);
time_is_enough(Count, [], _) when Count > 0 -> false;
time_is_enough(_, [], _) -> true.

binary_search(S, _, _, _, _, _) -> S
binary_search(S, L, H, M, Count, CapacityList) ->
    case time_is_enough(Count, CapacityList, M) of
        true -> 
            NewS = reszie_range(S, L, M),
            binary_search(NewS, L, M, (L + M) div 2, Count, CapacityList);
        false ->
            NewS = reszie_range(S, M, H),
            binary_search(NewS, M, H, (L + M) div 2, Count, CapacityList)
    end.


