-module(word_break).

% 单词拆分
-export([word_break/2]).

word_break(S, WordDictS) ->
    DP = loop(make_set(WordDictS), S, 1, make_dp(byte_size(S) + 1), byte_size(S)),
    array:get(byte_size(S), DP).

make_set(WordDict) ->
    sets:from_list(WordDict).

make_dp(Size) ->
    A = array:new([{size, Size}, {default, false}]),
    array:set(0, true, A).

loop(Set, S, I, DP, Length) when I =< Length ->
    DP1 = pd_func(Set, S, I - 1, I, DP),
    loop(Set, S, I + 1, DP1, Length);
loop(_Set, _S, _I, DP, _Length) ->
    DP.

pd_func(Set, S, L, I, DP) when L >= 0 ->
    S1 = binary:part(S, {L, I - L}),
    io:format("part S1 ~p ~n", [S1]),
    case sets:is_element(S1, Set) of
        true ->
            io:format("L ~p DP ~p ~n ", [L, DP]),
            case array:get(L, DP) of
                true ->
                    array:set(I, true, DP);
                false ->
                    pd_func(Set, S, L - 1, I, DP)
            end;
        false ->
            pd_func(Set, S, L - 1, I, DP)
    end;
pd_func(Set, S, L, I, DP) ->
    array:set(I, false, DP).
