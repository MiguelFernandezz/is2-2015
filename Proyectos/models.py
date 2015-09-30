# -*- coding: utf-8 -*- 
from django.db import models
from django.contrib.auth.models import User
from gi.overrides.keysyms import numerosign

ESTADOS_PROYECTO=(('INI','INICIADO'),
                  ('NOI','NO INICIADO'),
                  ('TER','TERMINADO'),
                  ('CAN','CANCELADO')
                   )

PRIORIDAD_USERSTORY=(('B','BAJA'),
                     ('N','NORMAL'),
                     ('A','ALTA')
                     )

ESTADO_USERSTORY=(('TO','TO DO'),
                  ('DG','DOING'),
                  ('DE','DONE')
                  )


class Proyecto(models.Model):
    '''
    clase Proyecto, se definen los atributos de un proyecto, hereda los metodos de Model
    '''
    class Meta:
        permissions = (("view_proyecto", "Can view proyecto"),
                       ("view_equipo", "Can view equipo"),
                       )
    nombre=models.CharField(max_length=50,unique=True,
                            help_text="El nombre del proyecto debe ser único. Máximo 50 caracteres.")
    descripcion=models.TextField()
    estado=models.CharField(max_length=3,choices=ESTADOS_PROYECTO,default='NOI')
    fecha_creacion=models.DateField(null=True)
    fecha_finalizacion=models.DateField(null=True,blank=True)
    equipo=models.ManyToManyField(User,null=True)
    
    def __unicode__(self):
        return self.nombre
    
class Actividad(models.Model):
    '''
    clase Actididad, se definen los atributos de un actividad, hereda de Model
    '''
    
    class Meta:
        verbose_name ='Actividad'
        verbose_name_plural = 'Actividades'
        permissions = (('view_actividad','can view actividad'),)
    nombre = models.CharField(max_length=20)
    descripcion = models.TextField()
    
    def __unicode__(self):
        return self.nombre
    

class Flujo(models.Model):
    '''
    clase flujo, se definen los atributos de un flujo, hereda de Model
    contine un manytomany a actividades para relacionar estas entidades
    '''
    class Meta:
        permissions = (("view_flujo", "Can view flujo"),)
    proyecto=models.ForeignKey(Proyecto)
    nombre=models.CharField(max_length=50,
                            help_text="Máximo 50 caracteres.")
    descripcion=models.TextField()
    actividades = models.ManyToManyField(Actividad,null=True,blank=True)
    
    def __unicode__(self):
        return self.nombre
    


class Equipo(Proyecto):
    '''clase equipo'''
    class Meta:
        proxy = True
        
class Sprint(models.Model):
    '''
    clase Sprint, se definen los atributos de un userstory, hereda de Model
    '''
    
    class Meta:
        permissions = (("view_sprint","can view sprint"),)
    
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    descripcion = models.TextField()
    
    def __unicode__(self):
        return str(self.fecha_inicio)
        
class UserStory(models.Model):
    '''
    clase UserStory, se definen los atributos de un userstory, hereda de Model
    '''
    class Meta:
        verbose_name ='User Story'
        verbose_name_plural = 'User stories'
        permissions = (("view_userstory", "Can view userstory"),)
    tiempo_estimado=models.IntegerField(help_text='tiempo en horas')
    tiempo_trabajado=models.IntegerField(help_text='tiempo en horas',default=0)
    descripcion=models.TextField()
    estado=models.CharField(max_length=2,choices=ESTADO_USERSTORY,default='TO')
    prioridad=models.CharField(max_length=1,choices=PRIORIDAD_USERSTORY,default='N')
    proyecto=models.ForeignKey(Proyecto, null=True, blank=True, default = None)
    usuario=models.ForeignKey(User, null=True, blank=True, default = None)
    sprint=models.ForeignKey(Sprint, null=True, blank=True, default = None)
    
    def __unicode__(self):
        return str(self.id)
    


    

    
#===============================================================================
# ESTADOS_ACTIVIDAD=(('TO DO','TO DO'),('DOING','DOING'),('DONE','DONE'))
# class Actividad(models.Model):
#     nombre=models.CharField(max_length=50,unique=True,help_text="Máximo 50 caracteres.")
#     descripcion=models.TextField()
#     estado=models.CharField(max_length=5,choices=ESTADOS_ACTIVIDAD)
#     
#     
#     
#===============================================================================
