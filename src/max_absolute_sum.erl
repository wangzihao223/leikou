%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. 8月 2023 9:25
%%%-------------------------------------------------------------------
-module(max_absolute_sum).
-author("16009").
% 任意子数组和的绝对值的最大值

%% API
-export([max_absolute_sum/1]).
-spec max_absolute_sum(Nums :: [integer()]) -> integer().
max_absolute_sum(Nums) ->
  max_value(Nums, 0, 0, 0, 0).

max_value([N | Next], UnsignedSum, UnsignedMax, SignedSum, SignedMax) ->
  UnsignedSum1 = UnsignedSum + N,
  UnsignedMax1 = max(UnsignedSum1, UnsignedMax),

  SignedSum1 = SignedSum + N,
  SignedMax1 = min(SignedSum1, SignedMax),

  max_value(Next, max(UnsignedSum1, 0), UnsignedMax1, min(SignedSum1, 0), SignedMax1);
max_value([], _, UnSignedMax, _, SignedMax) -> max(-1 * SignedMax, UnSignedMax).



