%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 8月 2023 16:08
%%%-------------------------------------------------------------------
-module(flipgame).
-author("wangzihao").

%% API
-export([flipgame/2]).

-spec flipgame(Fronts :: [integer()], Backs :: [integer()]) -> integer().
flipgame(Fronts, Backs) ->
  Set = to_set(Fronts, Backs, sets:new()),
  Min = find_min(Set, Fronts, Backs, null),
  if Min == null -> 0;
    true-> Min
  end.

to_set([F | NextF], [B | NextB], Set) when F == B ->
  to_set(NextF, NextB, sets:add_element(B, Set));
to_set([_ | NextF], [_ | NextB], Set) ->
  to_set(NextF, NextB, Set);
to_set([], [], Set) -> Set.

find_min(Set, [F | NextF], [B | NextB], Min) when F == B ->
  find_min(Set, NextF, NextB, Min);
find_min(Set, [F | NextF], [B | NextB], Min) ->
  Min1 = min(get_min(F, Set, Min), get_min(B, Set, Min)),
  find_min(Set, NextF, NextB, Min1);
find_min(_, [], [], Min) -> Min.

get_min(F, Set, Min) ->
  case sets:is_element(F, Set) of
    true-> Min;
    false ->
      if Min == null -> F;
        true -> min(F, Min)
      end
  end.
