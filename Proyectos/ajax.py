import json
from dajaxice.decorators import dajaxice_register
from django.contrib.auth.models import User, Group, Permission
from Auth.models import Rol
from Proyectos.models import Actividad

@dajaxice_register
def get_rol(request,lista,proyecto_id):
    usuarios=[]
    for id in lista:        
        usuario=User.objects.get(pk=id)
        grupos= usuario.groups.all()
                
        if len(grupos)>0:
            for grupo in grupos:
                data_perms=[]
                permisos= Permission.objects.raw("select p.* from auth_group_permissions a join auth_permission p on p.id=a.permission_id where group_id="+str(grupo.id))
                for p in permisos:
                   data_perms.append(p.name)
            data_group=[{'name':grupo.name,'permisos':data_perms}]
            data_user={'user':usuario.username,'grupos':data_group}
            usuarios.append(data_user)
    return json.dumps({'usuarios':usuarios})


@dajaxice_register
def get_actividades(request,id_flujo):
    actividades=Actividad.objects.filter(flujo_id=id_flujo)
    lista=[]
    print actividades
    for a in actividades:
        data={'id':a.id,'nombre':a.nombre}
        lista.append(data)
    return json.dumps({'actividades':lista})



