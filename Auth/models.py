from django.contrib.auth.models import User, Group
from django.db import models
from Proyectos.models import Proyecto

class Usuario(User):
    '''clase Usuario que hereda todos los atributos y metodos del la clase User de django'''
    class Meta:
        proxy=True
        app_label = 'auth'

class Rol(Group):
    '''clase Rol que hereda todos los atributos y metodos del la clase Group de django'''
    class Meta:
        verbose_name ='rol'
        verbose_name_plural = 'roles'
        app_label = 'auth'
        #proxy=True
    proyecto=models.ForeignKey(Proyecto)

#===============================================================================
# class Prueba(Group):
#     class Meta:
#         verbose_name ='prueba'
#         verbose_name_plural = 'pruebas'
#         app_label = 'auth'
#     proyecto=models.ForeignKey(Proyecto)
#             
#===============================================================================