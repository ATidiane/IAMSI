# -*- coding: utf-8 -*-

def codage(ne, nj, j, x, y):
    """ Variables propositionnelles mjxy, codées par vk
        :param ne: Nombre d'équipes 0..ne-1
        :param nj: Nombre de jours 0..nj-1
        :param x: Equipe x jouant à domicile
        :param y: Equipe y jouant à l'extérieur
        :param j: Jour du match entre l'équipe x et y
        :return k: Formule ci-dessus.
    """
    return (j*ne**2) + (x*ne) + y + 1


def uncodage(k, ne):
    """ Fonction qui retrouve j, x et y à partir de k, ne 
        :return j, x, y: Le jour de match, et les équipes x et y
    """
    x = (k - (j*ne**2) - y - 1)/ne
    y = k - (j*ne**2) - (x*ne) - 1
    j = (k - (x*ne) - y - 1)/(ne**2)
    

def getClause(list_entiers):
    """ Retourne une clause DIMACS correspondant à la contrainte 'au moins une
        de ces variables est vraie'
    """

    ch = reduce(lambda x, y: str(x)+" "+str(y), list_entiers, "")
    return ch+"\n"

def getClauseS(list_entiers):

    tmp = [ str(-1*i)+" "+str(-1*j) for i in list_entiers for j in list_entiers[i:]]
    print(tmp)
    return "\n".join(tmp)


if __name__=="__main__":
    print(getClause(range(5)))
    print(getClauseS([1, -2, 4]))
    
