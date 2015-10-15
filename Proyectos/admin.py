# -*- coding: utf-8 -*- 
'''
Created on 2/4/2015

@author: juanber
'''
from django.contrib.auth.models import User, Group, Permission
from django.contrib import admin
from Proyectos.models import Proyecto, Flujo, Equipo, UserStory, Sprint, Actividad, Comentario
from django.views.generic.dates import timezone_today
from Proyectos.forms import *
from django.contrib.auth import get_permission_codename
from Auth.models import Rol
from django import forms
import warnings
from django.utils.deprecation import RemovedInDjango19Warning
from taguato.views import enviar_notificacion
from Auth.admin import subfinder
from Proyectos.AdminContent.BackLogAdmin import BackLogAdmin
from Proyectos.AdminContent.ProyectoAdmin import ProyectoAdmin
from Proyectos.AdminContent.FlujoAdmin import FlujoAdmin
from Proyectos.AdminContent.EquipoAdmin import EquipoAdmin
from Proyectos.AdminContent.UserStoryAdmin import UserStoryAdmin
from Proyectos.AdminContent.SprintAdmin import SprintAdmin


       
admin.site.register(Proyecto, ProyectoAdmin)
  
admin.site.register(Flujo, FlujoAdmin)

admin.site.register(Equipo, EquipoAdmin)

admin.site.register(UserStory,UserStoryAdmin)

admin.site.register(Sprint,SprintAdmin)

#admin.site.register(Actividad,ActividadAdmin)

admin.site.register(BackLog,BackLogAdmin)