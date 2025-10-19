-module(k_items_with_maximum_sum).

-export([k_items_with_maximum_sum/4]).

-spec k_items_with_maximum_sum(NumOnes :: integer(),
                               NumZeros :: integer(),
                               NumNegOnes :: integer(),
                               K :: integer()) ->
                                  integer().
k_items_with_maximum_sum(NumOnes, NumZeros, _NumNegOnes, K) ->
    max_sum(NumOnes, NumZeros, K).

max_sum(One, _Zero, K) when K =< One ->
    K;
max_sum(One, Zero, K) when K =< One + Zero ->
    One;
max_sum(One, Zero, K) ->
    2 * One - K + Zero.
