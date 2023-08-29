% 全排列
% 

-module(permute).

-export([permute/1]).
 
permute(Nums) ->
    select(Nums, [], [], length(Nums), []).


select([N | Next], Remain, Row, L, R) ->
    Next1 = merge_list(Next, Remain),
    % io:format("Next1 ~p N ~p  ~n", [Next1, N]),
    R1 = select(Next1, [], [N | Row], L, R),
    select(Next,  [N | Remain], Row, L, R1);
select([],  _Remain, Row, L, R) -> 
    io:format("row ~p~n", [Row]),
    if length(Row) == L -> [Row | R];
        true -> R
    end.

%     R1 = select(S, [], ),
%     select(Next, R)

merge_list(L1, L2) ->
    if length(L1) > length(L2) -> merge1(L2, L1);
        true -> merge1(L1, L2)
    end.

merge1([N | Next], L2) -> merge1(Next, [N | L2]);
merge1([], L2) -> L2.



-spec permute(Nums :: [integer()]) -> [[integer()]].
permute(Nums) ->
  perms(Nums).

perms([]) -> [[]];
perms(L) -> 
    A = [[H | T] || H <- L, T <- perms(L -- [H])],
    io:format("A is ~p  L ~p    ~n", [A, L]),
    A.