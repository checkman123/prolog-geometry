/*Distance Formula*/
distanceRound(point2d(X1,Y1), point2d(X2,Y2), D):-
    D is round(sqrt((X2 - X1)^2 + (Y2 - Y1)^2)).

distance(point2d(X1,Y1), point2d(X2,Y2), D):-
    D is sqrt((X2 - X1)^2 + (Y2 - Y1)^2).

/*Is the line defined by two points vertical?*/
vertical(point2d(X,_), point2d(X,_)).

/*Is the line defined by two points horizontal?*/
horizontal(point2d(_,Y), point2d(_,Y)).

/*Do the given three points define a line?*/
line(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :- 
    slope( point2d(X1,Y1), point2d(X2,Y2), S ),
    slope( point2d(X1,Y1), point2d(X3,Y3), S ).

slope( point2d(X1,Y1), point2d(X2,Y2), S ) :-
    S is ((Y2-Y1)/(X2-X1)).

/*Do the given three points define a triangle?*/
triangle(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :- 
\+ ((1/2) * (X1 * (Y2 - Y3) + X2 * (Y3 - Y1) + X3 * (Y1-Y2))) =:= 0.

/*Is the triangle isosceles?*/
isosceles(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)):- 
    distance( point2d(X1,Y1), point2d(X2,Y2), D1 ),
    distance( point2d(X2,Y2), point2d(X3,Y3), D2 ),
    distance( point2d(X1,Y1), point2d(X3,Y3), D3 ),
    (D1 =:= D2; D2 =:= D3; D3 =:= D1).

/*Is the triangle equilateral?*/
equilateral(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :- 
    distanceRound( point2d(X1,Y1), point2d(X2,Y2), D ),
    distanceRound( point2d(X2,Y2), point2d(X3,Y3), D ),
    distanceRound( point2d(X1,Y1), point2d(X3,Y3), D ).

/*Is the triangle right?*/
right(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :-
    distance( point2d(X1,Y1), point2d(X2,Y2), D1 ),
    distance( point2d(X2,Y2), point2d(X3,Y3), D2 ),
    distance( point2d(X1,Y1), point2d(X3,Y3), D3 ),
    (   round(D1^2) =:= round(D2^2 + D3^2); 
        round(D2^2) =:= round(D1^2 + D3^2); 
        round(D3^2) =:= round(D1^2 + D2^2)).

/*Is the triangle scalene?*/
scalene(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :-
    distance( point2d(X1,Y1), point2d(X2,Y2), D1 ),
    distance( point2d(X2,Y2), point2d(X3,Y3), D2 ),
    distance( point2d(X1,Y1), point2d(X3,Y3), D3 ),
    (D1 =\= D2, D2 =\= D3, D1 =\= D3).

/*Is the triangle acute?*/
acute(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :-
    distance( point2d(X1,Y1), point2d(X2,Y2), D1 ),
    distance( point2d(X2,Y2), point2d(X3,Y3), D2 ),
    distance( point2d(X1,Y1), point2d(X3,Y3), D3 ),
    (
        (D1 > D2, D1 > D3) ->
            round(D1^2) < round(D2^2 + D3^2);
        (D2 > D1, D2 > D3) ->
            round(D2^2) < round(D1^2 + D3^2);
            round(D3^2) < round(D1^2 + D2^2)
    ).

/*Is the triangle obtuse?*/
obtuse(point2d(X1,Y1), point2d(X2,Y2), point2d(X3,Y3)) :-
    distance( point2d(X1,Y1), point2d(X2,Y2), D1 ),
    distance( point2d(X2,Y2), point2d(X3,Y3), D2 ),
    distance( point2d(X1,Y1), point2d(X3,Y3), D3 ),
    (
        (D1 > D2, D1 > D3) ->
            round(D1^2) > round(D2^2 + D3^2);
        (D2 > D1, D2 > D3) ->
            round(D2^2) > round(D1^2 + D3^2);
            round(D3^2) > round(D1^2 + D2^2)
    ).