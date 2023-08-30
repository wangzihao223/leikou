-module(final_string).
-export([final_string/1]).
% 故障键盘
final_string(S) ->
    L = binary:bin_to_list(S),
    list_to_binary(lists:reverse(loop(L, []))).

loop([L | Next], Res) when L == 105->
    loop(Next, lists:reverse(Res));
loop([L | Next], Res) -> loop(Next, [L | Res]);
loop([], Res) -> Res.