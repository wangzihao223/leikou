-module(number_of_sub).

-export([number_of_substrings/1, run/0]).

run() ->
    ok.

-spec number_of_substrings(S :: unicode:unicode_binary()) -> integer().
number_of_substrings(S) ->
    L = binary_to_list(S),
    N = length(L),
    Nxt = next(lists:reverse(L), [N], N - 1),
    Nxt1 = list_to_tuple(Nxt),
    % Nxt1 = array:from_list(Nxt),
    {_, R} =
        lists:foldl(fun(E, {J, Ans}) ->
                       Cnt0 =
                           if E == 48 ->
                                  1;
                              true ->
                                  0
                           end,
                       {J + 1, f(Cnt0, J, J, N, Nxt1, Ans)}
                    end,
                    {0, 0},
                    L),
    R.

next([48 | Next], Nxt, I) ->
    next(Next, [I | Nxt], I - 1);
next([_ | Next], [N | Nxt1], I) ->
    next(Next, [N, N | Nxt1], I - 1);
next([], Nxt, _I) ->
    Nxt.

f(Cnt0, J, I, N, Nxt, Ans) when J < N, Cnt0 * Cnt0 =< N ->
    J1 = element(J + 2, Nxt),
    % J1 = array:get(J+1, Nxt),
    Cnt1 = J1 - I - Cnt0,
    if Cnt1 >= Cnt0 * Cnt0 ->
           Ans1 = min(J1 - J, Cnt1 - Cnt0 * Cnt0 + 1) + Ans,
           f(Cnt0 + 1, J1, I, N, Nxt, Ans1);
       true ->
           f(Cnt0 + 1, J1, I, N, Nxt, Ans)
    end;
f(_, _, _, _, _, Ans) ->
    Ans.
