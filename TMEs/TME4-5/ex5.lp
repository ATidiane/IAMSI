
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------Casse-tête logique------------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nationalite(britannique; suedois; danois; norvegien; allemand).
maison(rouge; verte; blanche; jaune; bleue).
animal(chien; oiseaux; poissons; chats; chevaux).
boisson(the; cafe; lait; biere; eau).
marque(pall_mall; dunhill; bluemaster;  princess; blend).
position(1..5).

#show vit/2.
#show garde/2.
#show boit/2.
#show fume/2.
#show setrouve/2.

% Différentes possibilités ainsi que contraintes: On ne peut pas vivre dans 2 maisons
1{vit(N, M): nationalite(N)}1 :- maison(M).
:- vit(N, M), vit(N, M2), M!=M2.

% Idem, on ne peut garder 2 animaux
1{garde(N, A): nationalite(N)}1 :- animal(A).
:- garde(N, A), garde(N, A2), A!=A2.

% On ne peut boire deux boissons 
1{boit(N, B): nationalite(N)}1 :- boisson(B).
:- boit(N, B), boit(N, B2), B!=B2.

% On ne peut fumer deux cigarettes de marques différentes
1{fume(N, M): nationalite(N)}1 :- marque(M).
:- fume(N, M), fume(N, M2), M!=M2.

% Une maison ne peut se trouver à deux positions différentes.
1{setrouve(M, P): maison(M)}1 :- position(P).
:- setrouve(M, P), setrouve(M, P2), P!=P2.

%------------------------------------------- On sait que :

% Les informations sont classées par ordre de l'exo, de 1..15

vit(britannique, rouge).
garde(suedois, chien).
boit(danois, the).

:- setrouve(blanche, P), setrouve(verte, P2), P2!=P-1.

vit(N, verte) :- boit(N, cafe).
fume(N, pall_mall):- garde(N, oiseaux).
vit(N, jaune):- fume(N, dunhill).
setrouve(M, 3):- vit(N, M), boit(N, lait).
setrouve(M, 1):- vit(norvegien, M).

:- fume(N, blend), garde(N2, chats), vit(N, M), vit(N2, M2),
   setrouve(M, P), setrouve(M2, P2), P!=P2-1, P!=P2+1.

:- garde(N, chevaux), fume(N2, dunhill), vit(N, M), vit(N2, M2),
   setrouve(M, P), setrouve(M2, P2), P!=P2-1; P!=P2+1.

fume(N, bluemaster):- boit(N, biere).
fume(allemand, princess).

:- vit(norvegien, M), setrouve(M, P), setrouve(bleue, P2), P!=P2-1; P!=P2+1.

:- fume(N, blend), vit(N, M), setrouve(M, P), boit(N2, eau), vit(N2, M2),
   setrouve(M2, P2), P2!=P-1; P2!=P+1.


% L'allemand garde les poissons :)