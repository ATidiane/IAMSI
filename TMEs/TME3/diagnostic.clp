;; Nom: BALDE
;; Prenom : Ahmed Tidiane
;; Numero etudiant: 3502264



;;; IAMSI 2018 : séance TME 3
;;; Exercice3: diagnostic.clp
; La règle qui permet de remplir la base de faits
; elle est facultative si on décide d'entrer les faits à la
; main dans CLIPS
; watch facts, surveille la base de faits
; watch rules, surveille le déclenchement de la base de règles.
; (clear), remet tout à 0, supprime absolutement tout.
; (reset), ajoute le fait initial (initial-fact)


(defrule my_init
	 (initial-fact)
=>
	(watch facts)
	(watch rules)

    (assert (taches_rouges patient))
    (assert  (peu_boutons patient))
    (assert (sensation_froid patient))
    (assert (forte_fievre patient))
    (assert (yeux_douloureux patient))
    (assert (amygdales_rouges patient))
    (assert (peau_pele patient))
    (assert (peau_seche patient))
)

 
(defrule eruption_cutanee
     (or (peu_boutons ?sujet)
         (beaucoup_boutons ?sujet))
=>
    (assert (eruption_cutanee ?sujet))
)


(defrule exantheme
     (or (eruption_cutanee ?sujet)
         (rougeurs ?sujet))
=>
    (assert (exantheme ?sujet))
)


(defrule etat_febrile
     (or (forte_fievre ?sujet)
         (sensation_froid ?sujet))
=>
    (assert (etat_febrile ?sujet))
)


(defrule signe_suspect
     (amygdales_rouges ?sujet)
     (taches_rouges ?sujet)
     (peau_pele ?sujet)
=>
    (assert (signe_suspect ?sujet))
)

(defrule rougeole
     (or (and (etat_febrile ?sujet)
              (yeux_douloureux ?sujet)
              (exantheme ?sujet))
         (and (signe_suspect ?sujet)
              (yeux_douloureux ?sujet)))
=>
    (assert (rougeole ?sujet))
)


(defrule not_rougeole
     (peu_fievre ?sujet)
     (peu_boutons ?sujet)
     ?id_rougeole <- (rougeole ?sujet)
=>
    ; Si il a la rougeole et pas la rougeole donc on supprime la rougeole
    (retract ?id_rougeole)
    
    (assert (rubeole ?sujet))
    (assert (varicelle ?sujet))
)

(defrule inflammation_ganglions
     (amygdales_rouges ?sujet)
=>
    (assert (inflammation_ganglions))
)

(defrule pustules
     (eruption_cutanee ?sujet)
=>
    (assert (pustules ?sujet))
)


(defrule douleur
     (or (yeux_douloureux ?sujet)
         (dos_douloureux ?sujet))
=>
    (assert (douleur ?sujet))
)


(defrule grippe
     (etat_febrile ?sujet)
     (dos_douloureux ?sujet)
=>
    (assert (grippe ?sujet))
)


(defrule varicelle
     (fortes_demangeaisons ?sujet)
     (pustules ?sujet)
=>
    (assert (varicelle ?sujet))
)


(defrule rubeole
     (peau_seche ?sujet)
     (inflammation_ganglions ?sujet)
     (not (pustules ?sujet))
     (not (sensation_froid ?sujet))
=>
    (assert (rubeole ?sujet))
)

