;;; IAMSI 2018 : séance TME 3
;;; famille.clp

; La règle qui permet de remplir la base de faits
; elle est facultative si on décide d'entrer les faits à la
; main dans CLIPS
; watch facts, surveille la base de faits
; watch rules, surveille le déclenchement de la base de règles.
; (clear), remet tout à 0, supprime absolutement tout.
; (reset), ajoute donc le fait initial (initial-fact)

(defrule my_init
	 (initial-fact)
=>
	(watch facts)
	(watch rules)

	(assert (pere claire jean))
	(assert (pere bob jean))
	(assert (pere yves bob))
	(assert (mere yves zoe))
	(assert (mere luc claire))
	(assert (mere alain claire))
)

; Grand-père par le père
(defrule grand_pere1
	 (pere ?enf ?papa)
	 (pere ?papa ?papa2papa)
=>
	(assert (grand_pere ?enf ?papa2papa))
)

; Grand-père par ma mère
(defrule grand_pere2
	 (mere ?enf ?maman)
	 (pere ?maman ?papa2maman)
=>
	(assert (grand_pere ?enf ?papa2maman))
)

; Parent : lien entre un enfant et son père ou sa mère
(defrule parent1
	 (pere ?enf ?papa)
=>
	(assert (parent ?enf ?papa))
)

(defrule parent2
	 (mere ?enf ?maman)
=>
	(assert (parent ?enf ?maman))
)

; Frère ou soeur
(defrule frere_et_soeur
     (parent ?enf1 ?pereOuMere)
	 (parent ?enf2 ?pereOuMere)
	 (test (neq ?enf1 ?enf2))
=>
	(assert (frere_et_soeur ?enf1 ?enf2))
	(assert (frere_et_soeur ?enf2 ?enf1))
)

; Question 8
;===========
;(defrule enfant_unique_bad
;     (parent ?enf ?papaOuMaman)
;     (not (frere_et_soeur ?enf ?autre))
;=>
;    (assert (enfant_unique_bad ?enf))
;)
; Ne marche pas parce que la règle frere_et_soeur de bob se déclenche trop
; tôt par exemple, alors qu'il faut déja tous les faits frere_et_soeur soient
; ajoutés dans la base.

; Question 9
;============
(defrule enfant_unique_priorite
     (declare (salience -1000))
     (parent ?enf ? papa0uMaman)
     (not (frere_et_soeur ?enf ?autre))
=>
    (assert (enfant_unique_bad ?enf))
)
; salience = 0 par défaut, elle est compris entre -1000 et +1000, respectivement
; pas prioritaire du tout et très prioritaire.

; ----- fin fichier famille.clp