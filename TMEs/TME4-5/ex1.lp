%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------Exercice 1: Premiers pas en ASP----------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

conges.
temps_libre :- conges.
sortie_cine :- temps_libre, conges.

% conges, temps_libre, sortie_cine : satisfiable

p :- not q.
q :- not r.

% q : satisfiable

p :- not q.
q :- not p.
r :- p.
r :- q.

% p, r : satisfiable

p :- not q.
q :- not p.
r :- not r.
r :- p.

% p, r: satisfiable

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------Exercice 2: Problème des 8-reines---------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pour afficher que les résultats pour reine
#show reine/2.

#const n = 8.

% Création d'un échiquier 8x8
pos(1..n).

1{reine(I, J): pos(I)}1 :- pos(J).
%:- pos(I), pos(J), pos(J2),reine(I, J), reine(I,J2), J != J2.

%:- reine(I, J), reine(I2, J2), J = J2.
%:- reine(I, J), reine(I2,J2), I2-I = J2-J.
