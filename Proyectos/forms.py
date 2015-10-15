# -*- coding: utf-8 -*- 
from django import forms
from django.contrib.auth.models import User
from django.contrib.admin.widgets import *
from Proyectos.models import * 
from django.utils.timezone import now
from django.forms.fields import SplitDateTimeField
from django.forms.widgets import SplitDateTimeWidget
from django.db.models import Q
from django.forms.models import BaseModelFormSet

class EquipoForm(forms.ModelForm):
    class Meta:
        model=Proyecto
        exclude=[]
    equipo = forms.ModelMultipleChoiceField(queryset=User.objects.filter(is_active=True),
                                          label='Añadir Usuarios al Equipo',
                                          required=False,
                                          widget=FilteredSelectMultiple(
                                                    'Usuarios',
                                                    False,
                                                 ))
    
    
class FlujoForm(forms.ModelForm):
    class Meta:
        model=Flujo
        exclude=[]
    proyecto = forms.ModelChoiceField(queryset=Proyecto.objects.all())
    
    '''
    def clean_nombre(self):
        p = self.instance.proyecto
        
        if p.estado == 'TER':
            raise forms.ValidationError("El proyecto ha finalizado, no se puede editar")
        
        return self.cleaned_data.get('nombre')
     '''   
    
    def clean_proyecto(self):
        id_flujo = self.instance.pk
        if Flujo.objects.filter(pk=id_flujo).exists():
            anterior=Flujo.objects.get(pk=id_flujo).proyecto
            actual=self.cleaned_data.get('proyecto')
            if anterior != actual:
                raise forms.ValidationError("no se puede asignar a otro proyecto")
            
        return self.cleaned_data.get('proyecto')
            
    




class ComentarioForm(forms.ModelForm):
    class Meta:
        model=Comentario
        fields=('texto','fecha','username')
        exclude=[]
    texto=forms.CharField(widget=forms.Textarea(attrs={'rows':2,'style':'width: 400px','class':'textarea'}),label="texto")
    fecha=SplitDateTimeField(widget=SplitDateTimeWidget(attrs={'style':'width: 80px; text-align: center'}),label="fecha y Hora",required=False)
    
    
    
    def __init__(self, *args, **kwargs):
        super(ComentarioForm, self).__init__(*args, **kwargs)
        self.fields['fecha'].widget.attrs['readonly'] = 'readonly'
        self.fields['fecha'].value=now
        self.fields['username'].widget.attrs['readonly'] = 'readonly'
        self.fields['username'].widget.attrs['class'] = 'username'
        
class SprintForm(forms.ModelForm):
    class Meta:
        model=Sprint
        fields='__all__'
        exclude=['finalizado']
    

    def clean(self):
        """
            En esta función se hace los controles necesarios para evitar que haya superposición entre las
            fechas de un Sprint y otros.
        """
        id_sprint=None
        if hasattr(self.instance, 'pk'):
            id_sprint=self.instance.pk
        error=""
        validations=[]
        fecha_inicio=self.cleaned_data.get('fecha_inicio')
        fecha_fin=self.cleaned_data.get('fecha_fin')
        proyecto=self.cleaned_data.get('proyecto')
        
        if id_sprint:
            sprints=Sprint.objects.filter(fecha_inicio__lt=fecha_inicio,fecha_fin__gt=fecha_inicio
                                          ,proyecto=proyecto).exclude(pk=id_sprint).order_by('fecha_fin')
        else:
            sprints=Sprint.objects.filter(fecha_inicio__lt=fecha_inicio,fecha_fin__gt=fecha_inicio
                                          ,proyecto=proyecto).order_by('fecha_fin')
                                          
        if sprints.exists():
            error="no puede haber un sprint con fecha de inicio antes de fecha fin de otro sprint."
            error+="\nFecha de inicio sugerida: "+str(sprints[0].fecha_fin)
            validations.append(forms.ValidationError(error, code='Fecha de inicio invalida'))
        if id_sprint: 
            sprints=Sprint.objects.filter(fecha_inicio__lt=fecha_fin,fecha_fin__gt=fecha_fin,
                                      proyecto=proyecto).exclude(pk=id_sprint).order_by('fecha_fin')
        else:
            sprints=Sprint.objects.filter(fecha_inicio__lt=fecha_fin,fecha_fin__gt=fecha_fin,
                                      proyecto=proyecto).order_by('fecha_fin')
        if sprints.exists():
            error="no puede haber un sprint con fecha fin posterior a la fecha de inicio"\
            " y anterior a la fecha fin de otro sprint."
            validations.append(forms.ValidationError(error, code='Fecha de fin invalida'))
        if id_sprint:
            sprints=Sprint.objects.filter(fecha_inicio__gte=fecha_inicio,fecha_fin__lte=fecha_fin,
                                      proyecto=proyecto).exclude(pk=id_sprint).order_by('fecha_fin')
        else:
            sprints=Sprint.objects.filter(fecha_inicio__gte=fecha_inicio,fecha_fin__lte=fecha_fin,
                                      proyecto=proyecto).order_by('fecha_fin')
        if sprints.exists():
            error="Ya hay un Sprint en medio de estas dos fechas '"+str(fecha_inicio)+"' y '"+str(fecha_fin)+"' "
            validations.append(forms.ValidationError(error, code='Rango de fechas invalido'))
        
        if fecha_fin < fecha_inicio:
            error="Fecha de inicio debe ser menor a Fecha fin."
            validations.append(forms.ValidationError(error, code='Error2'))
        
        if validations:
            raise forms.ValidationError(validations)


  
