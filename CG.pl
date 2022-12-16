:- include('KB.pl').
% :- include('KB2.pl').

reverse_action(drop, Row, Col, 0, Ships, Row, Col, 1, Ships) :-
  station(Row, Col).
reverse_action(drop, Row, Col, 0, Ships, Row, Col, 2, Ships) :-
  capacity(MC),
  MC = 2,
  station(Row, Col).
reverse_action(pickup, Row, Col, Current_Passengers, Current_Ships, Row, Col, Previous_Passengers, Previous_Ships) :-
  \+ member([Row, Col], Current_Ships),
  capacity(MC),
  Current_Passengers =< MC,
  Previous_Passengers is Current_Passengers-1,
  append(Current_Ships, [[Row, Col]], Previous_Ships).
reverse_action(right, Row, Current_Col, Passengers, Ships, Row, Previous_Col, Passengers, Ships) :- 
  Previous_Col is Current_Col-1,
  Previous_Col >= 0.
reverse_action(left, Row, Current_Col, Passengers, Ships, Row, Previous_Col, Passengers, Ships) :- 
  Previous_Col is Current_Col+1,
  grid(_, M),
  Previous_Col < M.
reverse_action(up, Current_Row, Col, Passengers, Ships, Previous_Row, Col, Passengers, Ships) :- 
  Previous_Row is Current_Row+1,
  grid(N, _),
  Previous_Row < N.
reverse_action(down, Current_Row, Col, Passengers, Ships, Previous_Row, Col, Passengers, Ships) :- 
  Previous_Row is Current_Row-1,
  Previous_Row >= 0.

  

