from django.contrib import admin
from .models import Fichier, Document, Categorie

# Register your models here.

admin.site.register(Fichier)
admin.site.register(Document)
admin.site.register(Categorie)