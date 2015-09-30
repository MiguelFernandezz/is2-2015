from django import template
register = template.Library()


@register.filter(name='get_rol')
def get_rol(id):
    
    return True
