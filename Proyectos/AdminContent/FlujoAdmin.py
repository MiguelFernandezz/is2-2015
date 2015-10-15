# -*- coding: utf-8 -*- 
'''
Created on 29/5/2015

@author: juanber
'''
from django.contrib import admin
from Proyectos.models import UserStory, Actividad, Flujo
from django import forms
from Proyectos.forms import FlujoForm
from django.contrib.auth.models import Group, User
from django.contrib.auth import get_permission_codename

class userstoryInLineFlujo(admin.TabularInline):
    '''Clase para el formulario de userstory en flujo'''
    model = UserStory
    exclude = ['sprint','actividad_flujo','estado_flujo','estado_sprint']
    extra = 0
    
    

class ActividadInlineFormset(forms.models.BaseInlineFormSet):
    '''Clase que contrala la secuencialidad de las actividades'''

    def es_secuencial(self,deleted_orden=[]):
        '''
            Metodo que verifica que todas las actividades sean secuenciales,
            deleted_orden recibe una lista con numeros de orden correspondientes a las 
            actividades que se desean eliminar, en base a esto se verifica si al eliminar
            las actividades se mantenga la secuencia de actividades
            
        '''
        orden_list=[]
        for a in self:
            if not a.cleaned_data['orden'] in deleted_orden:
                orden_list.append(a.cleaned_data['orden'])
        orden_list.sort()
        
        secuencial=True
        for i,a in enumerate(orden_list):
            if i > 0:
                if orden_list[i]- orden_list[i-1] !=1:
                    secuencial=False
        return secuencial
        
    def is_deleted_orden(self):
        '''
            Metodo que obtiene la lista de todos los numeros de secuencia que se desean eliminar
        '''
        deleted_list = []
        for form in self.forms:
            try:
                if form.cleaned_data:
                    if form.cleaned_data['DELETE']:
                        deleted_list.append(form.cleaned_data['orden'])
            except AttributeError:
                pass
        return deleted_list
    
    def verificar(self):
        error=""
       
        if not self.es_secuencial():
            error='Los numeros de orden de las actividades deben ser secuenciales.'
        
        deleted_orden=self.is_deleted_orden()
        if len(deleted_orden)!=0:
            '''
                Se verifica que si existen elementos a ser eliminados se mantenga el numero de secuencia de
                actividadades
            '''
            if not self.es_secuencial(deleted_orden=deleted_orden):
                error='Verifique la secuencia de las actividades antes de eliminar'
        return error
        
        
    def clean(self):
        error=self.verificar()
        if error !="":
            raise forms.ValidationError(error)
        
        

class ActividadInLineFlujo(admin.TabularInline):
    '''Clase para el formulario de actifidad en flujo'''
    model = Actividad
    extra = 0
    formset=ActividadInlineFormset
    

class FlujoAdmin(admin.ModelAdmin):
    ''' 
        Clase que crea el ABM y Listado del model Flujo
    ''' 
    list_display = ('nombre','descripcion','proyecto','accion')

    search_fields=('nombre',)
    actions = None
    form=FlujoForm
 
    inlines = [ActividadInLineFlujo,]
    
  
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
        columna+='<a href="/admin/Proyectos/flujo/'+str(obj.id)+'/?clonar=1" class="btn btn-primary btn-small" rel="tooltip" title="Crea un flujo a partir de << '+obj.nombre+' >> "   ><i class="icon-retweet icon-white" ></i>  Clonar</a> '
        columna+='<a href="/admin/Proyectos/kanban/'+str(obj.id)+'/" class="btn btn-warning btn-small"><i class="icon-eye-open icon-white"></i>  Tablero Kanban</a>  '
        return columna
    
    accion.allow_tags = True
    accion.short_description = 'Acción'
    