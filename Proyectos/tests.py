'''Modulo de test de las funciones del proyecto'''

from django.test import TestCase
from Auth.admin import Usuario
from Proyectos.models import  Proyecto, Flujo
from Auth.models import Rol

from taguato.views import generate_password, internet_on, send_complex_message, forgot_password
                       

from django.contrib.auth.hashers import (
    check_password, make_password, is_password_usable)


class TaguatoTest(TestCase):
    '''clase que hereda de TestCase para realizar los test de las funciones'''
    def setUp(self):
        '''se crean objetos para los test'''
        
        Usuario.objects.create(username="miguel",first_name="Miguel",last_name="Fernandez",
                               email="myguelfernandez@gmail.com",password="password")
        Usuario.objects.create(username="juanber",first_name="Juan",last_name="Duarte",
                               email="juanber2.0@gmail.com")
        
        Proyecto.objects.create(nombre='newProyecto',descripcion='una descripcion')
        p = Proyecto.objects.create(nombre='miProyecto',descripcion='unaDescripcion')
        Flujo.objects.create(nombre='nameFlujo',descripcion='descripcionDelFlujo',proyecto=p)
        
        #Rol.objects.create(name='nuevoRol')
    
    '''tests de proyecto'''    
    def test_proyecto_set_get_nombre(self):
        proyecto = Proyecto.objects.get(nombre='newProyecto')
        new_nombre = "newProyecto2"
        proyecto.nombre = new_nombre
        self.assertEqual(proyecto.nombre, "newProyecto2")
        
    def test_proyecto_set_get_descripcion(self):
        proyecto = Proyecto.objects.get(nombre='newProyecto')
        new_descripcion = 'nueva descripcion'
        proyecto.descripcion = new_descripcion
        self.assertEqual(proyecto.descripcion, 'nueva descripcion')
        
    '''tests flujo'''
    def test_flujo_get_set_nombre(self):
        flujo = Flujo.objects.get(nombre='nameFlujo')
        new_name = 'flujoName'
        flujo.nombre = new_name
        self.assertEqual(flujo.nombre,'flujoName')
        
    def test_flujo_get_set_descripcion(self):
        flujo = Flujo.objects.get(nombre='nameFlujo')
        new_descripcion='flujoDescripcion'
        flujo.descripcion = new_descripcion
        self.assertEqual(flujo.descripcion,'flujoDescripcion')
    
    def test_flujo_proyecto(self):
        p1 = Proyecto.objects.get(nombre='miProyecto')
        flujo = Flujo.objects.get(nombre='nameFlujo')
        self.assertEqual(flujo.proyecto.nombre,p1.nombre)
        
    
        
        
    #def test_send_mail(self):
    #   print forgot_password("miguel")
    #   respuesta = send_complex_message("new_pass","miguel","myguelfernadez@gmail.com") 
    #   self.assertEqual(send_complex_message("new_pass","miguel","myguelfernadez@gmail.com"),respuesta)    
        
    
    