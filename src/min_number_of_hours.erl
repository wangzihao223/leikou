-module(min_number_of_hours).
-export([test_func/0]).

% 赢得比赛需要的最少训练时长

-spec min_number_of_hours(InitialEnergy :: integer(), InitialExperience :: integer(), Energy :: [integer()], Experience :: [integer()]) -> integer().
min_number_of_hours(InitialEnergy, InitialExperience, Energy, Experience) ->

    % MinEnergy = get_min_energy(Energy, 0),
    % io:format("need MinEnergy ~p~n", [MinEnergy]),
    % MinExperience = get_min_experience(Experience, 0, 0),
    % io:format("need MinExperience~p~n", [MinExperience]),
    {MinEnergy, MinExperience} = get_min(Energy, Experience, 0, 0, 0),
    T1 = get_extra_time(MinEnergy, InitialEnergy),
    T2 = get_extra_time(MinExperience, InitialExperience),
    T2 + T1.
            


get_min_experience([], Min, _) -> Min;
get_min_experience(InitialExperience, Min, Now) ->
    [E | NewInitialExperience] = InitialExperience,
    % 准备阶段
    if Now =< E ->
        NewMin = Min + E + 1 - Now,
        NewNow = E + E + 1;
        true -> 
            NewNow = Now + E,
            NewMin = Min
    end,
    get_min_experience(NewInitialExperience, NewMin, NewNow).



get_min_energy([], Min) ->
    Min + 1;
get_min_energy(InitialEnergy, Min) ->
    [E | NewInitialEnergy] = InitialEnergy,
    NewMin = E + Min,
    get_min_energy(NewInitialEnergy, NewMin).

get_extra_time(Min, Now) ->
    if Min > Now ->
        Min - Now;
        true ->
            0
    end.

get_min([], [], MinEnergy, _, MinExperience) ->
    {MinEnergy+1, MinExperience};
get_min(Energy, Experience, MinEnergy, Now, MinExperience) ->
    [E | NewExperience] = Experience,
    % 准备阶段
    if Now =< E ->
        NewMin = MinExperience + E + 1 - Now,
        NewNow = E + E + 1;
        true -> 
            NewNow = Now + E,
            NewMin = MinExperience
    end,

    [E1 | NewEnergy] = Energy,
    NewMin1 = E1 + MinEnergy,
    get_min(NewEnergy, NewExperience, NewMin1, NewNow, NewMin).



test_func() ->
    InitialEnergy = 5,
    InitialExperience =  3,
    Energy = [1,4,3,2],
    Experience = [2,6,3,1],
    Res = min_number_of_hours(InitialEnergy, InitialExperience, Energy, Experience),
    io:format("Res ~p~n", [Res]).