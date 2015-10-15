# -*- coding: utf-8 -*-
from django.contrib import admin
from Proyectos.forms import SprintForm
from django.contrib.auth.models import Group, User
from Proyectos.models import Sprint, Proyecto
class SprintAdmin(admin.ModelAdmin):
    '''
    clase que administra los sprint
    '''
    list_display=('nombreSprint','fecha_inicio','fecha_fin','descripcion','proyecto','accion')
    actions=None
    list_filter = ('proyecto',)
    form=SprintForm
    
    
    def accion(self, obj):
        '''En esta función se crea un enlace para que aparezca en el listado y se pueda 
        ir a la opción "ver" '''
        columna='<a href="/admin/Proyectos/sprint/'+str(obj.id)+'/?ver=1" class="btn btn-info btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
        columna+=' <a href="/admin/Proyectos/burndownchart1/'+str(obj.id)+'" class="btn btn-primary btn-small"><i class="fa fa-line-chart icon-white"></i>  Progreso </a>'
        columna+=' <a href="/admin/Proyectos/burndownchart2/'+str(obj.id)+'" class="btn btn-primary btn-small"><i class="fa fa-line-chart icon-white"></i> Estadisticas</a>'
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'
    
    
    def get_queryset(self, request):
        """
        Esta funcion recibe el request y retorna el queryset de proyectos 
        a los que pertenece el usuario actual, si es superusuario muestra todos los srprints
        """
        usuario=request.user
        if usuario.is_superuser:
            return Sprint.objects.all()
        else:
            proyectos=Proyecto.objects.filter(equipo=usuario)
            qs = Sprint.objects.filter(proyecto__in=proyectos)
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
            if request.user.groups.filter(rol__proyecto_id=obj.proyecto_id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.proyecto_id)[0]
            
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_sprint").exists()
                else:
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="change_sprint").exists()
                return permiso
        return True