class UserStoryForm(forms.ModelForm):
    class Meta:
        model=UserStory
        fields='__all__'
        exclude=[]
        
    def clean_nombreUS(self):
        p= None
        p = UserStory.objects.get(pk=self.instance.pk).proyecto
        if UserStory.objects.filter(pk=self.instance.pk).exists()and self.instance.backlog == False: 
            p = UserStory.objects.get(pk=self.instance.pk).proyecto
            print 'estado proyecto  '+ p.estado
        if UserStory.objects.filter(pk=self.instance.pk).exists():
            estado_us=UserStory.objects.get(pk=self.instance.pk).estado_actividad
        if estado_us == 'FI':
            raise forms.ValidationError("El User Story o proyecto ha finalizado, no se puede editar")
        
        if p.estado == 'TER':
            raise forms.ValidationError("El User Story o proyecto ha finalizado, no se puede editar")
        
        return self.cleaned_data.get('nombreUS')
   
    def clean_usuario(self):
        usuario=self.cleaned_data.get('usuario')
        if usuario == None:
            raise forms.ValidationError("este campo no puede ser nulo")
        return self.cleaned_data.get('usuario')
    
    def clean_sprint(self):
        sprint=self.cleaned_data.get('sprint')
        if sprint == None:
            raise forms.ValidationError("Este campo no puede estar vacio" )
        if sprint != None:
            if hasattr(self.instance, 'pk'):
                id_us=self.instance.pk 
                if UserStory.objects.filter(pk=id_us).exists():
                    anterior=UserStory.objects.get(pk=id_us).sprint
                    actual=self.cleaned_data.get('sprint')
                    print actual,anterior
                    if actual!=anterior and sprint.fecha_inicio<=timezone_today():
                        raise forms.ValidationError("No se puede asignar este Sprint debido a que ya comenzo en la fecha:  "+str(sprint.fecha_inicio))
        return self.cleaned_data.get('sprint')
   
    def clean_estado_actividad(self):
        anterior=None
        if hasattr(self.instance, 'pk'):
            id_us=self.instance.pk 
            if self.cleaned_data.get('flujo') != None:
                if UserStory.objects.filter(pk=id_us).exists():
                    anterior=UserStory.objects.get(pk=id_us).estado_actividad
                    actual=self.cleaned_data.get('estado_actividad')
                    if (anterior =='TO' and actual=='DE') or (anterior=='DG' and actual =='FD' ) or (anterior=='TO' and actual=='FI') or(anterior =='DG' and actual=='FI') or (anterior =='DE' and actual=='FI'):
                        raise forms.ValidationError("Los estados de las actividades deben ser secuenciales. TO DO -> DOING -> DONE -> Flujo DONE -> FINALIZADO")
        
        id_us = self.instance.pk 
        if not UserStory.objects.filter(pk=id_us).exists():
            actual=self.cleaned_data.get('estado_actividad')
            if actual != 'TO':
                raise forms.ValidationError("Solo pueden crearse los User Story en estado TODO")       
                    
        return self.cleaned_data.get('estado_actividad')
        
    def clean_actividad_flujo(self):
        lanzar_error = True
        flujo_nuevo = self.cleaned_data.get('flujo')
        if flujo_nuevo==None:
            lanzar_error = False
            
        
        if hasattr(self.instance, 'pk'):
            id_us=self.instance.pk 
            if UserStory.objects.filter(pk=id_us).exists():
                flujo_anterior = UserStory.objects.get(pk=id_us).flujo
                if flujo_nuevo != flujo_anterior:
                    lanzar_error = False
                anterior=UserStory.objects.get(pk=id_us).actividad_flujo
                actual=self.cleaned_data.get('actividad_flujo')
                if anterior != actual and self.cleaned_data.get('estado_actividad')!='DONE':
                    if lanzar_error:
                        raise forms.ValidationError("No puede pasar a otra actividad hasta que el estado de este User Story sea DONE")
        return self.cleaned_data.get('actividad_flujo')
    
    def clean_tiempo_trabajado(self):
        anterior=None
        if hasattr(self.instance, 'pk'):
            id_us=self.instance.pk 
            if UserStory.objects.filter(pk=id_us).exists():
                anterior=UserStory.objects.get(pk=id_us).tiempo_trabajado
                actual=self.cleaned_data.get('tiempo_trabajado')
                if (anterior > actual):
                    raise forms.ValidationError("las horas trabajadas deben deben aumentra no disminuir")
            
        return self.cleaned_data.get('tiempo_trabajado')
    
    

class ProyectoForm(forms.ModelForm):
    
    def clean_fecha_finalizacion(self):
        
        fecha = self.cleaned_data.get('fecha_finalizacion')
        print timezone_today()
        print fecha
        #if actual!=anterior and sprint.fecha_inicio<=timezone_today():
        if (timezone_today() >= fecha):
            raise forms.ValidationError("la fecha de finalizacion debe ser posterior a la fecha actual")
        
        return self.cleaned_data.get('fecha_finalizacion')
    
    def clean_estado(self):
        id_proyecto = self.instance.pk
        if not (Proyecto.objects.filter(pk=id_proyecto).exists()):
            estado = self.cleaned_data.get('estado')
            if (estado == 'TER') or (estado == 'CAN'):
                raise forms.ValidationError("solo se pueden crear proyectos en estado iniciado o no iniciado")
        
        elif Proyecto.objects.filter(pk=id_proyecto).exists():
            p = Proyecto.objects.get(pk=id_proyecto)
            us = UserStory.objects.filter(proyecto=p)
            usFinalizado = UserStory.objects.filter(proyecto=p,estado_actividad='FI')
            if (us.count() - usFinalizado.count()) != 0 and self.instance.estado != 'TER':
                raise forms.ValidationError("no puede terminar, aun hay user story sin finalizar")
        
        return self.cleaned_data.get('estado')
  

    
    
    
    
    