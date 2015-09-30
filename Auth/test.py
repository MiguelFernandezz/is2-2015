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
        
    '''tests de usuario'''
    def test_usuario_full_name(self):
        Usuario1 = Usuario.objects.get(username="juanber")
        self.assertEqual(Usuario1.get_full_name(), "Juan Duarte") 
    
    def test_usuario_short_name(self):
        Usuario2= Usuario.objects.get(username="miguel")
        self.assertEquals(Usuario2.get_short_name(), "Miguel")
        
    def test_usuario_email(self):
        Usuario3 = Usuario.objects.get(username="miguel")
        self.assertEqual(Usuario3.email, "myguelfernandez@gmail.com")
        
    def test_usuario_password(self):
        Usuario4 = Usuario.objects.get(username="miguel")
        #print Usuario4.get_username()
        self.assertEqual(Usuario4.password, "password")
        
    def test_usuario_username(self):
        Usuario6 = Usuario.objects.get(first_name="Miguel")
        self.assertEqual(Usuario6.get_username(), "miguel")
        
    def test_usuario_is_authenticated(self):
        usuario = Usuario.objects.get(username = 'miguel')
        self.assertEqual(usuario.is_authenticated(),True)
        
    def test_usuario_set_check_password(self):
        usuario = Usuario.objects.get(username="juanber")
        passwd = "mi_password"
        usuario.set_password(passwd)
        self.assertEqual(usuario.check_password(passwd),True)        
    '''tests rol'''
    
    '''otros tests'''    
    def test_generate_password(self):
        usuario = Usuario.objects.get(username = "miguel")
        new_pass=generate_password()
        usuario.set_password(new_pass)
        self.assertEqual(usuario.check_password(new_pass),True)
        
    def test_internet_on(self):
        self.assertEqual(internet_on(), True)
        #self.assertEqual(internet_on(), False)
        
        
    #def test_send_mail(self):
    #   print forgot_password("miguel")
    #   respuesta = send_complex_message("new_pass","miguel","myguelfernadez@gmail.com")
    #   self.assertEqual(send_complex_message("new_pass","miguel","myguelfernadez@gmail.com"),respuesta)    
        
    
