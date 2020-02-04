/* 11 вариант
6 человек назовем их А, Б, В, Г, Д и Е кандидаты посты председателя,
заместителя председателя и секретаря правления общества любителей логических задач.
Но определить состав этой тройки оказалось не так-то легко.
Судите сами: А не хочет входить в состав руководства, если Д не будет председателем.
Б не хочет входить в состав руководства, если ему придется быть старшим над В.
Б не хочет работать вместе с Е ни при каких условиях.
В не хочет работать, если в состав руководства войдут Д и Е вместе.
В не будет работать, если Е будет председателем, или если Б будет секретарем.
Г не будет работать с В или Д, если ему придется подчиняться тому или другому.
Д не хочет быть заместителем председателя. Д не хочет быть секретарем,
если в состав руководства войдет Г. Д не хочет работать вместе с А,
если Е не войдет в состав руководства. Е согласен работать только в том случае,
если председателем будет либо он, либо В. Как они решили эту проблему? */

is_member(X, [X | _]).
is_member(X, [_ | T]) :- is_member(X, T).

candidates([X, Y, Z]) :-
    L = ['A', 'B', 'V', 'G', 'D', 'E'],
    is_member(X, L),
    is_member(Y, L),
    not(X = Y),
    is_member(Z, L),
    not(Y = Z),
    not(X = Z).

older(X, Z, [X, Z, _]). 
older(X, Z, [X, _, Z]).
older(X, Z, [_, X, Z]).

solve(List) :- 
    candidates(List),
    List = [Chairman, Deputy, Secretary],
    (Chairman = 'D'; not(is_member('A', List))),
    (not(older('B', 'V', List)); not(is_member('B', List))),
    (not(is_member('E', List)); not(is_member('B', List))),
    (not(is_member('D', List)); not(is_member('E', List)); not(is_member('V', List))),
    (not(Chairman = 'E'), not(Secretary = 'B'); not(is_member('V', List))),
    (not(older('V', 'G', List)), not(older('D', 'G', List)); not(is_member('G', List))),
    not(Deputy = 'D'),
    (not(is_member('G', List)); not(Secretary = 'D')),
    (is_member('E', List); not(is_member('A', List)); not(is_member('D', List))),
    ((Chairman = 'E'); (Chairman = 'V'); not(is_member('E', List))).

