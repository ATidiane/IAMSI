# -*- coding: utf-8 -*-

import numpy as np
import codecs
import unicodedata
from pylab import *
from matplotlib import pyplot as plt


ne = 3
nj = 4

"""
fonction destinee a calculer la valeur de k a partir
des valeurs de x,y et j (dite de decodage)
"""
def find_k(ne,j,x,y):
    return j * ne*ne + x * ne + y + 1

k = find_k(3,0,1,0)
#print k
"""
fonction destinee a calculer les valeurs de x,y et j 
a partir d'une valeur k donnee (dite de codage)
"""
def find_mjxy(k,ne):
    y = (k-1)%(ne)
    x = ((k-1-y)/(ne))%ne
    j = (k-1-y-x*ne)/(ne*ne)

    return j,x,y

j,x,y = find_mjxy(1218,20)
#print j,x,y


def clause_moins(L):
    sortie = ""
    for v in L:
        sortie += str(v) + " "
    sortie += "0"
    return sortie

#print clause_moins([1,2,3])


"""
on prend pour hypothese que la liste contient que une
seule occurence de chaque valeur
"""
def clause_plus(L):
    sortie = []
    for i in range(0,len(L)):
        for j in range(i+1,len(L)):
            sor = ""
            sor += "-" + str(L[i]) + " -" + str(L[j]) + " 0"
            sortie.append(sor)
    return sortie
L =  clause_plus([1,2,3])
#print L

#voir code stat info pour ecriture fichier
def encoderC1(ne,nj):
    c1 = []
    for j in range(0,nj):
        for x in range(0,ne):
            L = []
            for y in range(0,ne):
                if x != y :
                    k1 = find_k(ne,j,x,y) #a domicile
                    k2 = find_k(ne,j,y,x) #en exterieur
                    L.append(k1)
                    L.append(k2)
            c1.append(clause_plus(L)) #L designe une seule et meme contrainte

    return c1

c1 = encoderC1(3,4)
#print c1


def encoderC2(ne,nj): #ne pas mettre quand c'est la même équipe
    c2 = []
    for x in range(0,ne):
        for y in range(0,ne):
            if x!=y: #une equipe peut pas jouer contre elle meme
                L = []
                for j in range(0,nj):
                    k = find_k(ne,j,x,y)
                    L.append(k)
                cpl = clause_plus(L) #au plus 1
                cpl.append(clause_moins(L)) #au moins 1
                c2.append(cpl)           # -> exactement 1
    return c2

c2 = encoderC2(3,4)
print c2 #(3*2*[(4*3/2) + 1])

""" 
fonction qui retourne False quand pas satisfiable 
ou True sinon
"""
def insatisfiable(ne,nj):
    n = ne//2
    return ne*(ne-1)/n > nj
    
"""
fonction retournant la chaine de caracteres "Insatisfiable"
quand ce ne pas satisfiable car pas assez de jours
ou les contraintes associees sinon
"""
def encoder(ne,nj):

    #if insatisfiable(ne,nj):
    #    return "Insatisfiable"

    Sortie = encoderC1(ne,nj)

    return Sortie + encoderC2(ne,nj)

c3 = encoder(3,4)

def nb_contraintes(ne,nj):
    som1 = nj * ne * (ne-1)*(2*(ne-1)-1)
    som2 = ne * (ne - 1)*(1+(nj*(nj-1))/2.)
    
    return int(som1 + som2)
    
print nb_contraintes(3,4)

"""
fonction prennant en argument la liste des contraintes
rendue par 'encoder' et le nom du fichier ou l'on souhaite 
les ecrire
"""
def ecriture(liste, name_file):
    f=open(name_file,"w")
    chaine = "p cnf " + str(ne*ne*nj-1) + " " + str(nb_contraintes(ne,nj))
    f.write(chaine)
    f.write("\n")
    #p cnf 53 204
    for i in range(0,len(liste)):
        for cont in liste[i]:
            f.write(cont)
            f.write("\n")
    f.close()
    
"""
fonction permettant l'extraction des chiffres ou nombres
depuis une ligne de fichier a partir d'un indice 'i'
"""
def extract_number(i,line):
    ext = line[i]
    j = i+1
    while line[j]!= " ":
        ext += line[j]
        j += 1
        
    return ext

