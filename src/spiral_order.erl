-module(spiral_order).

-export([spiral_order/1]).

% 螺旋矩阵
-spec spiral_order(Matrix :: [[integer()]]) -> [integer()].
spiral_order(Matrix) ->
    M = length(Matrix),
    [H | _] = Matrix,
    N = length(H),
    Array = to_array(Matrix, []),
    Res = circle(0, 0, 0, N - 1, 0, M - 1, Array, [], 0),
    lists:reverse(Res).

to_array([Row | Next], Res) ->
    R1 = array:from_list(Row),
    to_array(Next, [R1 | Res]);
to_array([], Res) ->
    array:from_list(
        lists:reverse(Res)).

circle(X, Y, XL, XR, YU, YD, Array, Res, State) ->
    case State of
        0 ->
            case state_0(X, Y, XR, Array, Res) of
                {_X1, Res} ->
                    Res;
                {X1, Res1} ->
                    circle(X1, Y + 1, XL, XR, YU, YD, Array, Res1, 1)
            end;
        1 ->
            case state_1(X, Y, YD, Array, Res) of
                {_Y1, Res} ->
                    Res;
                {Y1, Res1} ->
                    circle(X - 1, Y1, XL, XR, YU, YD, Array, Res1, 2)
            end;
        2 ->
            case state_2(X, Y, XL, Array, Res) of
                {_X1, Res} ->
                    Res;
                {X1, Res1} ->
                    circle(X1, Y - 1, XL, XR, YU, YD, Array, Res1, 3)
            end;
        3 ->
            case state_3(X, Y, YU, Array, Res) of
                {_Y1, Res} ->
                    Res;
                {Y1, Res1} ->
                    io:format("circle ~p  Y1 ~p ~n", [Res1, Y1]),

                    if XL + 1 =< XR - 1, YU - 1 =< YD + 1 ->
                           io:format("size XL ~p, XR ~p YU ~p YD ~p ~n", [XL, XR, YU, YD]),
                           circle(X + 1, Y1, XL + 1, XR - 1, YU + 1, YD - 1, Array, Res1, 0);
                       true ->
                           Res1
                    end
            end
    end.

state_0(X, Y, XR, Array, Res) when X =< XR ->
    V = array:get(X, array:get(Y, Array)),
    io:format("V ~p ~n", [V]),
    state_0(X + 1, Y, XR, Array, [V | Res]);
state_0(X, _Y, _XR, _Array, Res) ->
    {X - 1, Res}.

state_1(X, Y, YD, Array, Res) when Y =< YD ->
    V = array:get(X, array:get(Y, Array)),
    io:format("V1 ~p YD ~p ~n", [V, YD]),
    state_1(X, Y + 1, YD, Array, [V | Res]);
state_1(_X, Y, _XR, _Array, Res) ->
    {Y - 1, Res}.

state_2(X, Y, XL, Array, Res) when X >= XL ->
    V = array:get(X, array:get(Y, Array)),
    io:format("V ~p ~n", [V]),
    state_2(X - 1, Y, XL, Array, [V | Res]);
state_2(X, _Y, _XL, _Array, Res) ->
    {X + 1, Res}.

state_3(X, Y, YU, Array, Res) when Y > YU ->
    V = array:get(X, array:get(Y, Array)),
    io:format("V ~p ~n", [V]),
    state_3(X, Y - 1, YU, Array, [V | Res]);
state_3(_X, Y, _YU, _Array, Res) ->
    {Y + 1, Res}.
