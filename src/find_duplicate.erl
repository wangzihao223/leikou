-module(find_duplicate).
% 寻找重复数
% 哈希表 时间复杂度 o(n) 空间复杂度 o(n)

find_duplicate(Num) ->
    dup_remove(Num, sets:new([{version, 2}]), 0).

dup_remove([N | Next], Set, LastSize) ->
    Set1 = sets:add_element(N, Set),
    SizeNow = sets:size(Set1),
    case SizeNow == LastSize of
        true -> N;
        false -> dup_remove(Next, Set1, SizeNow)
    end.
