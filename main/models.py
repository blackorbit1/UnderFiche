from django.db import models
import "./BaseStructure"

# Create your models here.

from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)


class MyUserManager(BaseUserManager):
    def create_user(self,
                    email,
                    pseudo,
                    nom,
                    prenom,
                    discord_id,
                    discord_pseudo,
                    discord_etat,
                    derniere_connexion,
                    supprime=False,
                    niveau=1,
                    nb_connexion=0,
                    id_etu=None,
                    avatar=None,
                    mail_contact=None,
                    github=None,
                    linkedin=None,
                    description=None,
                    password=None,
                    droit=5):
        """
        Creates and saves a User with the given email, date of
        birth and password.
        """
        error_content = "Les elements suivants sont manquants : "
        error_to_throw = False
        if not email:
            error_content += "\n- email"
            error_to_throw = True
        if not pseudo:
            error_content += "\n- pseudo"
            error_to_throw = True
        if not nom:
            error_content += "\n- nom"
            error_to_throw = True
        if not prenom:
            error_content += "\n- prenom"
            error_to_throw = True

        if error_to_throw:
            raise ValueError(error_content)

        if niveau < 1 or niveau > BaseStructure.NB_NIVEAUX :
            raise ValueError("le niveau entré n'existe pas : " + niveau)

        user = self.model(
            email=self.normalize_email(email),
            date_of_birth=date_of_birth,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, date_of_birth, password=None):
        """
        Creates and saves a superuser with the given email, date of
        birth and password.
        """
        user = self.create_user(
            email,
            password=password,
            date_of_birth=date_of_birth,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user


class MyUser(AbstractBaseUser):
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )
    date_of_birth = models.DateField()
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)

    objects = MyUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['date_of_birth']

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin













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