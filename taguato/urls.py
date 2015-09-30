"""Modulo de drecciones url"""

from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.contrib.contenttypes import views as contenttype_views
from functools import update_wrapper
from django.views.generic.base import TemplateView
from dajaxice.core import dajaxice_autodiscover, dajaxice_config
dajaxice_autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'taguato.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    
    url(dajaxice_config.dajaxice_url, include('dajaxice.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^admin/recuperar_password/$', 'taguato.views.forgot_password'),
    url(r'^prueba/$', TemplateView.as_view(template_name='admin/prueba.html')),
    
#    url(r'^admin/(?P<content_type_id>\d+)/(?P<object_id>.d+)/ver',Template.as_view(),name='view_on_site'),
    
    
)