"""
fonction qui rend le contenu du fichier rendu par 'glucose'
sous forme de liste d'entiers
"""    
def reformatage(name_file):
    Sortie = []
    for line in open(name_file): 
        l = []
        i=0
        print len(line) 
        while i < len(line) and line[i] != "0":
            if line[i] != " " and line[i] != "v":
                if line[i] == "-":
                    ext = extract_number(i,line)
                    Sortie.append(int(ext))
                    i += len(ext)
                else:
                    ext = extract_number(i,line)
                    Sortie.append(int(extract_number(i,line)))
                    i += len(ext)
            else:
                i += 1
               
    return Sortie
    
print reformatage("text.txt")
    
    
"""
fonction prenant la liste retournee par la fonction 
precedante et rend le planning sous forme de matrice:
    - 1ere colonne :les jours
    - 2eme colonne : equipe a domicile 
    - 3eme colonne :  equipe adverse
"""    
def decodage(L,ne):
    match = []
    for i in range(0,len(L)):
        if L[i] > 0:
            match.append(L[i])
    
    
    liste = []
    for i in range(0,len(match)):
        j,x,y = find_mjxy(match[i],ne)
        triplet = []
        triplet.append(j)
        triplet.append(x)
        triplet.append(y)
        liste.append(triplet)
    return liste
    
"""
fonction permettant de rendre les noms d'equipes
donnes dans un fichier sous forme de liste
"""
    
def lecture_equipe(name_file):
    Sortie = []
    for line in open(name_file):
        Sortie.append(line.strip())#pour retirer '\n'
    return Sortie
    
team_name = lecture_equipe("equipes.txt")

def decoder(name_file,ne,nj):
    equipes = lecture_equipe("equipes.txt")
    result = reformatage(name_file)
    planning = decodage(result,ne)
    print("Proposition de planning pour " + str(ne) + " equipes et " + str(nj) + " jours")    
    for line in planning:
        chaine = "le jour :" + str(line[0]) + " l'equipe de " + str(equipes[line[1]]) + " affronte a domicile " +  str(equipes[line[2]]) 
        print(chaine)
        
decoder("text.txt",ne,nj)

"""
fonction permettant d'ecrire dans un fichier le 
planning en faisant la correspondeance avec les
noms des équipes
"""
def ecriture_planning(planning,equipes, ne, nj):
    f=open("planning.txt","w")
    f.write("Proposition de planning pour " + str(ne) + " equipes et " + str(nj) + " jours")
    f.write("\n")
    f.write("\n")    
    for line in planning:
        print line
        chaine = "le jour :" + str(line[0]) + " l'equipe de " + str(equipes[line[1]]) + " affronte a domicile " +  str(equipes[line[2]]) 
        f.write(chaine)
        f.write("\n")
    f.close()
                
        
"""
fonction generant l'ecriture d'un planning dans un fichier
pour les valeurs de ne et nj donnees
"""
def genere_planning(ne,nj):
    team_name = lecture_equipe("equipes.txt")
    L = reformatage("text.txt") #ce qui est rendu par glucose  
    print L
    planning = decodage(L,ne)
    ecriture_planning(planning,team_name, ne, nj)

genere_planning(3,4)

"""
fonction donnant la borne inf du
nombre de jours necessaires
"""
def borne_inf(ne):
    n = ne//2
    return ne*(ne-1)/n
    
"""
fonction permettant l'affichage de l'evolution de
la borne-inf en fonction du nombre de jours
"""  
def evalution_nj():
    x = range(3,21)
    y = [borne_inf(ne) for ne in x]
    plt.xlabel("le nombre d'equipes")
    plt.ylabel("le nombre de jours au minimum")
    plt.title("Evolution de la borne-inf du nombre de jours" )
    plt.plot(x,y,'+b')
#==============================================================================
#                           Partie tests   
#==============================================================================
c3 = encoder(3,4) #rend les contraintes pour ne = 3 et nj = 4
ecriture(c3,"foot.cnf")  #glucose rend ---> 'UNSAT'
#le fichier 'equipes.txt' stocke les noms des equipes 
#numero de la ligne stocke 
team_name = lecture_equipe("equipes.txt")
#text.txt correspond à ce qui est rendu par glucose pour ne = 3 et nj = 6
nj = 6
decoder("text.txt",ne,nj)
evalution_nj()
