-module(len_of_lis).

-export([length_of_lis/1]).

% 最长递增子序列
%
% 
length_of_lis([_]) -> 1;
length_of_lis([V | Nums]) ->
    loop([V | Nums], Nums, make_dp(length([V | Nums])), 1).


make_dp(Size) ->
    array:new([{size, Size}, {default, 1}]).

loop(Nums, [N | Next], Dp, I) ->
    Nums1 = lists:sublist(Nums, I),
    DpI = array:get(I, Dp),
    V = dp_func(Dp, Nums1, 0, I, N, DpI),
    io:format("I, V, ~p ~p ~n", [I, V]),
    Dp1 = array:set(I, V, Dp),
    loop(Nums, Next, Dp1, I + 1);
loop(_Nums, [], Dp, _I) ->
    io:format("Format ~n"),
    % lists:max(array:to_list(Dp)dd)
    lists:max(array:to_list(Dp)).

dp_func(Dp, [N | Next], J, Length, Num, DpI) when Num > N -> 
    N1 = array:get(J, Dp),
    io:format("N1 ~p DpI ~p J ~p ~p num ~p ~n", [N1, DpI, J, Length, Num]),
    dp_func(Dp, Next, J + 1, Length, Num, max(DpI, N1 + 1));
dp_func(Dp, [_ | Next], J, Length, Num, DpI) -> 
    dp_func(Dp, Next, J + 1, Length, Num, DpI);
dp_func(_Dp, [], _J, _Length, _Num, DpI) -> DpI.


    % def lengthOfLIS(self, nums: List[int]) -> int:

    %     if not nums: return 0

    %     dp = [1] * len(nums)

    %     for i in range(len(nums)):

    %         for j in range(i):

    %             if nums[j] < nums[i]: # 如果要求非严格递增，将此行 '<' 改为 '<=' 即可。

    %                 dp[i] = max(dp[i], dp[j] + 1)

    %     return max(dp)
    % 