%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 8月 2023 17:21
%%%-------------------------------------------------------------------
-module(longest_consecutive).
-author("wangzihao").

%% API
-export([longest_consecutive/1]).
%%-spec longest_consecutive(Nums :: [integer()]) -> integer().
%%longest_consecutive([]) -> 0;
%%longest_consecutive(Nums) ->
%%%%  Set = sets:from_list(Nums),
%%  Map = map(Nums, #{}),
%%  max_length(Nums, Map, 1).
%%
%%max_length([], _, Max) -> Max;
%%max_length([N | NextN], Set, Max) ->
%%  case maps:is_key(N + 1, Set) of
%%    false -> max_length(NextN, Set, max(serial_length(N, Set, 1), Max));
%%    true -> max_length(NextN, Set, Max)
%%  end.
%%
%%serial_length(N, Set, L) ->
%%  case maps:is_key(N - 1, Set) of
%%    true -> serial_length(N - 1, Set, L + 1);
%%    false -> L
%%  end.
%%
%%
%%
%%map([N | NextN], Map) ->
%%  map(NextN, Map#{N => null});
%%map([], Map) -> Map.

-spec longest_consecutive(Nums :: [integer()]) -> integer().
longest_consecutive([]) -> 0;
longest_consecutive(Nums) ->
  create_process_dict(Nums),
  L = max_length(Nums, 1),
  erase(),
  L.

max_length([], Max) -> Max;
max_length([N | NextN], Max) ->
  case get(N + 1) of
    undefined -> max_length(NextN, max(serial_length(N, 1), Max));
    1 -> max_length(NextN, Max)
  end.

serial_length(N, L) ->
  case get(N - 1) of
    1 -> serial_length(N - 1,  L + 1);
    undefined -> L
  end.

create_process_dict([N | NextN]) ->
  put(N, 1),
  create_process_dict(NextN);
create_process_dict([]) -> ok.
