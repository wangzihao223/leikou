%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 03. 8月 2023 17:32
%%%-------------------------------------------------------------------
-module(find_anagrams).
-author("wangzihao").

% 438. 找到字符串中所有字母异位词

%% API
-export([find_anagrams/2]).

find_anagrams(S, P) ->
  SL = binary_to_list(S),
  PL = binary_to_list(P),
  SourceSet = sets:from_list(PL, [{version, 2}]),
  move(queue:new(), SL, SourceSet, sets:new([{version, 2}]), [], 0).


move(Win, [Letter | NextLetter], SourceSet, Set, Res, I) ->

  case sets:is_element(Letter, SourceSet) of
    true ->
      case sets:is_element(Letter, Set) of
        true ->
          {Win1, Set1} = resize_window(Win, Letter, Set, I),
          if SourceSet == Set ->
              {_, Index} =  queue:head(Win),
              io:format("Index is ~p I is ~p ~n", [Index, I]),
              move(Win1, NextLetter, SourceSet, Set1, [Index | Res], I + 1);
            true ->
              move(Win1, NextLetter, SourceSet, Set1, Res, I + 1)
          end;
        false ->
          move(queue:in({Letter, I}, Win), NextLetter, SourceSet, sets:add_element(Letter, Set), Res, I + 1)
      end;
    false ->
      if SourceSet == Set ->
          {_, Index} =  queue:head(Win),
          io:format("Index is ~p ~n", [Index]),
          move(queue:new(), NextLetter, SourceSet, sets:new([{version, 2}]), [Index | Res], I + 1);
        true->
          move(queue:new(), NextLetter, SourceSet, sets:new([{version, 2}]), Res, I + 1)
      end
  end;
move(Win, [], SourceRes, SourceRes, Res, _) ->
  {_, Index} =  queue:head(Win),
  [Index | Res];
move(_, [], _, _, Res, _) -> Res.

resize_window(Win, Letter, Set, Index) ->
  case sets:is_element(Letter, Set) of
    true ->
        {{value, {V, I}}, Win1} = queue:out(Win),
        io:format("out ~p ~n", [I]),
        Set1 = sets:del_element(V, Set),
        resize_window(Win1, Letter, Set1, Index);
    false ->
      {queue:in({Letter, Index}, Win), sets:add_element(Letter, Set)}
  end.