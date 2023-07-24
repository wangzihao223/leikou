%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. 7月 2023 9:25
%%%-------------------------------------------------------------------
-module(num_jewels_in_stones).
-author("hot").

%% API
-export([num_jewels_in_stones/2]).

num_jewels_in_stones(Jewels, Stones) ->
  Set = sets:from_list(unicode:characters_to_list(Stones)),
  check_stones(Stones, Set, 0).

check_stones([], _, Counter) -> Counter;
check_stones([S | NextS], Set, Counter) ->
  case sets:is_element(S, Set) of
    true -> check_stones(NextS, Set, Counter + 1);
    false -> check_stones(NextS, Set, Counter)
  end.
