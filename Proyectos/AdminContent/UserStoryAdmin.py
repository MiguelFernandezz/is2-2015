# -*- coding: utf-8 -*-
'''
Created on 29/5/2015

@author: miguel
'''
from django.contrib import admin
from Proyectos.models import *
from Proyectos.forms import ComentarioForm, UserStoryForm
from django.views.generic.dates import timezone_today
from taguato.views import enviar_notificacion
from django.contrib.auth import get_permission_codename
from django.contrib.auth.models import Group

class ComentarioInLineUserstory(admin.TabularInline):
    '''Clase para el formulario de comentario en userstory'''
    model = Comentario
    form=ComentarioForm
    extra = 1
    can_delete=False

class ArchivoAdjuntoInLineUserstory(admin.TabularInline):
    '''Clase para cargar el archivo adjunto en el user story'''
    model = ArchivoAdjunto
    extra = 0
    can_delete=True
   
class UserStoryAdmin(admin.ModelAdmin):
    ''' 
        Clase que crea el ABM y Listado del model UserStory
    '''
    list_display = ('nombreUS','tiempo_estimado','tiempo_trabajado','usuario','prioridad','descripcion','proyecto','estado_actividad','accion')
    search_fields=('nombreUS',)
    list_filter=('proyecto','usuario','flujo','sprint','estado_actividad')
    
    inlines = [ArchivoAdjuntoInLineUserstory,ComentarioInLineUserstory]
    
    fieldsets = [
        ("Datos principales",{'fields':['nombreUS','tiempo_estimado','tiempo_trabajado','descripcion','prioridad',]}),
        #('Mas', {'fields':['usuario','sprint','flujo','actividad_flujo','estado_actividad','estado_sprint'],'classes': ['collapse']}),
        ('Asignaciones', {'fields':['usuario','sprint','flujo','actividad_flujo','estado_actividad','estado_sprint']}),
    ]
    form=UserStoryForm
    actions = None
    
 
    
    def save_formset(self, request, form, formset, change):
        """
        En esta funcion se guardan todos los inlines para almacenarlos en la base de datos,
        formset.save() devuelve una lista con todos los comentarios almacenados en la base de datos,
        despues de esto se le asignan el usuario que guardó el comentario.
        
        """
        comentarios=formset.save()
        for c in comentarios:
            c.username=request.user.username
            c.save()
    
    def save_model(self, request, obj, form, change):
        ''' En esta función se guardan los cambios correspondientes a usuarios,
        ya sea Agregar usuarios a equipo o Eliminar Usuario del equipo'''
        obj.backlog=False
        if change:
            original=UserStory.objects.get(pk=obj.id)
            ''' Se verificia si la cantidad de horas trabajadas'''
            if original.tiempo_trabajado != obj.tiempo_trabajado and obj.sprint:
                timeline=TimeLine()
                timeline.userstory=original
                timeline.fecha=timezone_today()
                timeline.horas=obj.tiempo_trabajado-original.tiempo_trabajado
                timeline.horas_restantes_sprint=obj.sprint.horas_faltantes()-obj.tiempo_trabajado
                timeline.horas_restantes_proyecto=obj.proyecto.horas_faltantes()-obj.tiempo_trabajado
                timeline.save()
            actual=obj.get_prioridad_display()
            anterior=UserStory.objects.get(pk=obj.id).get_prioridad_display()
            print actual,anterior
            if actual != anterior:
                aux="Cambio de prioridad al User Story"
                mensaje="Le informamos que el User Story al que pertenece ha cambiado de prioridad  <b>"+anterior+"</b>"
                mensaje+=" a prioridad <b>"+actual+"</b>"
                enviar_notificacion(asunto=aux, titulo1=aux, titulo2=aux,
                     mensaje=mensaje, username=obj.usuario.username, correo=obj.usuario.email)
            
        
        cambio_user=False
        if change and obj.usuario != None:
            if original.usuario_id != obj.usuario_id:
                cambio_user=True
                
        elif not change and obj.usuario != None:
            cambio_user=True
        
        if cambio_user:
            enviar_notificacion(asunto="User Story", titulo1="Asignacion de User Story", titulo2="Asignacion de User Story",
                             mensaje=" Le informamos que se le ha sido asignado el  User Story <b>"+obj.nombreUS+" </b>"
                             , username=obj.usuario.username, correo=obj.usuario.email)
        
        ''' En esta parte del codigo se verifica si hubo un cambio en la asignacion de flujo para luego enviar
        una notificacion por correo al usuario relacionado al User Story'''
        if obj.flujo != None:
            if not change or (change and obj.flujo_id != original.flujo_id):
                enviar_notificacion(asunto="User Story: Asignacion de Flujo", titulo1="Asignacion de Flujo", titulo2="Asignacion de Flujo ",
                mensaje=" Le informamos que se le ha sido asignado el Flujo <b>"+obj.flujo.nombre+"</b>  al User Story <b>"+obj.nombreUS+"</b>."
                             , username='obj.usuario.username', correo=obj.usuario.email)
                if obj.actividad_flujo != None:
                    siguiente=Actividad.objects.filter(flujo=obj.actividad_flujo.flujo).order_by('orden')
                    if siguiente.exists():
                        obj.actividad_flujo=siguiente[0]
                        obj.estado_actividad='TO'
                    
        if obj.estado_actividad=='DE' and obj.actividad_flujo != None:
            siguiente=Actividad.objects.filter(flujo=obj.actividad_flujo.flujo,orden=obj.actividad_flujo.orden+1)
            if siguiente.exists():
                obj.actividad_flujo=siguiente[0]
                obj.estado_actividad='TO'
            else:
                obj.estado_actividad='FD'
                
        '''esto sirve para controlar el estado del sprint'''
        if obj.sprint is not None:
            if obj.flujo is None:
                obj.estado_sprint = 'B'
            if obj.flujo is not None:
                obj.estado_sprint='F'
                
        '''esto controla que cuando se asigna a un flujo comienze en la actividad 1'''
        if not UserStory.objects.filter(pk=obj.id).exists():
            if obj.flujo != None:
                obj.actividad_flujo = Actividad.objects.get(flujo=obj.flujo, orden=1 )
        else:
            flujo_original=UserStory.objects.get(pk=obj.id).flujo
            if (flujo_original != obj.flujo):
                obj.actividad_flujo = Actividad.objects.get(flujo=obj.flujo, orden=1 )
                
        ''' esto es para pasar automaticamente a un estado doing
            si se agrega horas trabajas 
        '''
        if UserStory.objects.filter(pk=obj.id).exists():
            tiempo_trabajado_original = UserStory.objects.get(pk=obj.id).tiempo_trabajado
            if tiempo_trabajado_original != obj.tiempo_trabajado:
                estado_original = UserStory.objects.get(pk=obj.id).estado_actividad
                if estado_original == 'TO':
                    obj.estado_actividad = 'DG'
        
        if obj.proyecto == None:
            obj.proyecto = obj.sprint.proyecto
        
        
        obj.save()
        
        
        
     
    #def has_change_permission(self, request, obj=None):
        """
        Retorna True si el usuario existente tiene un rol con los permisos
        requeridos
        """
        
        '''
        if obj:
            if request.user.groups.filter(rol__proyecto_id=obj.proyecto_id).exists():
                group=request.user.groups.filter(rol__proyecto_id=obj.proyecto_id)[0]
                if request.GET.get('ver','')!='':
                    permiso=Group.objects.get(pk=group.id).permissions.filter(codename="view_userstory").exists()
                return permiso
        return True
        '''
    
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

