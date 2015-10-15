# -*- coding: utf-8 -*-
from django.contrib import admin
class ActividadAdmin(admin.ModelAdmin):
    '''
    clase que administra las actividades
    '''
    
    actions=None
    list_display = ('nombre','descripcion','flujo','accion')
    
    
    def accion(self, obj):
        '''En esta función se crea un enlace para que aparezca en el listado y se pueda 
        ir a la opción "ver" '''
        columna='<a href="/admin/Proyectos/actividad/'+str(obj.id)+'/?ver=1" class="btn btn-primary btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'
    

