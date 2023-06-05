-module(best_team).

-export([test_func/0]).
-spec best_team_score(Scores :: [integer()], Ages :: [integer()]) -> integer().
best_team_score(Scores, Ages) ->
    NewAges = lists:sort(Ages),
    save_dict(Scores, Ages),
    put(-1, -1),
    best_team_score(NewAges, 0, -1).


best_team_score([], Num, _) ->
    Num;
best_team_score(Ages, Num, LastAge) ->
    [Age | NextAges] = Ages,
    Score = get(Age),
    io:format("Age ~p, Score ~p ~n", [Age, Score]),
    if LastAge == Age ->
        best_team_score(NextAges, Num, LastAge);
        true ->
            LastScores = get(LastAge),
            if Score > LastScores ->
                NewNum = Num + Score + LastScores,
                io:format("Num  Age ~p Score ~p ~n", [Age, Score]),
                best_team_score(NextAges, NewNum, Age);
                true ->
                    best_team_score(NextAges, Num, LastAge)
            end
    end.
save_dict([], []) -> ok;
save_dict(Scores, Ages) ->
    [Score | NextScores] = Scores,
    [Age | NextAges] = Ages,
    case get(Age) of
        undefined ->
            put(Age, Score);
        R -> put(Age, [Score | R])
    end,
    save_dict(NextScores, NextAges).

test_func() ->
    S = [4, 5, 6, 5],
    A = [2, 1, 2, 1],
    R = best_team_score(S, A),
    io:format("R ~p ~n", [R]).