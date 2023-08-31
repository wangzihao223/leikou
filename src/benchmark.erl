-module(benchmark).

-export([dmt/2]).
-export([dict_get/3]).
-export([maps_get/3]).
-export([array_get/3]).
-export([array_store/3]).
-export([dict_store/3]).
-export([maps_store/3]).


dmt(Size, N) ->
    {TD, D} = timer:tc(dict, from_list, [[{{dict, I}, I} || I <- lists:seq(1, Size)]]),
    {TM, M} = timer:tc(maps, from_list, [[{{maps, I}, I} || I <- lists:seq(1, Size)]]),
    {TA, _A} = timer:tc(array, from_list, [lists:seq(1, Size)]),
    {TA2, A2} = timer:tc(?MODULE, array_store, [N, Size, array:new()]),
    {TD1, _} = timer:tc(?MODULE, dict_get, [N, Size, D]),
    {TM1, _} = timer:tc(?MODULE, maps_get, [N, Size, M]),
    {TA1, _} = timer:tc(?MODULE, array_get, [N, Size, A2]),
    {TD2, _} = timer:tc(?MODULE, dict_store, [N, Size, dict:new()]),
    {TM2, _} = timer:tc(?MODULE, maps_store, [N, Size, maps:new()]),
    io:format("Size-~p N-~p:init[~p:~p:~p] store[~p:~p:~p] get[~p:~p:~p]", [Size, N, TD, TM, TA, TD2, TM2, TA2, TD1, TM1, TA1]).

dict_get(N, Size, Dict) ->
    dict:find({dict, (N rem Size) bor (2001 bsl 23)}, Dict),
    if  
        N > 0 ->
            dict_get(N - 1, Size, Dict);
        true ->
            ok
    end.


maps_get(N, Size, Map) ->
    maps:find({maps, (N rem Size) bor (2001 bsl 23)}, Map),
    if  
        N > 0 ->
            maps_get(N - 1, Size, Map);
        true ->
            ok
    end.

dict_store(N, Size, Dict) ->
    K = (N rem Size) bor (2001 bsl 23),
    Dict1 = dict:store({dict, K}, K, Dict),
    if  
        N > 0 ->
            dict_store(N - 1, Size, Dict1);
        true ->
            Dict1
    end.


maps_store(N, Size, Map) ->
    K = (N rem Size) bor (2001 bsl 23),
    Map1 = maps:put({maps, K}, K, Map),
    if  
        N > 0 ->
            maps_store(N - 1, Size, Map1);
        true ->
            Map1
    end.

array_get(N, Size, Array) ->
    catch array:get((N rem Size) bor (2001 bsl 23), Array),
    if 
        N > 0 ->
            array_get(N - 1, Size, Array);
        true ->
            ok
    end.

array_store(N, Size, Array) ->
    K = (N rem Size) bor (2001 bsl 23),
    Array1 = array:set(K, N, Array),
    if 
        N > 0 ->
            array_store(N - 1, Size, Array1);
        true ->
            Array1
    end.