
#const n = 2.

pos(1..n).


:- pos(I), pos(J), pos(J2), J + J2 != 8.

:- pos(I2), pos(J), pos(J2), J + J2 != 6.

:- pos(J), pos(I), pos(I2), I + I2 != 13.

:- pos(J2), pos(I), pos(I2), I + I2 != 8.

