import traceback
import re # regex
from . import baseStructure as b


        #########################################################
        #         FONCTION GLOBALES UTILITAIRES SIMPLES         #
        #########################################################


def log(type, description, details):
    # Cette fonction va enregistrer l'erreur dans la base de données
    pass

def safe_str(string):
    return string

def safe_num(number):
    try:
        return  (int(number)) if (float(number) == round(number, 0)) else float(number)
    except :
        log("ERROR", "La valeur fournie n'est pas un nombre", traceback.format_exc())
        return None

def safe_bool(boolean):
    return True if boolean else False


def isEmail(email):
    if not re.match(r"^[A-Za-z0-9\.\+_-]+@[A-Za-z0-9\._-]+\.[a-zA-Z]*$", email): return False
    return True

def supportedEmail(email):
    domain = re.search("@[\w.]+", email)
    if domain.group()[1:] in b.EMAILS.keys() : return True
    return False