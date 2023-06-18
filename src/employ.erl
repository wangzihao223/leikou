-module(employ).

% %一财主有一个金矿，在D天后该金矿会被收归国有。
% % 财主目前有P个长工，每个长工每天可以挖G块金子。
% % 财主每天可以新雇佣若干长工，每个长工需一次性支付K块金子。
% % 目前财主手上有M块金子，为了在D天内获得最多金子，请问该财主需要每天新增多少长工。

main(0, _, _, _, _, Res) ->
    lists:reverse(Res);
main(D, P, G, K, M, Res) ->
    if D * G  - K > 0 ->
        % 买完长工剩下的钱
        M1 = M rem K,
        % 买 newP 
        NewP = M div K,
        P1 = NewP + P,
        M2 = M1 + P1 * G,
        main(D-1, P1, G, K, M2, [NewP|Res]);
    true ->
        M2 = M + P * G,
        main(D-1, P, G, K, M2, [0|Res])
    end.

% loop(D) ->
