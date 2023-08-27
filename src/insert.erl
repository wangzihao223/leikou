-module(insert).

-export([insert/2]).

% 插入区间

insert([], N) -> [N];
insert([[L1, R1] | Next], [L2, R2])when L1 > L2 ->
    insert1([[L1, R1] | Next], [[L2, R2]], null);
insert([[L1, R1] | Next], [L2, R2]) ->
    insert1(Next, [[L1, R1]], [L2, R2]).

insert1([[L1, R1] | Next], [[L2, R2] | Next1], [L3, R3]) when L3 =< L1 ->
    insert1([[L3, R3], [L1, R1] | Next], [[L2, R2] | Next1], null);
insert1([[L1, R1] | Next], [[L2, R2] | Next1], null) ->
    merge(L2, R2, L1, R1, Next, Next1);
insert1([[L1, R1] | Next], [[L2, R2] | Next1], A) ->
    insert1(Next, [[L1, R1], [L2, R2] | Next1], A);
insert1([], [[L1, R1] | Next], [L3, R3]) ->
    merge(L1, R1, L3, R3, [], Next);
insert1([], Res, _) -> lists:reverse(Res).

merge(L1, R1, L2, R2, Next, Next1) ->
    if R1 >= L2 ->
        insert1(Next, [[L1, max(R1, R2)] | Next1], null);
        true -> insert1(Next, [[L2, R2], [L1, R1] | Next1], null)
    end.
