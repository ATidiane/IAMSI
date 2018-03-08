% Pour afficher que les résultats pour reine

#const n = 8.
#const n1 = 9.

#show case/3.

% Création d'un échiquier 8x8
pos(0..n).
chiffre(1..n1).

% Générer toutes les grilles possibles, et un seul chiffre sur chaque position
1{case(I, J, Z) : chiffre(Z)}1 :- pos(I), pos(J).

% Pour limiter les grilles générées en ajoutant les faits suivants:
% case(0, 1, 7).
% case(1, 0, 8).

% Ajout des trois contraintes du sudoku

% Pas de chiffres identique sur une même ligne
:- pos(I), pos(J), pos(J2), chiffre(Z1), case(I, J, Z1), case(I, J2, Z1), J!=J2.

% Pas de chiffres identique sur une même colonne
:- pos(I), pos(I2), pos(J), chiffre(Z1), case(I, J, Z1), case(I2, J, Z1), I!=I2.

%:- pos(I), pos(J), pos(J2), chiffre(Z1), case(I, J, Z1), case(I, J2, Z1), V1=J/3, V2=J2/3, V1==V2, J!=J2.

:- pos(I), pos(I2), pos(J), pos(J2), chiffre(Z1), case(I, J, Z1), case(I2, J2, Z1), V1=I/3, V2=I2/3, V3=J/3, V4=J2/3, V1==V2, V3==V4, V1==V3, I!=I2, J!=J2.