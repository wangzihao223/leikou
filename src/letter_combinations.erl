-module(letter_combinations).

% 电话号码的字母组合
-export([letter_combinations/1]).

letter_combinations(Dig) ->
    Map = #{50 => "abc",
            51 => "def",
            52 => "ghi",
            53 => "jkl",
            54 => "mno",
            55 => "pqrs",
            56 => "tuv",
            57 => "wxyz"},
    List = binary_to_list(Dig),
    L = maped(List, Map, []),
    to_binary(select(L, [], length(L), []), []).

to_binary([L | Next], R) ->
    to_binary(Next, [list_to_binary(L) | R]);
to_binary([], R) ->
    R.

maped([L | Next], Map, Res) ->
    maped(Next, Map, [maps:get(L, Map) | Res]);
maped([], _, Res) ->
    Res.

select([[] | Next], R, Len, Res) ->
    select(Next, R, Len, Res);
select([[L | NextL] | Next], R, Len, Res) ->
    Res1 = select(Next, [L | R], Len, Res),
    select([NextL | Next], R, Len, Res1);
select([], R, Len, Res) when length(R) == Len ->
    [R | Res];
select([], _, _, Res) ->
    Res.% select([[]], R) ->
        %     io:format("R2 ~p ~n", [R]).
