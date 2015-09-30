# -*- coding: utf-8 -*- 
from django import forms
from django.contrib.auth.models import User
from django.contrib.admin.widgets import FilteredSelectMultiple
from Proyectos.models import Proyecto
from Auth.models import Rol
from django.contrib.auth.forms import UserChangeForm


class UsuarioForm(UserChangeForm):
    
    def clean_groups(self):
        grupos=self.cleaned_data['groups']
        lst=[]
        for grupo in grupos:
            lst.append(Rol.objects.get(group_ptr=grupo).proyecto)
        lst2=[]
        repetidos=""
        for key in lst:
            if key not in lst2:
                lst2.append(key)
            else:
                repetidos+=key.nombre+", "
                
            
        if repetidos !="":
            raise forms.ValidationError("Esta intentando asignar mas de un rol en un mismo Proyecto!")
        return self.cleaned_data['groups']
    


class RolForm(forms.ModelForm):
    class Meta:
        model=Rol
    proyecto = forms.ModelChoiceField(queryset=Proyecto.objects.all())
                                                