%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%%%给定一个长度为 n 的环形整数数组 nums ，返回 nums 的非空 子数组 的最大可能和 。
%%%%环形数组 意味着数组的末端将会与开头相连呈环状。形式上， nums[i] 的下一个元素是 nums[(i + 1) % n] ， nums[i] 的前一个元素是 nums[(i - 1 + n) % n] 。
%%%%子数组 最多只能包含固定缓冲区 nums 中的每个元素一次。形式上，对于子数组 nums[i], nums[i + 1], ..., nums[j] ，不存在 i <= k1, k2 <= j 其中 k1 % n == k2 % n 。
%%%%来源：力扣（LeetCode）
%%%%链接：https://leetcode.cn/problems/maximum-sum-circular-subarray
%%% @end
%%% Created : 20. 7月 2023 13:27
%%%-------------------------------------------------------------------
-module(max_subarray_sum_circular).
-author("wangzhao").

%% API
-export([max_subarray_sum_circular/1]).

-spec max_subarray_sum_circular(Nums :: [integer()]) -> integer().
max_subarray_sum_circular(Nums) ->
  [H|_] = Nums,
  loop(Nums, H, H, 0, 0, 0).
loop([H | Next], Max, Min, Sum, MaxCount, MinCount) ->
  if MaxCount =< 0 ->
      Count = H;
    true ->
      Count = MaxCount + H
  end,
  if MinCount >= 0 ->
      Count1 = H;
    true ->
      Count1 = H + MinCount
  end,
    loop(Next, max(Count, Max), min(Count1, Min), Sum + H, Count, Count1);
loop([], Max, Min, Sum, _, _) ->

    if Min == Sum -> Max;
        true -> max(Max, Sum - Min)
    end.