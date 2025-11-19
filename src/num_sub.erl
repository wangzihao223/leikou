-module(num_sub).

% 1513 仅含 1 的子串数

num_sub(S) ->
    R = lists:foldl(fun(T, Acc) -> 
                    % n × (n + 1) ÷ 2
                    Acc + (T * (T+1) div 2)
        end, 0, find_1_str(binary_to_list(S), 0, [])),
    R rem (1000_000_000+ 7).

find_1_str([49 | Next], Count, L) ->
    find_1_str(Next, Count+1, L);
find_1_str([_|Next], Count, L) ->
    if Count == 0 ->
        find_1_str(Next, 0, L);
    true ->
        find_1_str(Next, 0, [Count|L])
    end;
find_1_str([], 0, L) -> L;
find_1_str([], Count, L) -> [Count|L].