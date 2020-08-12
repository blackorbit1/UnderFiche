from django.db import models

# Create your models here.

# Temporaire
class Fichier(models.Model):
    # Tous les attributs d'un fichier
    id = models.IntegerField(primary_key=True)
    id_document = models.IntegerField()
    nom = models.CharField(max_length=50)

    # Nom du fichier sur l'interface admin de Django
    def __str__(self):
        return self.nom

# Temporaire
class Document(models.Model):
    # Tous les attributs d'un document (un document contient 1 à n fichiers)
    id = models.IntegerField(primary_key=True)
    nom = models.CharField(max_length=50)
    type = models.IntegerField() # td / tp / fiche / cours / annexe / correction pur / logiciel / informations / tuto / exemple travail / autre
    corrige = models.BooleanField()
    visibilite = models.IntegerField() # 1 = visible / 2 = retrait prof / 3 = affichage periodique / 4 = non validé / 5 = supprime
    informations = models.TextField()
    code_aperçu = models.CharField(max_length=50) # le code est un hash généré automatiquement qui est le nom du fichier de l'image d'apercu de ce document
    mots_cles = models.TextField() # Tous les mots clés séparés par des virgules

    # Nom du document sur l'interface admin de Django
    def __str__(self):
        return self.nom

# Temporaire
class Categorie(models.Model):
    # Tous les attributs d'une catégorie
    id = models.IntegerField(primary_key=True)
    type = models.IntegerField() # 1 = matiere / 2 = catégorie bibliotheque / 3 = scolarite / 4 = informations generales
    date_ajout = models.DateField()
    date_modification = models.DateField()
    date_suppression = models.DateField()
    nom_court = models.CharField(max_length=100)
    nom_long = models.CharField(max_length=200)
    code = models.CharField(max_length=50)
    texte = models.TextField()

    # Nom de la catégorie sur l'interface admin de Django
    def __str__(self):
        return self.nom_court