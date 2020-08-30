#from django.shortcuts import render, HttpResponse
from django.shortcuts import *
from . import utilitaires as u


### --- Arrivée sur le site --- ###

def LandingPage(request):
    context = {}


    return render(request, "landing_page.html", context)


def Inscription(request):
    context = {
        "error_txt": "Les erreurs sont les suivantes : ",
        "error": False,
    }



    # Si l'user vient de la landing page
    if (request.method == "POST"
        and request.POST.get('email', False)
        and request.POST.get('password1', False)
        and request.POST.get('password2', False)
    ):
        if not u.isEmail(request.POST.get('email', '')):
            context["error_txt"] += "\n- L'email fournis est incorrect"
            context["error"] = True
        if not u.supportedEmail(request.POST.get('email', '')):
            context["error_txt"] += "\n- L'email contient une faute de frape ou l'université n'est pas supportée"
            context["error"] = True
        if request.POST.get('password1', 1) != request.POST.get('password2', 2):
            context["error_txt"] += "\n- Les deux mots de passe fournis sont différents"
            context["error"] = True

        # TODO : Vérification que le mail donné n'appartient pas déjà à un compte et envoie du code par mail

        if not context["error"] :
            return render(request, "inscription.html", context)
        else :
            return render(request, "landing_page.html", context)

    # Si l'user a rempli les dernieres informations d'inscription
    elif (request.method == "POST"
            and request.POST.get('code_verification', False)
            and request.POST.get('discord', False)
            and request.POST.get('niveau', False)
            and request.POST.get('nom', False)
            and request.POST.get('prenom', False)
            and request.POST.get('pseudo', False)
    ):
        avatar = request.POST.get('avatar', None)
        id_etudiant = request.POST.get('id_etu', None)
        contact_email = request.POST.get('mail_contact', None)
        if request.POST.get('email', False) and not u.isEmail(request.POST.get('email', '')):
            context["error_txt"] += "\n- L'email de contact fournis est incorrect"
            context["error"] = True

        if context["error"]:
            return render(request, "inscription.html", context)

        # TODO : Vérification du code recu par mail


        if not context["error"] :
            return render(request, "accueil.html", context)
        else :
            return render(request, "inscription.html", context)

    # TODO : Faire un systeme pour avoir un mode "production" et un mode "debug" pour pas jouer avec les commentaires
    # else : return render(request, "landing_page.html", context)

    return render(request, "inscription.html", context)
    # --------> On ne peut pas arriver directement à cette page


### --- Pages principales --- ###


# Vue à affichier lorsqu'on se trouve dans l'accueil du site
def Accueil(request):
    context = {}


    return render(request, "accueil.html", context)

# Vue à affichier lorsqu'on se trouve sur une catégorie de type matiere
def Matiere(request):
    context = {}

    #return HttpResponse("<h1>Bonjour à vous !</h1>") #---> Marche

    return render(request, "matiere.html", context)

