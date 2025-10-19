-module(search_matrix).

% 搜索二维矩阵
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
    M = lists_to_array(Matrix, []),
    {X, Y} = get_matrix_size(M),
    binary_search(M, 0, X * Y - 1, (X * Y - 1) div 2, Target, {X, Y}).

lists_to_array([L | Next], Res) ->
    lists_to_array(Next, [array:from_list(L) | Res]);
lists_to_array([], Res) ->
    array:from_list(
        lists:reverse(Res)).

binary_search(Matrix, L, R, K, Target, Size) when R >= L ->
    {M, N} = index_to_mn(K, Size),
    V = get_num_from_matrix(M, N, Matrix),
    if V == Target ->
           true;
       V > Target ->
           K1 = (K - 1 + L) div 2,
           binary_search(Matrix, L, K - 1, K1, Target, Size);
       true ->
           K1 = (K + 1 + R) div 2,
           binary_search(Matrix, K + 1, R, K1, Target, Size)
    end;
binary_search(_, _, _, _, _, _) ->
    false.

index_to_mn(Index, {_M, N}) ->
    X = Index div N,
    Y = Index rem N,
    {X, Y}.

get_num_from_matrix(M, N, Martix) ->
    array:get(N, array:get(M, Martix)).

get_matrix_size(Martix) ->
    {array:size(Martix),
     array:size(
         array:get(0, Martix))}.
