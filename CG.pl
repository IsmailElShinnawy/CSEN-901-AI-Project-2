/*
  Knowledge base to be used
*/
:-include('KB.pl').
% :-include('KB2.pl').

/*
  Actions definitions
*/
action(drop, Row, Col, 0, Ships, Row, Col, 1, Ships):-
  capacity(MCap),
  1 =< MCap,
  station(Row, Col).
action(drop, Row, Col, 0, Ships, Row, Col, 2, Ships):-
  capacity(MCap),
  2 =< MCap,
  station(Row, Col).
action(pickup, Row, Col, Cap, Ships, Row, Col, PCap, PShips):-
  capacity(MCap),
  Cap =< MCap,
  ships_loc(IShips),
  \+ member([Row, Col], Ships),
  member([Row, Col], IShips),
  append(Ships, [[Row,Col]], PShips),
  length(PShips, CL),
  length(IShips, ML),
  CL =< ML,
  PCap is Cap - 1,
  PCap >= 0.
action(up, Row, Col, Cap, Ships, PRow, Col, Cap, Ships):-
  PRow is Row + 1,
  valid_cell(PRow, Col).
action(left, Row, Col, Cap, Ships, Row, PCol, Cap, Ships):-
  PCol is Col + 1,
  valid_cell(Row, PCol).
action(down, Row, Col, Cap, Ships, PRow, Col, Cap, Ships):-
  PRow is Row - 1,
  valid_cell(PRow, Col).
action(right, Row, Col, Cap, Ships, Row, PCol, Cap, Ships):-
  PCol is Col - 1,
  valid_cell(Row, PCol).

/*
  Goal definition
*/
goal_test(S):-
  station(Row, Col),
  coast_guard(Row, Col, 0, [], S).

/*
  Successor-state axiom
*/
coast_guard(Row, Col, 0, Ships, s0):-
  agent_loc(Row, Col),
  ships_loc(Ships).
coast_guard(Row, Col, Cap, Ships, result(A, S)):-
  action(A, Row, Col, Cap, Ships, PRow, PCol, PCap, PShips),
  coast_guard(PRow, PCol, PCap, PShips, S).

/*
  Runner
*/
goal(S):-
  ids(goal_test(S), 0).

/*
  Helpers
*/
valid_cell(Row, Col):-
  grid(N, M),
  Row>=0, Row<N,
  Col>=0, Col<M.

ids(X, L):-
  (call_with_depth_limit(X, L, R), number(R));
  (call_with_depth_limit(X, L, R), R = depth_limit_exceeded, L1 is L+1, ids(X, L1)).