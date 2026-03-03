% Клієнти 
client(ivan, vip).
client(anna, regular).
client(petro, new).
client(maria, vip).
client(olena, regular).
client(dmytro, new).
client(stepan, vip).

% Середній чек клієнтів
average_check(ivan, 2500).
average_check(anna, 1200).
average_check(petro, 500).
average_check(maria, 800).
average_check(olena, 400).
average_check(dmytro, 150).
average_check(stepan, 5000).

% Типи знижок 
discount_type(big, 20, 'Велика знижка 20%').
discount_type(medium, 10, 'Середня знижка 10%').
discount_type(small, 5, 'Вітальна знижка 5%').
discount_type(none, 0, 'Базові умови, без знижки').


% Якщо клієнт багато витрачає (чек > 1500)
is_high_spender(Client) :-
    average_check(Client, Amount),
    Amount > 1500.

% Якщо клієнт VIP і він "high spender" (чек > 1500), то велика знижка.
recommended_discount(Client, big) :-
    client(Client, vip),
    is_high_spender(Client).


% Якщо клієнт VIP, але чек <= 1500, то середня знижка.
recommended_discount(Client, medium) :-
    client(Client, vip),
    average_check(Client, Amount),
    Amount =< 1500.


% Якщо постійний клієнт (regular) і чек > 1000 — середня знижка.
recommended_discount(Client, medium) :-
    client(Client, regular),
    average_check(Client, Amount),
    Amount > 1000.

%Якщо постійний клієнт і чек <= 1000 — невелика знижка.
recommended_discount(Client, small) :-
    client(Client, regular),
    average_check(Client, Amount),
    Amount =< 1000.

% Новий клієнт із чеком > 300 отримує вітальну знижку.
recommended_discount(Client, small) :-
    client(Client, new),
    average_check(Client, Amount),
    Amount > 300.


%Нові клієнти з чеком <= 300 не отримують знижку.
recommended_discount(Client, none) :-
    client(Client, new),
    average_check(Client, Amount),
    Amount =< 300.



% Список усіх клієнтів, які отримали певний тип знижки
clients_by_discount(DiscountId, ClientList) :-
    findall(Client, recommended_discount(Client, DiscountId), ClientList).

% Збирає пари (Клієнт, Розмір знижки у відсотках) для клієнтів, у яких знижка більше 0.
all_active_discounts(ResultList) :-
    findall((Client, Percent),
            (recommended_discount(Client, DiscId), 
             DiscId \= none, 
             discount_type(DiscId, Percent, _)),
            ResultList).


% Предикат верхнього рівня для запиту знижки конкретного клієнта з описом
advise_discount_for(Client) :-
    recommended_discount(Client, DiscountId),
    discount_type(DiscountId, Percent, Description),
    format('Для клієнта ~w рекомендовано: ~w (~w%)~n', [Client, Description, Percent]).

% Предикат для пошуку всіх клієнтів за певним типом знижки
advise_clients_with_discount(DiscountId) :-
    clients_by_discount(DiscountId, List),
    format('Клієнти зі знижкою ~w: ~w~n', [DiscountId, List]).