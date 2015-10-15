# -*- coding: utf-8 -*- 
'''
Created on 29/5/2015

@author: juanber
'''
from django.views.generic.dates import timezone_today
from django.contrib import admin
from Proyectos.forms import ProyectoForm
from django.contrib.auth.models import Group, User
from django.contrib.auth import get_permission_codename
from Proyectos.models import Proyecto


# Register your models here.
class ProyectoAdmin(admin.ModelAdmin):
    """
     Clase que crea el ABM y Listado de proyecto 
    """
    list_display = ('nombre','estado','descripcion','accion')
    search_fields=('nombre',)
    list_filter=('estado',)
    exclude=('fecha_creacion','equipo')
    actions = None
    form=ProyectoForm
    
    def has_change_permission(self, request, obj=None):
        """
        Esta funcion determina si el usuario actual tiene permisos para editar un proyecto,
        Recibe el objeto request y el proyecto a ser editado (obj)
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        print "PERMISOOOOOOOOOO"
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.id)[0]
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_proyecto").exists()
                else:
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="change_proyecto").exists()
                return permiso
        return True
    
    def has_delete_permission(self, request, obj=None):
        """
        Esta funcion determina si el usuario actual tiene permisos para eliminar un proyecto,
        Recibe el objeto request y el proyecto a ser eliminado (obj)
        Retorna True si el usuario existente tiene un rol con el permiso para eliminar
        el proyecto actual 
        """
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.id)[0]
                if request.GET.get('cancel','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="change_proyecto").exists()
                else:
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="delete_proyecto").exists()
                return permiso
        opts = self.opts
        codename = get_permission_codename('change', opts)
        return request.user.has_perm("%s.%s" % (opts.app_label, codename))
    
    def generar_queryset(self,usuario):
        """
         Funcion que obtiene todos los proyectos asociados a un usuario
        """
        if usuario.is_superuser:            
            qs=Proyecto.objects.all()  
        else:
            qs=User.objects.get(id=usuario.id).proyecto_set.all()
        return qs
    
    def get_queryset(self, request):
        """
        Esta funcion recibe el request y retorna el queryset de proyectos 
        a los que pertenece el usuario actual, si es superusuario muestra todos los proyectos
        """
        qs = self.generar_queryset(request.user)
        ordering = self.get_ordering(request)

        if ordering:
            qs = qs.order_by(*ordering)
        return qs
  
    def save_model(self, request, obj, form, change):
        '''
         En esta función se verifica si el estado cambió a INICIADO y le 
        asigna una fecha de creación, ademas se le asigna como miembro del equipo
        al usuario que creo el proyecto, solo si este no es superusuario
        '''
        
        
        if obj.fecha_creacion == None and obj.estado == 'INI':
            obj.fecha_creacion=timezone_today()
        obj.save()
        
        if not change and not request.user.is_superuser:
            obj.equipo.add(request.user)
                
        
    def delete_model(self, request, obj):
        '''
        La funcion recibe como datos el request y el objeto a eliminar
        En esta función se reciben los datos de Cancelar Proyecto y Eliminar Proyecto, 
        si viene de Cancelar, cambia el estado a 'CAN' ('CANCELADO') y si no elimina el proyecto
        '''
        if request.GET.get('cancel','')!='':
            obj.estado='CAN'
            obj.save()
        else:
            obj.delete()
            
    
    def accion(self, obj):
        '''
            En esta función se crea un enlace para que aparezca en el listado y se pueda 
            ir a la opción "ver" y otro enlace para ir a la opcion "Cancelar" .
            Recibe como parametro un proyecto para crearle un enlace para cancelar y para ver
            
        '''

        columna='<a href="/admin/Proyectos/proyecto/'+str(obj.id)+'/?ver=1" class="btn btn-info btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
        columna+=' <a href="/admin/Proyectos/proyecto/'+str(obj.id)+'/delete/?cancel=1" class="btn btn-danger  btn-small"> <i class="icon-remove icon-white"></i> Cancelar</a>'
        columna+=' <a href="/admin/Proyectos/release/'+str(obj.id)+'/" class="btn btn-success  btn-small"> <i class="icon-plus icon-white"></i> Crear Release</a>'
        columna+=' <a href="/admin/Proyectos/releases/'+str(obj.id)+'/" class="btn btn-warning  btn-small"> <i class="icon-eye-open icon-white"></i> Ver Releases</a>'
        columna+=' <a href="/admin/Proyectos/proyectos/burndownchart1/'+str(obj.id)+'/" class="btn btn-primary  btn-small"> <i class="fa fa-line-chart icon-white"></i> Progreso</a>'
        columna+=' <a href="/admin/Proyectos/proyectos/burndownchart2/'+str(obj.id)+'/" class="btn btn-primary  btn-small"> <i class="fa fa-line-chart icon-white"></i> Estadisticas</a>'
        #columna+=' <a href="/pdf/'+str(obj.id)+'" class="btn btn-warning  btn-small"> <i class="icon-eye-open icon-white"></i> Informe</a>'
        columna+=' <a href="/admin/Proyectos/informes/'+str(obj.id)+'/" class="btn btn-primary  btn-small"> <i class="fa fa-file-pdf-o icon-white"></i>Reportes</a>'
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'