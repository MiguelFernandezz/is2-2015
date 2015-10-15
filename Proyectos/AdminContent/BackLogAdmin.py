# -*- coding: utf-8 -*- 
'''
Created on 29/5/2015

@author: juanber
'''
from Proyectos.models import UserStory
from django.contrib import admin
from Proyectos.forms import UserStoryForm

class BackLogAdmin(admin.ModelAdmin):
    ''' 
        Clase que crea el ABM y Listado del model UserStory
    '''
    list_display = ('nombreUS','tiempo_estimado','tiempo_trabajado','prioridad','descripcion','proyecto','accion')
    search_fields=('nombreUS',)
    list_filter=('proyecto',)
    
    fieldsets = [
        ("BackLog",{'fields':['nombreUS','tiempo_estimado','descripcion','prioridad','proyecto',]}),
    ]
  
    actions = None
    
    def accion(self, obj):
        '''
            En esta función se crea un enlace para que aparezca en el listado y se pueda 
            ir a la opción "Ver" 
        '''
        columna='<a href="/admin/Proyectos/backlog/'+str(obj.id)+'/?ver=1" class="btn btn-info btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>  '
        return columna
    
    accion.allow_tags = True
    accion.short_description = 'Acción'
    
    def get_queryset(self, request):
        """
        Retorna el queryset de userstory a los que pertenece el usuario actual, 
        si es superusuario muestra todos los proyectos
        """
        qs = UserStory.objects.filter(backlog=True)
        #qs = self.model._default_manager.get_queryset()
        
        ordering = self.get_ordering(request)
        if ordering:
            qs = qs.order_by(*ordering)
        return qs
    
    def save_model(self, request, obj, form, change):
        
        obj.save()
    
    
