'''Modulo de test de las funciones del proyecto'''

from django.test import TestCase
from Auth.admin import Usuario
from Proyectos.models import  Comentario, Proyecto, Flujo, Actividad, UserStory, Sprint
from Proyectos.models import ESTADO_USERSTORY 
from Auth.models import Rol

from taguato.views import generate_password, internet_on, send_complex_message, forgot_password
                       

from django.contrib.auth.hashers import (
    check_password, make_password, is_password_usable)


class TaguatoTest(TestCase):
    '''clase que hereda de TestCase para realizar los test de las funciones'''
    def setUp(self):
        '''se crean objetos para los test'''
        #USUARIO
        Usuario.objects.create(username="miguel",first_name="Miguel",last_name="Fernandez",
                               email="myguelfernandez@gmail.com",password="password")
        Usuario.objects.create(username="juanber",first_name="Juan",last_name="Duarte",
                               email="juanber2.0@gmail.com")
        #PROYECTO
        Proyecto.objects.create(nombre='newProyecto',descripcion='una descripcion')
        p = Proyecto.objects.create(nombre='miProyecto',descripcion='unaDescripcion')
        #FLUJO
        f = Flujo.objects.create(id=1,nombre='nameFlujo',descripcion='descripcionDelFlujo',proyecto=p)
        Flujo.objects.create(id=2,nombre='flujo2',descripcion='descripcion flujo 1',proyecto=p)
        #ACTIVIDAD
        Actividad.objects.create(id=1,nombre='actividad1',descripcion='hola actividad1',flujo=f,orden=1)
        #USERSTORY
        us =UserStory.objects.create(id=1,nombreUS='us1',tiempo_estimado=10,tiempo_trabajado=0,descripcion='hola us1',proyecto=p,prioridad='N')
        #SPRINT
        sp1 = Sprint.objects.create(id=1,nombreSprint='sprint1',fecha_inicio="2015-04-25",fecha_fin="2015-05-01",descripcion="hola sprint1",proyecto=p)
        sp2 = Sprint.objects.create(id=2,nombreSprint='sprint2',fecha_inicio="2015-04-25",fecha_fin="2015-05-01",descripcion="hola sprint2",proyecto=p)
        #COMENTARIO
        Comentario.objects.create(id=1,username='miguel',texto='un comentario',userstory=us)
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
        
    '''test actividad'''
    
    def test_set_get_nombre_actividad(self):
        actividad= Actividad.objects.get(nombre='actividad1')
        new_nombre = 'actividad2'
        actividad.nombre= new_nombre
        self.assertEqual(actividad.nombre, 'actividad2')
        
    def test_set_get_descripcion_actividad(self):
        actividad=Actividad.objects.get(nombre='actividad1')
        new_descipcion = 'nueva descripcion 2'
        actividad.descripcion = new_descipcion
        self.assertEqual(actividad.descripcion, 'nueva descripcion 2')
    
    
    '''test user story'''
    
    def test_set_get_tiempo_estimado(self):
        userstory = UserStory.objects.get(id=1)
        new_tiempo_estimado= 5
        userstory.tiempo_estimado=new_tiempo_estimado
        self.assertEqual(userstory.tiempo_estimado, 5)
        
    def test_set_get_tiempo_trabajado(self):
        userstory = UserStory.objects.get(id=1)
        new_tiempo_trabajado = 3
        userstory.tiempo_trabajado = new_tiempo_trabajado
        self.assertEqual(userstory.tiempo_trabajado, 3)
        
    def test_set_get_descripcion(self):
        userstory = UserStory.objects.get(id=1)
        new_descripcion = 'nueva descripcion'
        userstory.descripcion = new_descripcion
        self.assertEqual(userstory.descripcion,'nueva descripcion')
        
    def test_asignar_userstory_a_proyecto(self):
        userstory = UserStory.objects.get(id=1)
        proyecto = Proyecto.objects.get(nombre='newProyecto')
        userstory.proyecto = proyecto
        self.assertEqual(userstory.proyecto,proyecto)
        
    def test_cambiar_prioridad(self):
        userstory = UserStory.objects.get(id=1)
        userstory.prioridad = 'B'
        self.assertEqual(userstory.prioridad,'B')
        
    def test_cambiar_estado(self):
        userstory = UserStory.objects.get(id=1)
        userstory.estado_actividad = 'DG'
        self.assertEqual(userstory.estado_actividad,'DG')
    def test_asignar_usuario (self):
        userstory = UserStory.objects.get(id=1)
        usuario = Usuario.objects.get(username="miguel")
        userstory.usuario = usuario
        self.assertEqual(userstory.usuario.username,'miguel')
    def test_asignar_flujo(self):
        userstory = UserStory.objects.get(id=1)
        flujo = Flujo.objects.get(id=1)
        userstory.flujo = flujo
        self.assertEqual(userstory.flujo.nombre,'nameFlujo')
        
    def test_cambiar_actividad(self):
        userstory = UserStory.objects.get(id=1)
        actividad = Actividad.objects.get(id=1)
        userstory.actividad = actividad
        self.assertEqual(userstory.actividad.nombre,'actividad1')
    def test_asignar_sprint(self):
        userstory = UserStory.objects.get(id=1)
        sprint = Sprint.objects.get(id=1)
        userstory.sprint = sprint
        self.assertEqual(userstory.sprint.nombreSprint,'sprint1')
        
    
    '''test Sprint'''
    
    def test_get_set_nombreUS(self):
        sprint = Sprint.objects.get(id=1)
        new_nombreSprint= 'new name Sprint'
        sprint.nombreSprint = new_nombreSprint
        self.assertEqual(sprint.nombreSprint,'new name Sprint')
    
    def test_get_set_descripcion(self):
        sprint = Sprint.objects.get(id=1)
        new_descripcion= 'nueva descripcion'
        sprint.descripcion=new_descripcion
        self.assertEqual(sprint.descripcion,'nueva descripcion')
        
    def test_get_set_fecha_inicio(self):
        sprint = Sprint.objects.get(id=1)
        sprint.fecha_inicio = "2016-04-26"
        self.assertEqual(sprint.fecha_inicio, "2016-04-26")
        
    def test_get_set_fecha_fin(self):
        sprint = Sprint.objects.get(id=1)
        sprint.fecha_fin = "2016-04-26"
        self.assertEqual(sprint.fecha_fin, "2016-04-26")
        
    '''test Comentario'''
    def test_crear_comentario(self):
        us = UserStory.objects.get(id=1)
        comentario = Comentario.objects.create(id=2,username='juanber',texto='un comentario',userstory=us)   
        self.assertEqual(comentario.id,2)
    def test_get_set_texto(self):
        comentario = Comentario.objects.get(id=1)
        new_texto= 'new comentario'
        comentario.texto = new_texto
        self.assertEqual(comentario.texto,'new comentario')
        
    def test_get_set_username(self):
        comentario = Comentario.objects.get(id=1)
        new_username = 'new username'
        comentario.username = new_username
        self.assertEqual(comentario.username,'new username')
        
    
    