-module(jumpy).

-export([jump/1]).

% 跳跃游戏2

jump(Nums) ->
    jump1(Nums, 0, 0, length(Nums), 0, 0).

jump1([V | Next], I, End, Length, Max, C) when I < Length - 1, End < Length - 1 ->
    Max1 = max(V + I, Max),
    if I == End ->
           jump1(Next, I + 1, Max1, Length, Max1, C + 1);
       true ->
           jump1(Next, I + 1, End, Length, max(V + I, Max), C)
    end;
jump1(_, _, _, _, _, C) ->
    C.
