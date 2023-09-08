-module(repair_cars).
% 修车最小时间
-export([main/2]).

main(Ranks, Cars) ->
    [H | _] = Ranks,
    High = Cars * Cars * H,
    binary_search(0, High, High div 2, Cars, Ranks, High).

% 当前时间是否能够做完
time_is_enough(Count, [Capacity | Next], Time) ->
    Count1 = Count - trunc(math:sqrt(Time / Capacity)),
    time_is_enough(Count1, Next, Time);
time_is_enough(Count, [], _) when Count > 0 -> false;
time_is_enough(_, [], _) -> true.

binary_search(L, H, M, Count, CapacityList, Res) when H >= L ->
    case time_is_enough(Count, CapacityList, M) of
        true -> 
            binary_search(L, M - 1, (L + M - 1) div 2, Count, CapacityList, min(Res, M));
        false ->
            binary_search(M + 1, H, (H + M + 1) div 2, Count, CapacityList, Res)
    end;
binary_search( _, _, _, _, _, Res) -> Res.

