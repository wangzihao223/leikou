-module(genrate_parenthesis).

-export([generate_parenthesis/1]).
% 括号生成
-spec generate_parenthesis(N :: integer()) -> [unicode:unicode_binary()].
generate_parenthesis(N) ->
    back_track(N, [], 0, 0, []).


back_track(N, S, Left, Right, Res) ->
    f1(N, S, Left, Right, Res).


f1(N, S, Left, Right, Res) ->
    Len = length(S),
    if Len == 2 * N -> 
        to_binary(S, Res);
        true -> 
            Res1 = f2(N, S, Left, Right, Res),
            f3(N, S, Left, Right, Res1)
    end.

f2(N, S, Left, Right, Res) ->
    if Left < N  ->
        S1 = ["(" | S],
        back_track(N, S1, Left + 1, Right, Res);
    true -> Res
    end.
            
f3(N, S, Left, Right, Res) ->
    if Left > Right ->
        S1 = [")" | S],
        back_track(N, S1, Left, Right + 1, Res);
    true -> Res 
    end.

to_binary(S, Res) ->
    [list_to_binary(lists:reverse(S)) | Res].
         