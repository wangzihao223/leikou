%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 8月 2023 15:30
%%%-------------------------------------------------------------------
-module(middle_node).

-author("16009").

%% API
-export([middle_node/1]).

-record(list_node, {val = 0 :: integer(), next = null :: null | #list_node{}}).

-spec middle_node(Head :: #list_node{} | null) -> #list_node{} | null.
middle_node(Head) ->
    #list_node{val = _, next = #list_node{val = _, next = Fast}} = Head,
    loop(Fast, Head).

loop(null, Slow) ->
    Slow;
loop(Fast, Slow) ->
    #list_node{val = _, next = Tmp} = Fast,
    #list_node{val = _, next = NextSlow} = Slow,
    case Tmp of
        null ->
            NextSlow;
        #list_node{val = _, next = NextF} ->
            loop(NextF, NextSlow)
    end.
