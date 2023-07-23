% 给定一个非负整数数组 nums ，你最初位于数组的 第一个下标 。

% 数组中的每个元素代表你在该位置可以跳跃的最大长度。

% 判断你是否能够到达最后一个下标。

-module(can_jump).
% -export([yield_path/4]).
-export([can_jump/1]).

-spec can_jump(Nums :: [integer()]) -> boolean().
can_jump([_]) -> true;
can_jump(Nums) ->
    sim_step(Nums, 0, 0).

sim_step([], _, _) -> true;
sim_step([N | NextN], Index, Max) ->
    if N == 0 ->
            if Max > Index ->
                    sim_step(NextN, Index + 1, Max);
                Max == Index, NextN == [] ->
                % 特殊条件： 最后一个 且 max == index
                    true;
                true -> 
                    false
            end;
        true ->
            sim_step(NextN, Index + 1, max(Max, Index + N))
    end.
