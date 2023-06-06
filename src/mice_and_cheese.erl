-module(mice_and_cheese).
-export([main/3]).

% 老鼠和奶酪
main(Reward1, Reward2, K)->
    {ExpectK1, DValueTuple, Bigest} = best_plan(0, Reward1, Reward2, {[],[]}, 0),
    better_plan(K, ExpectK1, DValueTuple, Bigest).

% init_map()-> #{mice1=>0, micce2=>0}.

best_plan(R, [], [], {R1, R2}, Biggest) -> 
    {R, {lists:sort(R1), lists:sort(R2)}, Biggest};
best_plan(ExpectK1, [V1|NextR1], [V2|NextR2], {T1, T2}, Biggest) ->
    if V1 > V2 ->
        NBiggest = Biggest + V1,
        NewExpectK1 = ExpectK1 + 1,
        Record = {[V1 - V2|T1], T2},
        best_plan(NewExpectK1, NextR1, NextR2,  Record, NBiggest);
    true ->
        NBiggest = Biggest + V2,
        Record = {T1, [V2 - V1|T2]},
        best_plan(ExpectK1, NextR1, NextR2, Record, NBiggest)
    end.


better_plan(K, ExpectK1, {_R1, R2}, Biggest) when K >= ExpectK1->
    N = K - ExpectK1,
    DValue = get_dvalue(N, R2),
    Biggest - DValue;
better_plan(K, ExpectK1, {R1, _R2}, Biggest) ->
    N = ExpectK1 - K,
    DValue = get_dvalue(N, R1),
    Biggest - DValue.

get_dvalue(N, L) ->
    get_dvalue(N, L, 0).

get_dvalue(0, _, R) -> R;
get_dvalue(N, [D|Next], R) ->
    get_dvalue(N-1, Next, R+D).
