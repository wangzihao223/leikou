%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 7月 2023 10:01
%%%-------------------------------------------------------------------
-module(four_sum).

-author("wangzihao").

%% API
-export([four_sum/2]).

%%给你一个由 n 个整数组成的数组 nums ，和一个目标值 target 。请你找出并返回满足下述全部条件且不重复的四元组 [nums[a], nums[b], nums[c], nums[d]] （若两个四元组元素一一对应，则认为两个四元组重复）：
%%
%%    0 <= a, b, c, d < n
%%    a、b、c 和 d 互不相同
%%    nums[a] + nums[b] + nums[c] + nums[d] == target
%%
%%你可以按 任意顺序 返回答案 。
%%
%%
%%
%%来源：力扣（LeetCode）
%%链接：https://leetcode.cn/problems/4sum
%%著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
four_sum(Nums, Target) ->
    NewNums = lists:sort(Nums),
    move_k(NewNums, [], length(NewNums), null, Target).

move_k(_, Res, L, _LastK, _) when L < 4 ->
    Res;
move_k([K | NextK], Res, Length, LastK, T) when LastK == K ->
    move_k(NextK, Res, Length - 1, LastK, T);
move_k([K | NextK], Res, Length, _LastK, T) ->
    NewRes = move_z(NextK, Res, Length - 1, null, K, T),
    move_k(NextK, NewRes, Length - 1, K, T).

move_z(_, Res, L, _, _, _) when L < 3 ->
    Res;
move_z([Z | NextZ], Res, Length, LastZ, K, T) when Z == LastZ ->
    move_z(NextZ, Res, Length - 1, LastZ, K, T);
move_z([Z | NextZ], Res, Length, _LastZ, K, T) ->
    NewRes = double_point(NextZ, lists:reverse(NextZ), 0, Length - 2, Res, K, Z, T),
    move_z(NextZ, NewRes, Length - 1, Z, K, T).

double_point([I | NextI], [J | NextJ], IndexI, IndexJ, Res, K, Z, T)
    when IndexI < IndexJ ->
    io:format("I ~p J ~p ~n ", [I, J]),
    if J + I + K + Z < T ->
           {NewI, Ic} = jump_repeat(NextI, I, 0),
           double_point(NewI, [J | NextJ], IndexI + 1 + Ic, IndexJ, Res, K, Z, T);
       J + I + K + Z > T ->
           {NewJ, Jc} = jump_repeat(NextJ, J, 0),
           double_point([I | NextI], NewJ, IndexI, IndexJ - 1 - Jc, Res, K, Z, T);
       true ->
           NewRes = [[K, Z, I, J] | Res],
           {NewI, Ic} = jump_repeat(NextI, I, 0),
           {NewJ, Jc} = jump_repeat(NextJ, J, 0),
           double_point(NewI, NewJ, IndexI + 1 + Ic, IndexJ - 1 - Jc, NewRes, K, Z, T)
    end;
double_point(_, _, _IndexI, _IndexJ, Res, _, _, _) ->
    Res.

jump_repeat([J | NextJ], J, Count) ->
    jump_repeat(NextJ, J, Count + 1);
jump_repeat(R, _, Count) ->
    {R, Count}.
