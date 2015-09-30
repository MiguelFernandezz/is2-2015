# -*- coding: utf-8 -*- 
from django import forms
from django.contrib.auth.models import User
from django.contrib.admin.widgets import FilteredSelectMultiple
from Proyectos.models import Proyecto, Flujo


class EquipoForm(forms.ModelForm):
    class Meta:
        model=Proyecto
    equipo = forms.ModelMultipleChoiceField(queryset=User.objects.filter(is_active=True),
                                          label='Añadir Usuarios al Equipo',
                                          required=False,
                                          widget=FilteredSelectMultiple(
                                                    'Usuarios',
                                                    False,
                                                 ))
    
    
class FlujoForm(forms.ModelForm):
    class Meta:
        model=Flujo
    proyecto = forms.ModelChoiceField(queryset=Proyecto.objects.all())
    
    
