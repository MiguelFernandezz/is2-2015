# -*- coding: utf-8 -*- 
'''
Created on 2/4/2015

@author: juanber
'''
from django.contrib.auth.models import User, Group, Permission
from django.contrib import admin
from Proyectos.models import Proyecto, Flujo, Equipo, UserStory, Sprint, Actividad
from django.views.generic.dates import timezone_today
from Proyectos.forms import EquipoForm, FlujoForm
from django.contrib.auth import get_permission_codename
from Auth.models import Rol
from django import forms

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
    
    def has_change_permission(self, request, obj=None):
        """
        Esta funcion determina si el usuario actual tiene permisos para editar un proyecto,
        Recibe el objeto request y el proyecto a ser editado (obj)
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        
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
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'
    
     
admin.site.register(Proyecto, ProyectoAdmin)

class FlujoAdmin(admin.ModelAdmin):
    ''' 
        Clase que crea el ABM y Listado del model Flujo
    '''
      
    list_display = ('nombre','descripcion','proyecto','accion')
    '''
    fieldsets = (
        (None, {'fields': ('nombre', 'descripcion','proyecto')}),
        (("actividades"), {
                'fields': ('actividades'),
            }),
        )
        '''
    search_fields=('nombre',)
    actions = None
    filter_horizontal = ('actividades',)
    #form=FlujoForm
    '''
    def get_form(self, request, obj=None, **kwargs):
        """
            En esta función se crea el form para flujo y solo se permite crear flujos
            dentro de los proyectos a los que esta asociado el usuario
        """
        class FluxForm(forms.ModelForm):
            
            class Meta:
                model=Flujo
            proyecto = forms.ModelChoiceField(queryset=User.objects.get(id=request.user.id).proyecto_set.all())
        return FluxForm     
        '''
    def has_change_permission(self, request, obj=None):
        """
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.proyecto_id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.proyecto_id)[0]
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_flujo").exists()
                else:
                    if request.GET.get('clonar','')!='':
                        permiso=Group.objects.get(pk=group.id).permissions.filter(codename="add_flujo").exists()
                    else:
                        permiso=Group.objects.get(pk=group.id).permissions.filter(codename="change_flujo").exists()
                return permiso
        return True
    
    def has_delete_permission(self, request, obj=None):
        """
        Retorna True si el usuario existente tiene un rol con el permiso para eliminar
        el flujo actual
        """
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.proyecto_id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.proyecto_id)[0]
                permiso=Group.objects.get(pk=group.id).permissions.filter(codename="delete_flujo").exists()
                return permiso
        opts = self.opts
        codename = get_permission_codename('change', opts)
        return request.user.has_perm("%s.%s" % (opts.app_label, codename))
        

    
    
    def get_queryset(self, request):
        """
        Retorna el queryset de proyectos a los que pertenece el usuario actual, 
        si es superusuario muestra todos los proyectos
        """

        qs = self.model._default_manager.get_queryset()
        if request.user.is_superuser:            
            qs=Flujo.objects.all()  
        else:
            ids=User.objects.get(id=request.user.id).proyecto_set.all().values('id')
            qs=Flujo.objects.filter(proyecto_id__in=ids)
        ordering = self.get_ordering(request)

        if ordering:
            qs = qs.order_by(*ordering)
        return qs
      
    def save_model(self, request, obj, form, change):
        '''
         En esta función se verifica si viene de la función Clonar o de la función Modificar
         en base a realiza las operaciones correspondientes
        '''
        if request.GET.get('clonar','')!='':
            obj.pk=None
        obj.save()
    
    def accion(self, obj):
        '''
            En esta función se crea un enlace para que aparezca en el listado y se pueda 
            ir a la opción "Clonar", que crea un Flujo a partir de uno existente 
        '''
        columna='<a href="/admin/Proyectos/flujo/'+str(obj.id)+'/?ver=1" class="btn btn-info btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>  '
        columna+='<a href="/admin/Proyectos/flujo/'+str(obj.id)+'/?clonar=1" class="btn btn-primary btn-small" rel="tooltip" title="Crea un flujo a partir de << '+obj.nombre+' >> "   ><i class="icon-retweet icon-white" ></i>  Clonar</a>'
        return columna
    
    accion.allow_tags = True
    accion.short_description = 'Acción'

