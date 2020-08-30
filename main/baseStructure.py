
        ##########################################################
        #    TOUTES LES VARIABLES QUI NE SONT PAS DANS LA BDD    #
        ##########################################################

"""
NIVEAUX = [
    0, # inconnu
    1, # L1
    2, # L2
    3, # L3
    4, # M1
    5, # M2
    6, # Doctorant
    7, # Professeur
    8, # Administration
]
"""

NIVEAUX = {
    "inconnu" : 0,
    "L1" : 1,
    "L2" : 2,
    "L3" : 3,
    "M1" : 4,
    "M2" : 5,
    "Doctorant" : 6,
    "Professeur" : 7,
    "Administration" : 8,
}
NB_NIVEAUX = len(NIVEAUX)

##########################################################

UNIVERSITES = ["SorbonneUniversite",
               "UniversiteParis"]
NB_UNIVERSITES = len(UNIVERSITES)

##########################################################
"""
USER_LEVEL = [
    0, # inconnu
    1, # super admin
    2, # admin
    3, # modo
    4, # prof / staff univ
    5, # user
]
"""

USER_LEVEL = {
    "inconnu" : 0,
    "superadmin" : 1,
    "admin" : 2,
    "modo" : 3,
    "staffuniv" : 4,
    "user" : 5,
}

NB_USER_LEVEL = len(USER_LEVEL)

##########################################################




