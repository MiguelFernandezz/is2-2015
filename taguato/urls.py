"""Modulo de drecciones url"""

from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.views.generic.base import TemplateView
from django.views.generic import RedirectView
from dajaxice.core import dajaxice_autodiscover, dajaxice_config
from django.conf import settings
from django.conf.urls.static import static
import Proyectos

dajaxice_autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'taguato.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    
    url(dajaxice_config.dajaxice_url, include('dajaxice.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', RedirectView.as_view(url='/admin/')),
    url(r'^admin/recuperar_password/$', 'taguato.views.forgot_password'),
    url(r'^prueba/$', TemplateView.as_view(template_name='admin/prueba.html')),
    url(r'^admin/Proyectos/kanban/(?P<id>.+)/', 'Proyectos.views.tablero_kanban'),
    url(r'^admin/Proyectos/burndownchart/(?P<id>.+)/', 'Proyectos.views.burndown_chart'),
    url(r'^admin/Proyectos/burndownchart1/(?P<id>.+)/', 'Proyectos.views.burndown_chart1'),
    url(r'^admin/Proyectos/burndownchart2/(?P<id>.+)/', 'Proyectos.views.burndown_chart2'),
    url(r'^admin/Proyectos/proyectos/burndownchart2/(?P<id>.+)/', 'Proyectos.views.proyecto_burndown_chart2'),
    url(r'^admin/Proyectos/proyectos/burndownchart1/(?P<id>.+)/', 'Proyectos.views.proyecto_burndown_chart1'),
    url(r'^admin/Proyectos/release/(?P<id>.+)/$', 'Proyectos.views.crear_release'),
    url(r'^admin/Proyectos/releases/(?P<id>.+)/$', 'Proyectos.views.ver_releases'),
    url(r'^admin/Proyectos/informes/(?P<id>.+)/', 'Proyectos.views.informes'),
    url(r'^admin/Proyectos/Reportes/Sprints/(?P<id>.+)/$', 'Proyectos.views.sprints_del_proyecto'),
    url(r'pdf2/(?P<id>.+)/$','Proyectos.views.cantidad_de_trabajo_por_usuario' ),
    url(r'pdf1/(?P<id>.+)/$','Proyectos.views.cantidad_de_trabajo' ),
    url(r'pdf3/(?P<id>.+)/$','Proyectos.views.lista_de_us_todo' ),
    url(r'pdf4/(?P<id>.+)/$','Proyectos.views.tiempo_proyecto_grafica' ),
    url(r'pdf5/(?P<id>.+)/$','Proyectos.views.lista_de_backlog' ),
    url(r'pdf6/(?P<idProyecto>.+)/(?P<idSprint>.+)/$','Proyectos.views.sprint_backlog' ),
    url(r'^files/', include('db_file_storage.urls')),
    
    #    url(r'^admin/(?P<content_type_id>\d+)/(?P<object_id>.d+)/ver',Template.as_view(),name='view_on_site'),
    
    
)+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)