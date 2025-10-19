-module(lemonade_change).

% 在柠檬水摊上，每一杯柠檬水的售价为 5 美元。顾客排队购买你的产品，（按账单 bills 支付的顺序）一次购买一杯。

% 每位顾客只买一杯柠檬水，然后向你付 5 美元、10 美元或 20 美元。你必须给每个顾客正确找零，也就是说净交易是每位顾客向你支付 5 美元。

% 注意，一开始你手头没有任何零钱。

% 给你一个整数数组 bills ，其中 bills[i] 是第 i 位顾客付的账。如果你能给每位顾客正确找零，返回 true ，否则返回 false 。

%  [5,5,5,10,20]
%
-export([lemonade_change/1]).

-spec lemonade_change(Bills :: [integer()]) -> boolean().
lemonade_change(Bills) ->
    sim_process(Bills, 0, 0).

sim_process([B | NextBill], Five, Ten) ->
    case B of
        5 ->
            sim_process(NextBill, Five + 1, Ten);
        10 ->
            if Five == 0 ->
                   false;
               true ->
                   sim_process(NextBill, Five - 1, Ten + 1)
            end;
        20 ->
            if Ten =/= 0, Five =/= 0 ->
                   sim_process(NextBill, Five - 1, Ten - 1);
               Five > 2 ->
                   sim_process(NextBill, Five - 3, Ten);
               true ->
                   false
            end
    end;
sim_process([], _, _) ->
    true.
