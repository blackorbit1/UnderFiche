from django.db import models

# "from ." parce que sinon django ne le reconnais pas automatiquement
# sans avoir à faire de modifications dans un fichier de configuration
from . import baseStructure as b
from . import utilitaires as u


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

        if niveau < 1 or niveau > b.NB_NIVEAUX :
            raise ValueError("le niveau entré n'existe pas : " + niveau)

        # TODO : vérifier qu'un utilisateur du meme pseudo / id / etc n'est pas déjà inscrit

        user = self.model(
            email=self.normalize_email(email),
            pseudo=u.safe_str(pseudo),
            nom=u.safe_str(nom),
            prenom=u.safe_str(prenom),
            discord_id=u.safe_num(discord_id),
            discord_pseudo=u.safe_str(discord_pseudo),
            discord_etat=0, # TODO : Définir les correspondances
            derniere_connexion=derniere_connexion, # TODO : a revoir
            supprime=u.safe_bool(supprime),
            niveau=u.safe_num(niveau),
            nb_connexion=u.safe_num(nb_connexion),
            id_etu=u.safe_str(id_etu),
            avatar=u.safe_str(avatar),
            mail_contact=u.safe_str(mail_contact),
            github=u.safe_str(github),
            linkedin=u.safe_str(linkedin),
            description=u.safe_str(description),
            password=u.safe_str(password),
            droit=u.safe_str(droit),
            #date_of_birth=date_of_birth,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    """
    ====>   On va dire qu'il ne faut pas qu'il y ait une telle fonction car pour creer un superuser
            il faut avoir au moins assez de droits pour modifier la BDD à la main
            Les superuser seront donc des user normaux modifiés à la main
            Il ne faut pas que la fonction de creation de superuser soit super accessible
    
    def create_superuser(self, email, date_of_birth, password=None):
        #Creates and saves a superuser with the given email, date of
        #birth and password.

        user = self.create_user(
            email,
            password=password,
            #date_of_birth=date_of_birth,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user
    
    """



class MyUser(AbstractBaseUser):
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )

    # TODO : Voir si on ne peut pas ajouter des infos genre "verbose_name", "max_length", "unique"
    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    #email = models.EmailField() # déjà là par défaut
    #username = models.TextField() # déjà là par défaut
    #password = models.TextField() # déjà là par défaut
    nom = models.TextField(default=None)
    prenom = models.TextField(default=None)
    discord_id = models.PositiveIntegerField(default=None)
    discord_pseudo = models.TextField(default=None)
    discord_etat = models.PositiveIntegerField(default=None)
    derniere_connexion = models.DateField(default=None)
    supprime = models.BooleanField(default=False)
    niveau = models.PositiveIntegerField(default=b.NIVEAUX["inconnu"])
    nb_connexion = models.PositiveIntegerField(default=0)
    id_etu = models.TextField(default=None)
    avatar = models.TextField(default=None) # TODO : est ce qu'on ne devrait pas utiliser `models.ImageField()` ?
    mail_contact = models.EmailField(default=None)
    github = models.URLField(default=None) # TODO : ou TextField() ?
    linkedin = models.URLField(default=None) # --------> IDEM
    description = models.TextField(default=None)
    droit = models.PositiveIntegerField(default=b.NIVEAUX["inconnu"])



    objects = MyUserManager()

    USERNAME_FIELD = ['email', 'username']
    REQUIRED_FIELDS = []

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



class EmailVerificationSystem():
    pass

# 1 mail = n codes de vérification
class EmailVerificatioCode(models.Model):
    id = models.IntegerField(primary_key=True)
    email = models.CharField(max_length=100)
    code = models.CharField(max_length=20)




    # Nom du fichier sur l'interface admin de Django
    def __str__(self):
        return self.email






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