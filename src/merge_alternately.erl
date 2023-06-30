-module(merge_alternately).

-export([main/2]).

% 交替合并字符串
% W1  unicode binary W2 unicode binary
main(W1, W2) ->
    W3 = binary:bin_to_list(W1),
    W4 = binary:bin_to_list(W2),
    W5 = loop(W3, W4, []),
    unicode:characters_to_binary(W5).

loop([], [W2 | Next2], R) ->
    lists:reverse(R, [W2 | Next2]);
loop([W1 | Next1], [], R) ->
    lists:reverse(R, [W1 | Next1]);
loop([], [], R) ->
    lists:reverse(R);
loop([W1 | Next1], [W2 | Next2], R) ->
    loop(Next1, Next2, [W2, W1 | R]).
