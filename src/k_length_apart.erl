-module(k_length_apart).


-spec k_length_apart(Nums :: [integer()], K :: integer()) -> boolean().


k_length_apart(Nums, K) ->
    loop(find_1(Nums), K, 0, 1).

loop([1 | Next], K, I1, I2) -> 
    if I2 - I1 < K -> 
        false;
      true -> loop(Next, K, I2, I2+1)
    end;    
loop([0 | Next], K, I1, I2) ->
    loop(Next, K, I1, I2+1);
loop([], _, _, _) -> true.


find_1([1|Next]) -> Next;
find_1([_|Next]) -> find_1(Next);
find_1([]) -> [].