-module(max_distinct_elements).

-export([max_distinct_elements/2]).

-spec max_distinct_elements(Nums :: [integer()], K :: integer()) ->
                               integer().% max_distinct_elements(Nums, K) ->
                                         %     Table =
                                         %         lists:foldl(fun(E, Acc) ->
                                         %                        V = maps:get(E, Acc, 0),
                                         %                        Acc#{E => V + 1}
                                         %                     end,
                                         %                     #{},
                                         %                     Nums),
                                         %     L0 = maps:fold(fun(K0, _, Acc) -> [K0 | Acc] end, [], Table),
                                         %     L1 = lists:sort(L0),
                                         %     {_, Res} =
                                         %         lists:foldl(fun(A, {Right, Acc}) ->
                                         %                        N = maps:get(A, Table),
                                         %                        {Acc0, Right1} = range(N, A, K, Right),
                                         %                        {Right1 + 1, Acc0 + Acc}
                                         %                     end,
                                         %                     {-1000000000, 0},
                                         %                     L1),
                                         %     Res.
% range(N, A, K, Right) ->
%     L = A - K,
%     R = A + K,
%     L1 = max(Right, L),
%     R1 = min(R, L1 + N - 1),
%     {R1 - L1 + 1, R1}.
max_distinct_elements(Nums, K) ->
    Nums0 = lists:sort(Nums),
    {_, Res} =
        lists:foldl(fun(A, {R0, Acc}) ->
                       Left = max(R0 + 1, A - K),
                       Right = min(A + K, Left),
                       if Left > Right ->
                              {R0, Acc};
                          true ->
                              {Right, Acc + 1}
                       end
                    end,
                    {-1000000000, 0},
                    Nums0),
    Res.
