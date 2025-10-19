-module(combination_sum).

% 组合总和
-export([combination_sum/2]).

combination_sum(Candiates, Target) ->
    Candiates1 = lists:sort(Candiates),
    dfs(Target, Candiates1, Candiates1, [], []).

dfs(Root, [C | Next], Candiates, Path, R) when Root - C > 0 ->
    R1 = dfs(Root - C, Candiates, Candiates, [C | Path], R),
    dfs(Root, Next, Next, Path, R1);
dfs(Root, [C | _], _, Path, R) when Root - C == 0 ->
    [[C | Path] | R];
dfs(_, _, _, _, R) ->
    R.
