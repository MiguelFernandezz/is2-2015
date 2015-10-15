# -*- coding: utf-8 -*-
'''
Created on 29/5/2015

@author: juanber
'''
from django.contrib import admin
from Proyectos.forms import EquipoForm
from Proyectos.models import Proyecto
from Auth.admin import subfinder
from taguato.views import enviar_notificacion
from django.contrib.auth.models import User



class EquipoAdmin(admin.ModelAdmin):
    '''
    clase que administra los equipos del proyecto
    '''
    list_display=('nombre','accion')
    search_fields=('nombre',)
    list_filter=('estado',)
    fields=('equipo',)
    actions=None
    form=EquipoForm
    
    def save_model(self, request, obj, form, change):
        ''' En esta función se guardan los cambios correspondientes a usuarios,
        ya sea Agregar usuarios a equipo o Eliminar Usuario del equipo'''
      
       
        ahora=form.cleaned_data.get('equipo')
        antes=Proyecto.objects.get(pk=obj.id).equipo.all()
        asignados=subfinder(ahora, antes)
        desasignados=subfinder(antes, ahora)
        print asignados,desasignados
        for a in asignados:
            enviar_notificacion(asunto="Equipo de Trabajo", titulo1="Nuevo Equipo de Trabajo", titulo2="Nuevo Equipo de Trabajo",
                   mensaje=" Le informamos que ha sido asignado al equipo del proyecto <b>"+obj.nombre+" </b><br>Ingrese al sistema para ver los detalles."
                             , username=a.username, correo=a.email)
        for d in desasignados:
            enviar_notificacion(asunto="Equipo de Trabajo", titulo1="Desvinculacion de  Equipo de Trabajo", titulo2="Desvinculacion de Equipo de Trabajo",
                   mensaje=" Le informamos que ha sido desvinculado del equipo  <b>"+obj.nombre+" </b>."
                             , username=d.username, correo=d.email)
        
        if change:
            obj.save()
            
  
       
        
    def accion(self, obj):
        '''En esta función se crea un enlace para que aparezca en el listado y se pueda 
        ir a la opción "ver" '''
        columna='<a href="/admin/Proyectos/equipo/'+str(obj.id)+'/?ver=1" class="btn btn-primary btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'
    
    def get_queryset(self, request):
        """
        Retorna el queryset de los equipos a los que pertenece el usuario actual, 
        si es superusuario muestra todos los equipos
        """
        qs = self.model._default_manager.get_queryset()
        if request.user.is_superuser:            
            qs=Proyecto.objects.all()  
        else:
            qs=User.objects.get(id=request.user.id).proyecto_set.all()
        ordering = self.get_ordering(request)

        if ordering:
            qs = qs.order_by(*ordering)
        return qs
    
    def has_change_permission(self, request, obj=None):
        """
        Esta funcion determina si el usuario actual tiene permisos para editar un proyecto,
        Recibe el objeto request y el proyecto a ser editado (obj)
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        
        if obj:
            
            for g in request.user.groups.all():
                if request.GET.get('ver','')!='':
                    permiso= g.permissions.filter(codename="view_equipo").exists()
                else:
                    permiso= g.permissions.filter(codename="change_equipo").exists()
                    
                return permiso
        return True
    
    