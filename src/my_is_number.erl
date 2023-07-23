-module(my_is_number).
-export([is_number_my/1]).

% 剑指 Offer 20. 表示数值的字符串
is_number_my(S) ->
    S1 = drop_space(S),
    infer_type(S1).

only_number(<<>>, _) ->  {false, <<>>, false};
only_number(<<B:8>>, _L) when B > 47, B < 58 ->
    {true, <<>>, true};
only_number(<<B:8, NextS/binary>>, _L) when B > 47, B < 58 ->
    only_number(NextS, true);
only_number(S, L) -> {false, S, L}.

symbol_read(<<Symbol:8, NextS/binary>>) when Symbol == 43 ; Symbol == 45 ->
    NextS;
symbol_read(S) -> S.

int_number_no_symbol(S, Flag) ->
    case only_number(S, Flag) of 
        {true, <<>>, _} -> {true, not_e};
        {false, <<>>, _} -> {false, null};
        {false, S2, F} ->
            int_number_has_e(S2, F)
    end.

int_number(S) ->
    S1 = symbol_read(S),
    int_number_no_symbol(S1, false).

is_float_n(<<46:8, NextS/binary>>) ->
    {true, NextS};
is_float_n(_S) -> false.

is_e(<<E:8, NextS/binary>>) when E == 101; E == 69 ->
    {true, NextS};
is_e(S) ->  {false, S}.

int_number_has_e(S, false) ->
    case is_e(S) of
        {true, _NextS} ->
            {false, not_num};
        {false, NextS} ->
            {false, maybe_float_3, NextS}
    end;
int_number_has_e(S, true) ->
    case is_e(S) of
        {true, NextS} ->
            {true, int_num_has_e, NextS};
        {false, NextS} ->
            {false, maybe_float_12, NextS}
    end.  

float_3(S) ->
    case is_float_n(S) of
        {true, NextS} ->
            % 整数
            float_3_behind_point(NextS);
        _ -> false
    end.

float_3_behind_point(S) ->
    case int_number_no_symbol (S, false) of
        {true, not_e} -> true;
        {true, int_num_has_e, NextS} ->after_e(NextS);
        _-> false
    end.

after_e(S) ->
    case int_number(S) of
        {true, not_e} -> true;
        _ -> false
    end.


float_12(S) ->
    case is_float_n(S) of
        {true,  NextS} ->
            float_12_behind_point(NextS);
        _ -> false
    end.

float_12_behind_point(S) ->
    case int_number_no_symbol(S, true) of 
        {true, not_e} -> true;
        {false, null} -> true;
        {true, int_num_has_e, S1} ->
            after_e(S1);
        _ -> false
    end.

drop_front_space(<<32:8, NextS/binary>>) ->
    drop_front_space(NextS);
drop_front_space(S) -> S.


drop_behind_space(S) ->
    drop_behind_space(S, byte_size(S)).

drop_behind_space(S, L) when L > 0 ->
    Remain = L - 1,
    <<Front:Remain/binary, Byte:8>> = S,
    if Byte == 32 ->
            drop_behind_space(Front);
        true -> S
    end;
drop_behind_space(S, _L) -> S.

drop_space(S) ->
    S1 = drop_front_space(S),
    drop_behind_space(S1).


infer_type(S) ->
    case int_number(S) of
        {true, not_e} -> true;
        {false, null} -> false;
        {false, not_num} -> false;
        {false, maybe_float_3, NextS} ->
            float_3(NextS);
        {false, maybe_float_12, NextS} ->
            float_12(NextS);
        {true, int_num_has_e, NextS} ->
            after_e(NextS)
    end.