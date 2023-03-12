%%%-------------------------------------------------------------------
%% @doc leikou public API
%% @end
%%%-------------------------------------------------------------------

-module(leikou_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    leikou_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
