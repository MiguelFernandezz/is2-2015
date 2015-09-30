# -*- coding: utf-8 -*- 
from django.contrib import admin
from django.contrib.auth.models import User, Group
from django.utils.translation import ugettext, ugettext_lazy as _

from django.contrib.auth.admin import UserAdmin, GroupAdmin
from django.contrib.auth.forms import UserChangeForm
#from apt_offline_core.AptOfflineCoreLib import app_name
from Auth.models import Usuario, Rol
from Auth.forms import RolForm, UsuarioForm

 
class UsuarioAdmin(UserAdmin):
    '''Clase que admnistra usuarios (ABM) (listado de usuarios).
       Hereda todos los metodos y atributos de UserAdmin (django)
    '''
    list_display=('username','email','first_name','last_name','accion')
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        (_('Personal info'), {'fields': ('first_name', 'last_name', 'email')}),
        (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser',
                                       'groups')}),
        (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    )
    form=UsuarioForm
  
    def accion(self, obj):
        ''' 
            Metodo que genera la opcion "Ver" en la lista de Usuarios.
        '''
        return '<a href="/admin/auth/usuario/'+str(obj.id)+'/?ver=1" class="btn btn-primary btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
    accion.allow_tags = True
    accion.short_description = 'Accion'
    

        
admin.site.unregister(User)
admin.site.register(Usuario, UsuarioAdmin)


class RolAdmin(GroupAdmin):
    '''
        Clase que se realiza el ABM y Listado de la clase Rol.
        Hereda todos los atributos y metodos de GroupAdmin (django)
    '''
    actions=None
    list_display=('name','proyecto','accion')
   # form=RolForm
    def accion(self, obj):
        ''' 
            Metodo que genera la opcion "Ver" en la lista de Roles.
        '''
        return '<a href="/admin/auth/rol/'+str(obj.id)+'/?ver=1" class="btn btn-primary btn-small"><i class="icon-eye-open icon-white"></i>  Ver</a>'
    accion.allow_tags = True
    accion.short_description = 'Accion'
    

  
    
  

admin.site.unregister(Group)
admin.site.register(Rol, RolAdmin)
