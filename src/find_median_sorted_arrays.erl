%%%-------------------------------------------------------------------
%%% @author 16009
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. 8月 2023 14:23
%%%-------------------------------------------------------------------
-module(find_median_sorted_arrays).
-author("16009").

%% API
-export([main/2]).
main(Nums1, Nums2) ->
  A1 = array:from_list(Nums1),
  A2 = array:from_list(Nums2),
  S1 = array:size(A1),
  S2 = array:size(A2),
  K = (S1 + S2)  div 2,
  if K div 2 >= S1 ->
      condition1(K div 2, array:get(S1 - 1, A1), S1, A2, S2, K div 2, K);
    K div 2 >= S2 ->
      condition1(K div 2, array:get(S2 - 1, A2), S2, A1, S1, K div 2, K);
    true ->
      dichotomy(K div 2, A1, S1, K div 2, A2, S2, K div 2, K)
  end.

%% 寻找两个数组中的中位数
dichotomy(1, A1, _Siz1, I1, A2, _Size, I2, SourceK) ->
  N1 = array:get(I1, A1),
  N2 = array:get(I2, A2),
  if SourceK rem 2 == 0 ->
    if N1 > N2 ->
        (N1 + array:get(I1 + 1, A1)) / 2;
      true ->
        (N2 + array:get(I2 + 1, A2)) / 2
    end;
    true ->
      max(N1, N2)
  end;
dichotomy(K, A1, Size1, I1, A2, Size2, I2, SourceK) ->
  io:format("K is ~p ~n", [K]),
  HalfK = K div 2,
  N1 = array:get(I1, A1),
  N2 = array:get(I2, A2),
  if N2 > N1 ->
      NewI1  = HalfK div 2 + I1,
      if NewI1 >= Size1 ->
          NewN1 = array:get(Size1-1, A1),
          condition1(K div 2, NewN1, Size1, A2, Size2, I2, SourceK);
        true ->
          dichotomy(HalfK, A1, Size1, NewI1, A2, Size2, I2, SourceK)
      end;
    true ->
      NewI2 = HalfK div 2 + I2,
      if NewI2 >= Size2 ->
          NewN2 = array:get(Size2 - 1, A2),
          condition1(K div 2, NewN2, Size2, A1, Size1, I1, SourceK);
        true ->
          dichotomy(HalfK, A1, Size1, I1, A2, Size2, NewI2, SourceK)
      end
  end.


condition1(K, N1, Size1, A2, Size2, I2, SourceK) ->
  N2 = array:get(I2, A2),
  io:format("N1 ~p N2 ~p ~n", [N1, N2]),
  if N1 > N2 ->
      condition1(K div 2, N1, Size1, A2, Size2, I2 + K div 2, SourceK);
    true ->
      array:get(K - Size1, A2)
  end.