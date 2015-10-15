from django import template
register = template.Library()


@register.filter(name='get_rol')
def get_rol(id):
    
    return True

@register.filter(name='mult')
def mult(n1,n2):
    return n1*n2


@register.filter(name='user_stories')
def user_stories(actividades):
    '''
        Esta funcion recibe las actividades de un flujo y en base a eso formatea los user stories 
        para que aparezcan en forma ordenada en el tablero kanban 
    '''
    mayor=get_mayor(actividades)
    r=""
    
    for i in range(0,mayor):
        r+="<tr>"
        for j,a in enumerate(actividades):
            if len(a.us_todo())>i:
                     r+=get_url(a.us_todo()[i])
            else:
                r+="<td></td>"
            if len(a.us_doing())>i:
                      r+=get_url(a.us_doing()[i])
            else:
                r+="<td></td>"
            if len(a.us_done())>i:
                 r+=get_url(a.us_done()[i])
            else:
                r+="<td></td>"
            print r
        r+="</tr>"
        
    return r
def get_url(us):
    return "<td><a href='/admin/Proyectos/userstory/"+str(us.pk)+"'  title='"+us.descripcion+"' target='_blank'>"+us.nombreUS+"</a></td>"
    
def get_mayor(actividades):
    mayor=0
    for i,us in enumerate(actividades):
        if len(us.us_todo()) > mayor:
            mayor=len(us.us_todo())
        if len(us.us_doing()) > mayor:
            mayor=len(us.us_doing())
        if len(us.us_done()) > mayor:
            mayor=len(us.us_done())
    return mayor
