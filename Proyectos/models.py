# -*- coding: utf-8 -*- 
from django.db import models
from django.contrib.auth.models import User
from datetime import datetime
from django.views.generic.dates import timezone_today
from django.utils.timezone import now
from django.db.models.aggregates import Sum
from django.core.urlresolvers import reverse
import os



ESTADOS_PROYECTO=(('INI','INICIADO'),
                  ('NOI','NO INICIADO'),
                  ('TER','TERMINADO'),
                  ('CAN','CANCELADO')
                   )

PRIORIDAD_USERSTORY=(('B','BAJA'),
                     ('N','NORMAL'),
                     ('A','ALTA')
                     )

ESTADO_USERSTORY=(('--','------'),
                  ('TO','TO DO'),
                  ('DG','DOING'),
                  ('DE','DONE'),
                  ('FD','FLUJO DONE'),
                  ('FI','FINALIZADO')
                  )

ESTADO_SPRINT=(('N','---------'),
               ('B','SPRINT BACKLOG'),
                  ('F','EN FLUJO')
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
    fecha_creacion=models.DateField(null=True,default=datetime.now())
    fecha_inicio=models.DateField(null=True,blank=True)
    fecha_finalizacion=models.DateField(null=True,blank=True)
    equipo=models.ManyToManyField(User,null=True)
    
    def __unicode__(self):
        return self.nombre
    
    def total_horas(self):
         total_horas=UserStory.objects.filter(proyecto=self).aggregate(Sum('tiempo_estimado'))['tiempo_estimado__sum']
         if not total_horas:
             return 0
         return total_horas
     
    def horas_faltantes(self):
        horas=UserStory.objects.filter(proyecto=self).aggregate(Sum('tiempo_trabajado'))['tiempo_trabajado__sum']
        if not horas:
            horas=0
        return self.total_horas()-horas
    


class Sprint(models.Model):
    '''
    clase Sprint, se definen los atributos de un userstory, hereda de Model
    '''
    class Meta:
        permissions = (("view_sprint","can view sprint"),)
    
    nombreSprint = models.CharField(max_length=50)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    descripcion = models.TextField()
    proyecto = models.ForeignKey(Proyecto)
    finalizado=models.BooleanField(default=False)
    
    def total_horas(self):
         total_horas=UserStory.objects.filter(sprint=self).aggregate(Sum('tiempo_estimado'))['tiempo_estimado__sum']
         if not total_horas:
             return 0
         return total_horas
    
    def horas_faltantes(self):
        horas=UserStory.objects.filter(sprint=self).aggregate(Sum('tiempo_trabajado'))['tiempo_trabajado__sum']
        if not horas:
            horas=0
        return self.total_horas()-horas
    
    def __unicode__(self):
        return self.nombreSprint

class Actividad(models.Model):
    '''
    clase Actididad, se definen los atributos de un actividad, hereda de Model
    '''
    class Meta:
        verbose_name ='Actividad'
        verbose_name_plural = 'Actividades'
        permissions = (('view_actividad','can view actividad'),)
    nombre = models.CharField(max_length=20)
    descripcion = models.CharField(max_length=200)
    flujo= models.ForeignKey("Flujo")
    orden=models.IntegerField(help_text='secuencia de las actividades')
    
    def __unicode__(self):
        return self.nombre
    
    def us_todo(self):
        return UserStory.objects.filter(actividad_flujo=self,estado_actividad='TO')
    
    def us_doing(self):
        return UserStory.objects.filter(actividad_flujo=self,estado_actividad='DG')
    
    def us_done(self):
        return UserStory.objects.filter(actividad_flujo=self,estado_actividad='DE')
    
class Flujo(models.Model):
    '''
    clase flujo, se definen los atributos de un flujo, hereda de Model
    contine un manytomany a actividades para relacionar estas entidades
    '''
    class Meta:
        permissions = (("view_flujo", "Can view flujo"),)
    proyecto=models.ForeignKey(Proyecto)
    sprint = models.ForeignKey(Sprint,null=True,blank=True)
    nombre=models.CharField(max_length=50,help_text="Máximo 50 caracteres.")
    descripcion=models.TextField()
    #userstories = models.ManyToManyField(UserStory,null=True,blank=True)
    #actividades = models.ManyToManyField(Actividad,null=True,blank=True)
    def actividades(self):
        return Actividad.objects.filter(flujo=self).order_by('orden')
    
   
    def actividades_count(self):
        return Actividad.objects.filter(flujo=self).count()
    
    def __unicode__(self):
        return self.nombre
    

class UserStory(models.Model):
    '''
    clase UserStory, se definen los atributos de un userstory, hereda de Model
    '''
    class Meta:
        verbose_name ='User Story'
        verbose_name_plural = 'User stories'
        permissions = (("view_userstory", "Can view userstory"),)
    
    '''datos basicos de del userstory'''    
    nombreUS = models.CharField(max_length=50) 
    tiempo_estimado=models.IntegerField(help_text='tiempo en horas')
    tiempo_trabajado=models.IntegerField(help_text='tiempo en horas',default=0)
    descripcion=models.TextField()
    prioridad=models.CharField(max_length=1,choices=PRIORIDAD_USERSTORY,default='N')
    '''relaciones con otras entidades'''
    proyecto=models.ForeignKey(Proyecto, null=True, blank=True, default = None)
    usuario=models.ForeignKey(User, null=True, blank=True, default = None)
    sprint=models.ForeignKey(Sprint, null=True,blank=True,default = None)
    flujo=models.ForeignKey(Flujo, null=True, blank=True, default= None)
    actividad_flujo=models.ForeignKey(Actividad, null=True, blank=True, default = None)
    '''estado dentro del flujo'''
    estado_actividad=models.CharField(max_length=2,choices=ESTADO_USERSTORY,null=True,default='TO')
    '''estado dentro del sprint'''
    estado_sprint=models.CharField(max_length=1,choices=ESTADO_SPRINT,null=True,default='N')
    backlog=models.BooleanField(default=True)
    
    
    def __unicode__(self):
        return self.nombreUS
    
    def __str__(self):
        return self.nombreUS
class Comentario(models.Model):
    '''
    clase Comentario, se definen los atributos de un comentario, hereda de Model
    '''
    class Meta :
        permissions = (('view_comentario','can view comentario'),)
    texto = models.TextField()
    fecha=models.DateTimeField(default=now)
    userstory = models.ForeignKey(UserStory)
    username=models.CharField(max_length=50,null=True,blank=True)

    def __unicode__(self):
        return str(self.fecha)

# third party imports
from db_file_storage.model_utils import delete_file, delete_file_if_needed


class ArchivoAdjunto(models.Model):
    class Meta:
        verbose_name ='Archivo Adjunto'
        verbose_name_plural = 'Archivos Adjuntos'
        permissions = (('view_archivoadjunto','can view archivoadjunto'),)
    userstory = models.ForeignKey(UserStory)
    #archivo = models.FileField(upload_to='.')
    
    archivo = models.FileField(
        #upload_to='Proyectos.Archivo/bytes/filename/mimetype',
        upload_to='Proyectos.Archivo/bytes/filename/mimetype',
        blank=True,
        null=True
    )
    
    
    
    def get_absolute_url(self):
        return reverse('archivoAdjunto.edit', kwargs={'pk': self.pk})
    
    def save(self, *args, **kwargs):
        delete_file_if_needed(self, 'archivo')
        super(ArchivoAdjunto, self).save(*args, **kwargs)

    def delete(self, *args, **kwargs):
        super(ArchivoAdjunto, self).delete(*args, **kwargs)
        delete_file(self, 'archivo')
    
   
    
class Equipo(Proyecto):
    '''clase equipo'''
    class Meta:
        proxy = True
        
class TimeLine(models.Model):
    ''' Esta clase permite almacenar los datos del UserStory que 
    se utilizaran para realizar el burndown chart 
    '''
    userstory=models.ForeignKey(UserStory)
    horas=models.IntegerField()
    fecha=models.DateField()
    horas_restantes_sprint=models.IntegerField()
    horas_restantes_proyecto=models.IntegerField()
    
class BackLog(UserStory):
    '''clase BackLog'''
    class Meta:
        verbose_name = 'Backlog'
        verbose_name_plural = 'Backlogs'
        proxy = True

class Release(models.Model):
    ''' Modelo para guardar todos los userstories finalizados cuyos sprints hayan
    llegado a su fecha fin ''' 
    proyecto=models.ForeignKey(Proyecto)
    fecha=models.DateTimeField()
    userstories=models.ManyToManyField(UserStory)
    

class Archivo(models.Model):
    bytes = models.TextField()
    filename = models.CharField(max_length=255)
    mimetype = models.CharField(max_length=50)

    def __unicode__(self):
        return self.filename
