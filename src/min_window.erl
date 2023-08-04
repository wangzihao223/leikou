%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. 8月 2023 18:49
%%%-------------------------------------------------------------------
-module(min_window).
-author("16009").

%% API
%% 最小覆盖子串
-export([]).

-spec min_window(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> unicode:unicode_binary().
min_window(S, T) ->
  Map = make_map(T, #{}),
  move_window(<<>>, #{}, Map, S).

make_map(<<L:8, NextL/binary>>, Map) ->
  make_map(NextL, Map#{L => maps:get(L, Map, 0) + 1});
make_map(<<>>, Map) -> Map.

move_window(Window, WinMap, Map, <<L:8, NextL/binary>>) ->
  case maps:is_key(L, Map) of
    false -> move_window(<<>>, #{}, Map, NextL);
    true ->
      if Window =/= <<>> ->
          <<Head:8, _/binary>> = Window,
          if Head == L ->
              Win1 = clear_window(Window, Map),
              Win2 = <<Win1/binary, L:8>>,
              check_and_move(Map, WinMap, Win2, NextL);
            true ->
              WinMap1 = WinMap#{L => maps:get(L, WinMap, 0) + 1},
              check_and_move(Map, WinMap1, <<Window/binary, L:8>>, NextL)
          end;
        true ->
          WinMap1 = WinMap#{L => maps:get(L, WinMap, 0) + 1},
          check_and_move(Map, WinMap1, <<L:8>>, NextL)
      end
  end;
move_window(Window, _, _, <<>>) -> Window.

clear_window(<<H:8, Next/binary>>, Map) ->
  case maps:is_key(H, Map) of
    false -> clear_window(Next, Map);
    true -> <<H:8, Next/binary>>
  end;
clear_window(<<>>, _) -> <<>>.

equal(Map, WinMap) ->
  case maps:next(Map) of
    none -> true;
    {K, V, Next} ->
      case maps:is_key(K, WinMap) of
        true ->
          case V == map_get(K, WinMap) of
            true -> equal(Next, WinMap);
            false -> false
          end;
        false -> false
      end
  end.

check_and_move(Map, WinMap, Win, NextL) ->
  case equal(maps:iterator(Map), WinMap)of
    true -> Win;
    false ->
      move_window(Win, WinMap, Map, NextL)
  end.