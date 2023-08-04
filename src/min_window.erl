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
-export([min_window/2]).

-spec min_window(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> unicode:unicode_binary().
min_window(S, T) ->
  Map = make_map(T, #{}),
  move_window(<<>>, #{}, Map, S).

make_map(<<L:8, NextL/binary>>, Map) ->
  make_map(NextL, Map#{L => maps:get(L, Map, 0) + 1});
make_map(<<>>, Map) -> Map.

move_window(<<>>, WinMap, Map, <<L:8, NextL/binary>>, MinLength) ->
  case maps:is_key(L, Map) of
    false -> move_window(<<>>, #{}, Map, NextL, MinLength);
    true ->
      check_and_move(Map, #{L => 1}, <<L:8>>, MinLength, Next)
  end;
move_window(Window, WinMap, Map, <<L:8, NextL/binary>>, MinLength) ->
  case maps:is_key(L, Map) of
    false -> move_window(<<Window/binary, L:8>>, WinMap, Map, NextL, MinLength);
    true ->
      case check_letter_num(Map, WinMap, L) of
        true ->
          % 检查是否hege
          move_window(<<Window/binary, L:8>>, WinMap#{L => maps:get(L, WinMap) + 1}, Map, NextL, MinLength);
        false ->
          {Win1, Count} = resize_window(L, Window, 0),
          
      end

      check_and_move(Map, #{L => 1}, <<L:8>>, MinLength, Next)
  end;
% move_window(Window, _, _, <<>>) -> Window.

check_letter_num(Map, WinMap, L) ->
  #{L := C} = Map,
  case maps:is_key(L, WinMap) of
    true ->
      C1 = map_get(L, WinMap),
      if C1 < C -> true;
        true -> false
      end;
    false -> true
  end.

resize_window(Letter, <<L:8, Next/binary>>, Count) when Letter =/= L->
  resize_window(Letter, Next, Count + 1);
resize_window(Letter, <<L:8, Next/binary>>, Count) -> {Next, Count + 1};
resize_window(Letter, <<>>, Count) -> {<<>>, Count}.


% clear_window(<<H:8, Next/binary>>, Map, Count) ->
%   case maps:is_key(H, Map) of
%     false -> clear_window(Next, Map, Count + 1);
%     true -> {<<H:8, Next/binary>>, Count}
%   end;
% clear_window(<<>>, _, Count) -> {<<>>, Count}.

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

check_and_move(Map, WinMap, Window, MinLength, Next) ->
  case equal(maps:iterator(Map), WinMap) of
    true -> 
      if MinLength == none ->Min1 = byte_size(Window);
        true-> Min1 = min(byte_size(Window), MinLength)
      end,
      move_window(Window, WinMap, Map, Next, Min1);
    false ->  move_window(Window, WinMap, Map, Next, MinLength)
  end.

% check_and_move(Map, WinMap, Win, NextL, Length, MinLength) ->
%   case equal(maps:iterator(Map), WinMap)of
%     true -> 
%       min(Length, MinLength),
%       move_window(Win, WinMap, Map, NextL, Length, min(Length, MinLength));
%     false ->
%       move_window(Win, WinMap, Map, NextL, Length, MinLength)
%   end.