-module(dist_money).

-export([dist_money/2]).

% 将钱分给最多的儿童
-spec dist_money(Money :: integer(), Children :: integer()) -> integer().
dist_money(Money, Children) ->
    if Children * 8 < Money ->
           Children - 1;
       Money < Children ->
           -1;
       Money == 8 * Children - 4 ->
           Children - 2;
       true ->
           (Money - Children) div 7
    end.
