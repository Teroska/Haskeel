my_length([], 0).

my_length([_ | Tail], N) :-
    my_length(Tail, N1),  
    N is N1 + 1.          


my_sum_list([], 0).

my_sum_list([Head | Tail], Sum) :-
    my_sum_list(Tail, TailSum), 
    Sum is Head + TailSum.


my_max_list([X], X).

my_max_list([Head | Tail], Max) :-
    my_max_list(Tail, MaxTail),    
    Max is max(Head, MaxTail).



map_square([], []).

map_square([H | T], [H_sq | T_sq]) :-
    H_sq is H * H,               
    map_square(T, T_sq).

