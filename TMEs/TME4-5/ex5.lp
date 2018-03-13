
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

1{vit(N, M): nationalite(N)}1 :- maison(M).
:- nationalite(N), maison(M), maison(M2), vit(N, M), vit(N, M2), M!=M2.

1{garde(N, A): nationalite(N)}1 :- animal(A).
:- nationalite(N), animal(A), animal(A2), garde(N, A), garde(N, A2), A!=A2.

1{boit(N, B): nationalite(N)}1 :- boisson(B).
:- nationalite(N), boisson(B), boisson(B2), boit(N, B), boit(N, B2), B!=B2.

1{fume(N, M): nationalite(N)}1 :- marque(M).
:- nationalite(N), marque(M), marque(M2), fume(N, M), fume(N, M2), M!=M2.

1{setrouve(M, P): maison(M)}1 :- position(P).
:- maison(M), position(P), position(P2), setrouve(M, P), setrouve(M, P2), P!=P2.

%-------------------------------- On sait que :

vit(britannique, rouge).
garde(suedois, chien).
boit(danois, the).

:- position(P), position(P2), setrouve(blanche, P), setrouve(verte, P2), P2!=P-1.

vit(N, verte) :- boit(N, cafe).
fume(N, pall_mall):- garde(N, oiseaux).
vit(N, jaune):- fume(N, dunhill).
setrouve(M, 3):- vit(N, M), boit(N, lait).
setrouve(M, 1):- vit(norvegien, M).

:- nationalite(N), nationalite(N2), maison(M), maison(M2), position(P),
   position(P2), fume(N, blend), garde(N2, chats), vit(N, M), vit(N2, M2),
   setrouve(M, P), setrouve(M2, P2), P!=P2-1, P!=P2+1.

:- nationalite(N), nationalite(N2), maison(M), maison(M2), position(P),
   position(P2), garde(N, chevaux), fume(N2, dunhill), vit(N, M), vit(N2, M2),
   setrouve(M, P), setrouve(M2, P2), P!=P2-1; P!=P2+1.

fume(N, bluemaster):- boit(N, biere).
fume(allemand, princess).

:- maison(M), position(P), position(P2), vit(norvegien, M), setrouve(M, P),
   setrouve(bleue, P2), P!=P2-1; P!=P2+1.

:- nationalite(N), nationalite(N2), maison(M), maison(M2), position(P), position(P2),
   fume(N, blend), vit(N, M), setrouve(M, P), boit(N2, eau), vit(N2, M2), setrouve(M2, P2),
   P2!=P-1; P2!=P+1.


% L'allemand garde les poissons :)