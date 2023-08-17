% 字符串解码
% 
% 
-module(string_decode).
-export([decode_string/1]).

decode_string(S) -> 
    StringList = deocde_one(S, []),
    merge_str(StringList, []).

merge_str([Str | NextStr], Res) ->

    Res1 = merge_str1(Str, Res),
    merge_str(NextStr, Res1);
merge_str([], Res) -> list_to_binary(Res).
   

merge_str1([S | Next], Res) ->
    merge_str1(Next, [S | Res]);
merge_str1([], Res) -> Res.


deocde_one(<<Number:8, 91:8, Next/binary>>, Res) when Number > 47, Number < 58 ->
    {Next1, Stack} = get_str(Next, []),
    Count = Number - 48,
    Str = copy_str(Count, Stack, [], Stack),
    deocde_one(Next1, [Str | Res]);
deocde_one(<<>>, Res) -> Res;
deocde_one(Next, Res) ->
    {Next1, Stack} = read_letter(Next, []),
    deocde_one(Next1, [Stack | Res]).

read_letter(<<W:8, Next/binary>>, Stack) when W =< 47, W >= 58->
    read_letter(Next, [W | Stack]);
% read_letter(<<>>, Stack) -> {<<>>, Stack},
read_letter(Bin, Stack) -> {Bin, Stack}.

get_str(<<W:8, Next/binary>>, Stack) when W =/= 93->
    get_str(Next, [W | Stack]);
get_str(<<_:8, Next/binary>>, Stack) -> {Next, Stack}.

copy_str(Count, [W | Next], Res, Source) when Count > 0->
   copy_str(Count, Next, [W | Res], Source);
copy_str(Count, [], Res, Source) when Count > 0 -> 
    copy_str(Count - 1, Source, Res, Source);
copy_str(Count, _, Res, _Source) when Count =< 0 ->
    Res.
    