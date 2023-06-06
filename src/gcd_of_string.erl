-module(gcd_of_string).
-export([gcd/2]).
-export([main/2]).

% 字符串最大公因子

gcd(N1, N2) when N1 > N2 -> 
    gcd(N1, N2, N1 rem N2, N2);
gcd(N1, N2) ->
    gcd(N2, N1, N2 rem N1, N1).

gcd(_N1, _N2, 0, R) -> R;
gcd(_N1, N2, Rem, _R) ->
    gcd(N2, Rem, N2 rem Rem, Rem).

main(Str1, Str2) ->
    S1 = <<Str1/binary, Str2/binary>>,
    S2 = <<Str2/binary, Str1/binary>>,
    if S1 == S2 ->
        L1 = byte_size(Str1),
        L2 = byte_size(Str2),
        L3 = gcd(L1, L2),
        create_out(L1, L2, L3, Str1, Str2);
        true -> <<"">>
    end.

create_out(L1, L2, L3, Str1, Str2) ->
    if L1 > L2 ->
        binary:part(Str1, {0, L3});
    true ->
        binary:part(Str2, {0, L3})
    end.