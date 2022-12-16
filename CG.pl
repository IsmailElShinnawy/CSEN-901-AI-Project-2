:- include('KB.pl').

action(up, Row, Col, P, Ships, Row1, Col, P, Ships) :- 
  Row1 is Row-1,
  Row1 >= 0.
action(down, Row, Col, P, Ships, Row1, Col, P, Ships) :- 
  Row1 is Row+1,
  grid(N, _),
  Row1 < N.
action(left, Row, Col, P, Ships, Row, Col1, P, Ships) :- 
  Col1 is Col-1,
  Col1 >= 0.
action(right, Row, Col, P, Ships, Row, Col1, P, Ships) :- 
  Col1 is Col+1,
  grid(_, M),
  Col1 < M.
action(pickup, Row, Col, P, Ships, Row, Col, P1, Ships1) :-
  ship_at_location(Row, Col, Ships),
  capacity(MC),
  P1 is P+1,
  P1 =< MC,
  remove_ship_at_location(Row, Col, Ships, Ships1).
action(drop, Row, Col, P, Ships, Row, Col, 0, Ships) :-
  station(Row, Col),
  P > 0.

% Helpers
ship_at_location(Row, Col, Ships) :-
  member([Row, Col], Ships).

remove_ship_at_location(Row, Col, [[Row, Col]], []).
remove_ship_at_location(Row, Col, [[Row, Col], T], [T]).
remove_ship_at_location(Row, Col, [H, [Row, Col]], [H]).
  