admin.site.register(Flujo, FlujoAdmin)





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
            if request.user.groups.filter(rol__proyecto_id=obj.id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.id)[0]
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_equipo").exists()
                else:
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="change_equipo").exists()
                return permiso
        return True
    
    
    

admin.site.register(Equipo, EquipoAdmin)

class UserStoryAdmin(admin.ModelAdmin):
    ''' 
        Clase que crea el ABM y Listado del model UserStory
    '''
      
    list_display = ('id','tiempo_estimado','tiempo_trabajado','sprint','usuario','prioridad','descripcion','proyecto','accion')
    search_fields=('id',)
    list_filter=('sprint','proyecto','usuario')
    #list_filter=('usuario',)
    actions = None
    
    def get_form(self, request, obj=None, **kwargs):
        """
            En esta función se crea el form para userstory y solo se permite crear userstory
            dentro de los proyectos a los que esta asociado el usuario
        """
        class FluxForm(forms.ModelForm):
            class Meta:
                model=UserStory
            proyecto = forms.ModelChoiceField(queryset=User.objects.get(id=request.user.id).proyecto_set.all())
        return FluxForm     
        
    def has_change_permission(self, request, obj=None):
        """
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.proyecto_id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.proyecto_id)[0]
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_userstory").exists()
                return permiso
        return True
    
    def has_delete_permission(self, request, obj=None):
        """
        Retorna True si el usuario existente tiene un rol con el permiso para eliminar
        el userstory actual
        """
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.proyecto_id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.proyecto_id)[0]
                permiso=Group.objects.get(pk=group.id).permissions.filter(codename="delete_userstory").exists()
                return permiso
        opts = self.opts
        codename = get_permission_codename('change', opts)
        return request.user.has_perm("%s.%s" % (opts.app_label, codename))
        
        
    def generar_queryset(self,usuario):
        """
         Funcion que obtiene todos los userstory asociados a un usuario
        """
        if usuario.is_superuser:            
            qs=UserStory.objects.all()  
        else:
            qs=User.objects.get(id=usuario.id).userstory_set.all()
        return qs
    
    def get_queryset(self, request):
        """
        Retorna el queryset de userstory a los que pertenece el usuario actual, 
        si es superusuario muestra todos los proyectos
        """
        qs = self.generar_queryset(request.user)
        #qs = self.model._default_manager.get_queryset()
        
        ordering = self.get_ordering(request)
        
        if ordering:
            qs = qs.order_by(*ordering)
        return qs
    
    def accion(self, obj):
        '''
            En esta función se crea un enlace para que aparezca en el listado y se pueda 
            ir a la opción "Clonar", que crea un Flujo a partir de uno existente 
        '''
        columna='<a href="/admin/Proyectos/userstory/'+str(obj.id)+'/?ver=1" class="btn btn-info btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>  '
        return columna
    
    accion.allow_tags = True
    accion.short_description = 'Acción'

admin.site.register(UserStory,UserStoryAdmin)

class SprintAdmin(admin.ModelAdmin):
    '''
    clase que administra los sprint
    '''
    
    list_display=('fecha_inicio','fecha_fin','descripcion','accion')
    #fields=('sprint',)
    actions=None
    #form=SprintForm
    #filter_horizontal = ('userstory',)
    
      
    def accion(self, obj):
        '''En esta función se crea un enlace para que aparezca en el listado y se pueda 
        ir a la opción "ver" '''
        columna='<a href="/admin/Proyectos/sprint/'+str(obj.id)+'/?ver=1" class="btn btn-primary btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'
    
  
   
       
    def has_change_permission(self, request, obj=None):
        """
        Esta funcion determina si el usuario actual tiene permisos para editar un proyecto,
        Recibe el objeto request y el proyecto a ser editado (obj)
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.id)[0]
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_sprint").exists()
                else:
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="change_sprint").exists()
                return permiso
        return True


admin.site.register(Sprint,SprintAdmin)

class ActividadAdmin(admin.ModelAdmin):
    '''
    clase que administra las actividades
    '''
    
    actions=None
    list_display = ('nombre','descripcion','accion')
    
    def accion(self, obj):
        '''En esta función se crea un enlace para que aparezca en el listado y se pueda 
        ir a la opción "ver" '''
        columna='<a href="/admin/Proyectos/actividad/'+str(obj.id)+'/?ver=1" class="btn btn-primary btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
        return columna
    accion.allow_tags = True
    accion.short_description = 'Acción'

admin.site.register(Actividad,ActividadAdmin)
