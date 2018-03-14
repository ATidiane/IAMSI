
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------Organisation de championnat--------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#const nbequipes=3.
#const nbsemaines=3.

equipe(1..nbequipes).
semaine(1..nbsemaines).
jour(mercredi; dimanche).

#show match/4.

% Génération des différentes combinaisons de matchs possibles
1{match(E1, E2, J, S): equipe(E1), jour(J), semaine(S)}1 :- equipe(E1), equipe(E2), E1!=E2.

% Deux équipes ne peuvent pas s'affronter le même jour, dans le même lieu
:- match(E1, E2, J, S), match(E1, E2, J2, S2), J!=J2, S!=S2.

% Deux équipes ne peuvent pas s'affronter le même jour(domicile et extérieur)
:- match(E1, E2, J, S), match(E2, E1, J, S).

% Deux équipes ne peuvent s'affronter deux fois à deux dates différentes
:- match(E1, E2, J, S), match(E1, E2, J2, S), J!=J2.
:- match(E1, E2, J, S), match(E1, E2, J, S2), S!=S2.

% Par jour de match, un seul match!
:- match(E1, E2, J, S), match(E1, E3, J, S), E2!=E3.
:- match(E1, E2, J, S), match(E3, E2, J, S), E1!=E3.
:- match(E1, E2, J, S), match(E3, E4, J, S), E1!=E3, E2!=E4.

   


