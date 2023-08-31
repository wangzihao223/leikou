-module(ways_to_buy_pens).
-export([ways_to_buy_pens_pencils/3]).
ways_to_buy_pens_pencils(Total, Cost1, Cost2) when Cost1 >= Cost2->
    N1 = Total div Cost1,
    io:format("N1 is ~p ~n", [N1]),
    buy(0, N1, Total, Cost1, Cost2, 0) + 1;
ways_to_buy_pens_pencils(Total, Cost1, Cost2) ->
    ways_to_buy_pens_pencils(Total, Cost2, Cost1).

buy(N, Max, Total, Cost1, Cost2, Ans) when Max >= N ->
   N1 = (Total -  N * Cost1) div Cost2,
   io:format("N2 is ~p ~n", [N1]),
   buy(N + 1, Max, Total, Cost1, Cost2, Ans + N1+1);
buy(_, _, _, _, _, Ans) -> Ans.
