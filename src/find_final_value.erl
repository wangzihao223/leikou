-module(find_final_value).

-spec find_final_value(Nums :: [integer()], Original :: integer()) -> integer().
find_final_value(Nums, Original) ->
    find(lists:sort(Nums), Original).

find([Original | Next], Original) ->
    find(Next, Original * 2);
find([_N | Next], Original) ->
    find(Next, Original);
find([], Original) ->
    Original.
