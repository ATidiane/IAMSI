

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------Exercice 2: Problème des 8-reines---------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pour voir toutes les solutions et le nombre de solutions, faire:
% clingo 0 fichier.lp

% Pour afficher que les résultats pour reine
#show reine/2.

#const n = 8.

% Création d'un échiquier 8x8
pos(1..n).

% Permet de générer non seulement les règles initiales mais aussi, lui dire
% qu'on en veut une sur chaque colonne.

1{reine(I, J): pos(I)}1 :- pos(J).

% Il n'est pas possible d'en avoir deux sur une même ligne
:- pos(I), pos(J), pos(J2), reine(I, J), reine(I,J2), J != J2.

% Il n'est pas possible d'en avoir deux sur une même diagonale.
:- pos(I), pos(J), pos(I2), pos(J2), reine(I, J), reine(I2,J2), I > I2, |J-J2| = I-I2.

%reine(1,1).
% 4 résultats

%:- reine(4,4).
% 84 résultats