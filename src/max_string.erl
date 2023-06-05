-module(max_string).
-export([max_rep_opt1/1]).
-export([test/1]).


% 单字符重复子串的最大长度
-spec max_rep_opt1(Text :: unicode:unicode_binary()) -> integer().
max_rep_opt1(Text) ->
    L = unicode:characters_to_list(Text),
    loop1(L),
    R = loop2(L, 0, 0, 0),
    erase(),
    R.

loop1([]) -> ok;
loop1([W|Next]) ->
    case get(W) of
        undefined ->
            put(W, 1);
        D ->
            put(W, D+1)
    end,
    loop1(Next).

big_one(A, B) when A > B -> A;
big_one(_A, B) -> B.

loop2([W, W | Next], StartI, NowI, Big) ->
    loop2([W|Next], StartI, NowI+1, Big);
loop2([W, W2 | Next], StartI, NowI, Big) ->
    Count = get(W),
    Count1 = NowI - StartI + 1,
    io:format("W,~p W2 ~p,  Next ~p  StartI ~p , NowI ~p , Big ~p ~n", [W, W2, Next, StartI, NowI, Big]),
    if ((Count1 == Count) or (Count == Count1+1)) ->
        NewBig = big_one(Count, Big);
        true ->
            if Next /= [] ->

                [NextW| _Next1] = Next,
                if NextW == W ->
                    io:format("hhh~n"),
                    C = next_loop(Next, 0),
                    io:format("C ~p Count~p  Count1 ~p ~n", [C, Count, Count1]),
                    if Count1 + C < Count ->
                        Count2 = Count1 + C + 1;
                        true ->
                            Count2 = Count1 + C
                    end,
                    NewBig = big_one(Count2,Big);
                    true ->
                        NewBig = big_one(Count1+1, Big)
                end;
                true->
                    NewBig = big_one(Count1+1, Big)
            end
    end,
    StartI1 = NowI+1,
    NowI1 = NowI + 1,
    loop2([W2|Next], StartI1, NowI1, NewBig);
loop2([W2], StartI, NowI, Big) ->
    Count1 = NowI - StartI + 1 ,
    Count = get(W2),
    io:format("W2 ~p,  StartI ~p , NowI ~p , Big ~p ~n", [W2, StartI, NowI, Big]),
    if  Count > Count1 ->
        NCount = Count1 + 1;
        true ->
            NCount = Count1
    end,
    big_one(NCount, Big).


next_loop([W, W|Next], Count) ->
    next_loop([W|Next], Count+1);
next_loop([_W, _E| _Next], Count) ->
    Count+1;
next_loop(_R, Count) -> Count+1.


test(T1)->
    T = list_to_binary(T1),
    Res = max_rep_opt1(T),
    io:format("res ~p ~n", [Res]).
