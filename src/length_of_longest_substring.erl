-module(length_of_longest_substring).

-export([length_of_longest_substring/1]).
length_of_longest_substring(S) -> 
    S1 = unicode:characters_to_list(S),
    L = the_max(S1, 0, queue:new(), 0),
    erase(),
    L.

the_max([Word | NextWords], L, Window, Max) ->
    case get(Word) of
        undefined ->  
            put(Word, 1),
            the_max(NextWords, L + 1, queue:in(Word, Window), Max);
        1 -> 
            Win1 = out_window(Window, Word),
            put(Word, 1),
            the_max(NextWords, queue:len(Win1) + 1, queue:in(Word, Win1), max(Max, L))
    end;
the_max([], L, _, Max) -> max(Max, L).


out_window(Window, Word) ->
    case queue:is_empty(Window) of
        true -> Window;
        false ->
            {{value, W}, Win1} = queue:out(Window),
            erase(W),
            case get(Word) of
                1-> out_window(Win1, Word);
                undefined->  Win1
            end
    end.


