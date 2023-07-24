%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 7月 2023 13:34
%%%-------------------------------------------------------------------
-module(robot).
-author("wangzihao").
%%机器人在一个无限大小的 XY 网格平面上行走，从点 (0, 0) 处开始出发，面向北方。该机器人可以接收以下三种类型的命令 commands ：
%%
%%    -2 ：向左转 90 度
%%    -1 ：向右转 90 度
%%    1 <= x <= 9 ：向前移动 x 个单位长度
%%
%%在网格上有一些格子被视为障碍物 obstacles 。第 i 个障碍物位于网格点  obstacles[i] = (xi, yi) 。
%%
%%机器人无法走到障碍物上，它将会停留在障碍物的前一个网格方块上，但仍然可以继续尝试进行该路线的其余部分。
%%
%%返回从原点到机器人所有经过的路径点（坐标为整数）的最大欧式距离的平方。（即，如果距离为 5 ，则返回 25 ）
%%
%%
%%注意：
%%
%%    北表示 +Y 方向。
%%    东表示 +X 方向。
%%    南表示 -Y 方向。
%%    西表示 -X 方向。
%%
%%来源：力扣（LeetCode）
%%链接：https://leetcode.cn/problems/walking-robot-simulation
%%著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

%% API
-export([robot_sim/2]).
% (0, 0) (0, 1) (0, -3)
% (1, 0) ->
% (-1, 0) <-
% (0, -1) down
% (0, 1) up
% 直行
% direction  pos command  (-1 -2 1-9)

robot_sim(Commands, Obstacles) ->
  ObstaclesSet = sets:from_list(Obstacles),
  state({[0, 1], [0, 0]}, Commands, init(), ObstaclesSet, 0).

init() ->
  #{
    {[1, 0], -1} => [0, -1],
    {[1, 0], -2} => [0, 1],
    {[0, -1], -1} => [-1, 0],
    {[0, -1], -2} => [1, 0],
    {[-1, 0], -1} => [0, 1],
    {[-1, 0], -2} => [0, -1],
    {[0, 1], -1} => [1, 0],
    {[0, 1], -2} => [-1, 0]
  }.

state(_, [], _, _, Max) -> Max;
state({Direction, Pos}, [Command | NextCommands], Map, Obstacles, Max) ->
  if Command < 0 ->
      NextDirection = map_get({Direction, Command}, Map),
      state({NextDirection, Pos}, NextCommands, Map, Obstacles, Max);
    true ->
        NewPos = move(Direction, Pos, Obstacles, Command),
        NewMax = get_max_point(NewPos, Max),
        state({Direction, NewPos}, NextCommands, Map, Obstacles, NewMax)
  end.

get_max_point([X, Y], Max)  ->
  V = X * X + Y * Y,
  if V > Max -> V;
    true -> Max
  end.

move(_, Pos, _, 0) -> Pos;
move([X, Y], [X1, Y1], Obstacles, V) ->
  NewPos = [X + X1, Y + Y1],
  case sets:is_element(NewPos, Obstacles) of
    true -> [X1, Y1];
    false ->
      move([X, Y], NewPos, Obstacles, V - 1)
  end.

