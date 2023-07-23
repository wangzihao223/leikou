-module(atoi).


% 读入字符串并丢弃无用的前导空格
% 检查下一个字符（假设还未到字符末尾）为正还是负号，读取该字符（如果有）。 确定最终结果是负数还是正数。 如果两者都不存在，则假定结果为正。
% 读入下一个字符，直到到达下一个非数字字符或到达输入的结尾。字符串的其余部分将被忽略。
% 将前面步骤读入的这些数字转换为整数（即，"123" -> 123， "0032" -> 32）。如果没有读入数字，则整数为 0 。必要时更改符号（从步骤 2 开始）。
% 如果整数数超过 32 位有符号整数范围 [−231,  231 − 1] ，需要截断这个整数，使其保持在这个范围内。具体来说，小于 −231 的整数应该被固定为 −231 ，大于 231 − 1 的整数应该被固定为 231 − 1 。
% 返回整数作为最终结果。
-export([my_atoi/1]).


-spec my_atoi(S :: unicode:unicode_binary()) -> integer().
my_atoi(S) ->
    {NextS, Symbol} = loop(S, 1),
    NewS = drop_zero(NextS),
    L = find_num(NewS, [], 0),
io:format("L is ~p ~n", [L]),
    NoSymbolN = to_int(L, 1, 0),
    to_result(NoSymbolN, Symbol).


loop(<<32:8, NextS/binary>>, Symbol) ->
    loop(NextS, Symbol);
loop(<<43:8, NextS/binary>>, _Symbol) ->
    {NextS, 1};
loop(<<45:8, NextS/binary>>, _Symbol) ->
    {NextS, -1};
loop(<<Byte:8, NextS/binary>>, Symbol) when Byte > 47, Byte < 58->
    {<<Byte:8, NextS/binary>>, Symbol};
loop(<<_Byte:8, _NextS/binary>>, Symbol) ->
    {<<>>, Symbol};
loop(<<>>, Symbol) -> {<<>>, Symbol}.


drop_zero(<<48:8, NextS/binary>>) ->
    drop_zero(NextS);
drop_zero(S) -> S.


find_num(<<Byte:8, NextS/binary>>, List, I) when Byte > 47, Byte < 58 , I < 11->
    find_num(NextS, [Byte - 48 | List], I + 1);
find_num(_, List, _) ->
    List.


to_int([N | NextN], Mult, R) ->
    to_int(NextN, Mult * 10, R + N * Mult);
to_int([], _Mult, R) -> 
    io:format("Int ~p ~n", [R]),
    R.

to_result(R, Symbol) when Symbol == -1 ->
    if R > 2147483648 -> -1 * 2147483648;
        true -> R * -1
    end;
to_result(R, Symbol) when Symbol == 1 ->
    if R > 2147483648- 1 -> 2147483648 - 1;
        true -> R
    end.