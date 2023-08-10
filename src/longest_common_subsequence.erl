%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. 8月 2023 13:18
%%%-------------------------------------------------------------------
-module(longest_common_subsequence).
-author("16009").
% 最长公共子序列

%% API
-export([longest_common_subsequence/2]).

longest_common_subsequence(Text1, Text2) ->
  Size = byte_size(Text2) - 2,
  <<First:8, NextText2:Size/binary, End:8>>  = Text2,
  case find_first(First, Text1, 0) of
    0 -> 0;
    {FirstIndex, NextText1, Index1}->
      case find_letters(NextText2, NextText1, Index1) of
        0 -> 0;
        {NextText1_1, Index2} ->
          io:format("Index2, ~p ~n", [Index2]),
          case find_end(End, NextText1_1,  Index2, null) of
            null -> 0;
            EndIndex ->
              io:format("start ~p end ~p ~n", [FirstIndex, EndIndex]),
              EndIndex - FirstIndex + 1
          end
      end
  end.

find_letters(<<L:8, Next/binary>>, <<Text:8, NextText/binary>>, TextIndex) when L == Text ->
  find_letters(Next, NextText, TextIndex + 1);
find_letters(<<L:8, Next/binary>>, <<_Text:8, NextText/binary>>, TextIndex) ->
  find_letters(<<L:8, Next/binary>>, NextText, TextIndex + 1);
find_letters(_, <<>>, _) -> 0;
find_letters(<<>>, Remain, TextIndex) -> {Remain, TextIndex}.

find_end(Letter, <<L:8, Next/binary>>, Index, _MaxIndex) when L == Letter ->
  find_end(Letter, Next, Index + 1, Index);
find_end(Letter, <<_:8, Next/binary>>, Index, MaxIndex) ->
  find_end(Letter, Next, Index + 1, MaxIndex);
find_end(_, <<>>, _, MaxIndex) -> MaxIndex.

find_first(Letter, <<L:8, Next/binary>>, Index) when Letter == L -> {Index, Next, Index + 1};
find_first(Letter, <<L:8, Next/binary>>, Index) ->
  find_first(Letter, Next, Index + 1);
find_first(_, <<>>, _) -> 0.
