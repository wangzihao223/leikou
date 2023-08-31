-module(minimum_jump).
 
%  到家的最小跳跃次数
-export([minimum_jumps/4]).
-spec minimum_jumps(Forbidden :: [integer()], A :: integer(), B :: integer(), X :: integer()) -> integer().
minimum_jumps(_, _, _, 0) -> 0;
minimum_jumps(Forbidden, A, B, X) ->
    jump(queue:from_list([{0, -1, 0}]), sets:from_list(Forbidden, [{version, 2}]),sets:add_element({0, 1}, sets:new([{version, 2}])), max(lists:max(Forbidden) + A + B, X + B), {A, B}, X).

jump(Q, Forbidden, Trodden, Max, AB, X) ->
    case queue:is_empty(Q) of
        true -> -1;
        false -> jump1(Q, Forbidden, Trodden, Max, AB, X)
    end.

jump1(Q, Forbidden, Trodden, Max, {A,B}, X) ->
    case queue:out(Q) of
        {{_, {Now, -1, Res}}, Q2} ->  
            operation([{A, 1}], Q2, Now, Forbidden, Trodden, Max, X, Res, {A, B});
        {{_, {Now, 1, Res}}, Q2} ->
            operation([{A, 1}, {B, -1}], Q2, Now, Forbidden, Trodden, Max, X, Res, {A, B})
    end.

operation([{D, Dis}| Next], Q, Now, Forbidden, Trodden, Max, X, Res, AB) ->
    case  walk(Q, Now, Forbidden, D, Dis, Trodden, Max, X, Res) of
        {ok, Res1} -> Res1;
        {Trodden1, Q1} -> operation(Next, Q1, Now, Forbidden, Trodden1, Max, X, Res, AB)
    end;
operation([], Q, _Now, Forbidden, Trodden, Max, X, _Res, AB) ->
    jump(Q, Forbidden, Trodden, Max, AB, X).


walk(Q, Now, Forbidden, D, Dis, Trodden, Max, X, Res) ->
    E = Now + Dis * D,
    if E == X -> {ok, Res + 1};
    true ->
        case (not sets:is_element(E, Forbidden)) and (not sets:is_element({E, Dis}, Trodden)) and ((E >= 0) and (E =< Max)) of
            true ->  {sets:add_element({E, Dis}, Trodden), queue:in({E, Dis, Res + 1}, Q)};
            false -> {sets:add_element({E, Dis}, Trodden), Q}
        end
    end.


% front(Q, Forbidden, D, Count, Max) ->
    % Q + D 


