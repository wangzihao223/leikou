%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 7月 2023 10:09
%%%-------------------------------------------------------------------
-module(three_sum).

-author("wangzihao").

%% API
-export([three_sum/1]).

%%
%%给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请
%%
%%你返回所有和为 0 且不重复的三元组。
%%
%%注意：答案中不可以包含重复的三元组。

-spec three_sum(Nums :: [integer()]) -> [[integer()]].
three_sum(Nums) ->
    NewNums = lists:sort(Nums),
    %%  RNewNums = lists:reverse(NewNums),
    io:format("L ~p ~n", [NewNums]),
    move_k(NewNums, [], length(NewNums), null).

move_k(_, Res, L, _LastK) when L == 2 ->
    Res;
move_k([K | NextK], Res, Length, LastK) when LastK == K ->
    move_k(NextK, Res, Length - 1, LastK);
move_k([K | NextK], Res, Length, _LastK) ->
    NewRes = double_point(NextK, lists:reverse(NextK), 0, Length - 2, Res, K),
    move_k(NextK, NewRes, Length - 1, K).

double_point([I | NextI], [J | NextJ], IndexI, IndexJ, Res, K) when IndexI < IndexJ ->
    if J + I + K < 0 ->
           {NewI, Ic} = jump_repeat(NextI, I, 0),
           double_point(NewI, [J | NextJ], IndexI + 1 + Ic, IndexJ, Res, K);
       J + I + K > 0 ->
           {NewJ, Jc} = jump_repeat(NextJ, J, 0),
           double_point([I | NextI], NewJ, IndexI, IndexJ - 1 - Jc, Res, K);
       true ->
           NewRes = [[K, I, J] | Res],
           io:format("res ~p ~n", [[K, I, J]]),
           {NewI, Ic} = jump_repeat(NextI, I, 0),
           {NewJ, Jc} = jump_repeat(NextJ, J, 0),
           io:format("NewI ~p, NewJ ~p ~n", [NewI, NewJ]),
           double_point(NewI, NewJ, IndexI + 1 + Ic, IndexJ - 1 - Jc, NewRes, K)
    end;
double_point(_, _, _IndexI, _IndexJ, Res, _) ->
    Res.

jump_repeat([J | NextJ], J, Count) ->
    jump_repeat(NextJ, J, Count + 1);
jump_repeat(R, _, Count) ->
    {R, Count}.

%%双指针法思路： 固定 33 个指针中最左（最小）数字的指针 k，双指针 i，j 分设在数组索引 (k,len(nums))(k,len(nums)) 两端，通过双指针交替向中间移动，记录对于每个固定指针 k 的所有满足 nums[k] + nums[i] + nums[j] == 0 的 i,j 组合：
%%
%%    当 nums[k] > 0 时直接break跳出：因为 nums[j] >= nums[i] >= nums[k] > 0，即 33 个数字都大于 00 ，在此固定指针 k 之后不可能再找到结果了。
%%    当 k > 0且nums[k] == nums[k - 1]时即跳过此元素nums[k]：因为已经将 nums[k - 1] 的所有组合加入到结果中，本次双指针搜索只会得到重复组合。
%%    i，j 分设在数组索引 (k,len(nums))(k,len(nums)) 两端，当i < j时循环计算s = nums[k] + nums[i] + nums[j]，并按照以下规则执行双指针移动：
%%        当s < 0时，i += 1并跳过所有重复的nums[i]；
%%        当s > 0时，j -= 1并跳过所有重复的nums[j]；
%%        当s == 0时，记录组合[k, i, j]至res，执行i += 1和j -= 1并跳过所有重复的nums[i]和nums[j]，防止记录到重复组合。
%%
%%作者：jyd
%%链接：https://leetcode.cn/problems/3sum/solution/3sumpai-xu-shuang-zhi-zhen-yi-dong-by-jyd/
%%来源：力扣（LeetCode）
%%著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
