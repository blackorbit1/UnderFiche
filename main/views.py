#from django.shortcuts import render, HttpResponse
from django.shortcuts import *

### --- Arrivée sur le site --- ###

def LandingPage(request):
    context = {}


    return render(request, "landing_page.html", context)


def Inscription(request):
    context = {}


    return render(request, "inscription.html", context)


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

