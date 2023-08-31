-module(bench_mark).

-export([test/0]).
make_list(L, R) when L > 0 ->
    make_list(L - 1, [L | R]);
make_list(0, R) -> R.



test() ->
    % 0 - 1000000
    A = array:new([{default, 1000000}]),
    B = make_list(1000_000, []),
    S1 = erlang:system_time(microsecond),
    travelse2(B),
    S2 = erlang:system_time(microsecond),
    io:format("list ~p ~n", [S2  - S1]),
    S3 = erlang:system_time(microsecond),
    traverse1(1000000, A), 
    S4 = erlang:system_time(microsecond),
    io:format("array ~p ~n", [S4  - S3]).

traverse1(L, Array) when L > 0->
    array:get(L, Array),
    traverse1(L - 1, Array);
traverse1(0, _Array)->ok.

travelse2([_N | Next]) ->
    travelse2(Next);
travelse2([]) -> ok.



% main(N) -> 
%     test(N),
%     test_array(N).

% test(N) ->
%     S1 = erlang:system_time(microsecond),
%     test1(N, lists:seq(1, 10000)),
%     S2 = erlang:system_time(microsecond),
%     io:format("list bad ~p ~n", [S2 - S1]).

% test_array(N) ->
%     S1 = erlang:system_time(microsecond),
%     test2(N, array:from_list(lists:seq(1, 10000)), 9999),
%     S2 = erlang:system_time(microsecond),
%     io:format("array bad ~p ~n", [S2 - S1]).


% test1(0, _) ->  ok;
% test1(N, List) ->
%     % lists:seq(1, Size)
%     loop(List),
%     test1(N - 1, List).

% test2(0, _, _) -> ok;
% test2(N, Array, I) -> 
%     search(Array, I),
%     test2(N - 1, Array, I).

% search(Array, I) ->
%     array:get(I, Array).

% loop([_L | Next]) -> loop(Next);
% loop([]) -> ok.