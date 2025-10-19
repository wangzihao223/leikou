-module(find_delayed_arrival_time).

-export([find_delayed_arrival_time/2]).

find_delayed_arrival_time(ArrivalTime, DelayedTime) ->
    (ArrivalTime + DelayedTime) rem 24.
