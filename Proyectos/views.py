from django.http.response import HttpResponseRedirect
from django.template.context import RequestContext
from django.contrib.auth.decorators import login_required
from django.shortcuts import render_to_response, get_object_or_404
from Proyectos.models import *
from django.db.models.aggregates import Sum
from django.views.generic.dates import timezone_today
from django.contrib.messages.context_processors import messages
from datetime import datetime
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.models import User
from reportlab.graphics.charts.linecharts import HorizontalLineChart
from reportlab.graphics.shapes import *
from reportlab.graphics  import renderPDF
    
@login_required(login_url='/admin/login/')
def tablero_kanban(request,id):
    flujo=get_object_or_404(Flujo,pk=id)
    
    return render_to_response('admin/Proyectos/kanban.html',{'flujo':flujo},
                                  context_instance=RequestContext(request))
    

@login_required(login_url='/admin/login/')
def burndown_chart(request,id):
    sprint=get_object_or_404(Sprint,pk=id)    
    timelines=TimeLine.objects.filter(userstory__sprint=sprint).order_by('fecha')
    return render_to_response('admin/Proyectos/burndown_chart.html',
                              {'sprint':sprint,'timelines':timelines,'total_horas':sprint.total_horas},
                                  context_instance=RequestContext(request))

class Dato():
    '''clase para almacenar los datos del timeline'''
    userstory = None
    fecha = None
    horas = None
    horas_restantes_sprint = None
    horas_restantes_proyecto = None

def existeFecha(listaDatos,fecha):
    '''verifica si la fecha ya esta en la lista'''
    for l in listaDatos:
        if l.fecha == fecha:
            return True
    return False

def omitirRepetidos(timelines):
    '''suma todos las fechas repetidas y toma la hora menor hora restante del timelines'''
    listaDatos = []
    for tl in timelines:
        if len(listaDatos) >= 1 :
            if not existeFecha(listaDatos,tl.fecha): 
                dato = Dato()
                dato = tl.userstory
                dato.fecha = tl.fecha
                dato.horas = tl.horas
                dato.horas_restantes_sprint = tl.horas_restantes_sprint
                dato.horas_restantes_proyecto = tl.horas_restantes_proyecto
                listaDatos.append(dato)
            else:
                dato.horas += tl.horas
                dato.horas_restantes = tl.horas_restantes_sprint
                dato.horas_restantes_proyecto = tl.horas_restantes_proyecto
        else:
            dato = Dato()
            dato = tl.userstory
            dato.fecha = tl.fecha
            dato.horas = tl.horas
            dato.horas_restantes_sprint = tl.horas_restantes_sprint
            dato.horas_restantes_proyecto = tl.horas_restantes_proyecto
            listaDatos.append(dato)      
    return listaDatos

@login_required(login_url='/admin/login/')
def burndown_chart1(request,id):
    sprint=get_object_or_404(Sprint,pk=id)    
    timelines=TimeLine.objects.filter(userstory__sprint=sprint).order_by('fecha')
    listaDatos = omitirRepetidos(timelines)
    print 'total_horas'
    print sprint.total_horas()
    return render_to_response('admin/Proyectos/burndown_chart1.html',
                              {'sprint':sprint,'timelines':listaDatos,'total_horas':sprint.total_horas},
                                  context_instance=RequestContext(request)) 

@login_required(login_url='/admin/login/')
def burndown_chart2(request,id):
    sprint=get_object_or_404(Sprint,pk=id)    
    timelines=TimeLine.objects.filter(userstory__sprint=sprint).order_by('fecha')
    listaDatos = omitirRepetidos(timelines)
    return render_to_response('admin/Proyectos/burndown_chart2.html',
                              {'sprint':sprint,'timelines':listaDatos,'total_horas':sprint.total_horas},
                                  context_instance=RequestContext(request)) 

def proyecto_burndown_chart1(request,id):
    proyecto=get_object_or_404(Proyecto,pk=id)  
    timelines=TimeLine.objects.filter(userstory__proyecto=proyecto).order_by('fecha')
    listaDatos = omitirRepetidos(timelines)
    return render_to_response('admin/Proyectos/burndown_chart1_proyecto.html',
                              {'proyecto':proyecto,'timelines':listaDatos,'total_horas':proyecto.total_horas},
                                  context_instance=RequestContext(request))

def proyecto_burndown_chart2(request,id):
    proyecto=get_object_or_404(Proyecto,pk=id)  
    timelines=TimeLine.objects.filter(userstory__proyecto=proyecto).order_by('fecha')
    listaDatos = omitirRepetidos(timelines)
    return render_to_response('admin/Proyectos/burndown_chart2_proyecto.html',
                              {'proyecto':proyecto,'timelines':listaDatos,'total_horas':proyecto.total_horas},
                                  context_instance=RequestContext(request))

@login_required(login_url='/admin/login/')
def crear_release(request,id):
    proyecto=get_object_or_404(Proyecto,pk=id)
    hoy=datetime.today()
    
    userstories=UserStory.objects.filter(proyecto_id=id,estado_actividad='FI',
                                         sprint__fecha_fin__lt=hoy)
    
    
    
    release=Release()
    release.fecha=hoy
    if userstories:
        release.fecha=datetime.today()
        release.proyecto=proyecto
        release.save()
        for us in userstories:
            release.userstories.add(us.pk)
    
       
        
    return render_to_response('admin/Proyectos/release.html',
                              {'proyecto':proyecto,'userstories':userstories,'hoy':release.fecha},
                                  context_instance=RequestContext(request))


  
@login_required(login_url='/admin/login/')
def ver_releases(request,id):
    proyecto=Proyecto.objects.get(pk=id)
    releases=Release.objects.filter(proyecto_id=id).order_by('fecha')
    return render_to_response('admin/Proyectos/releases.html',
                              {'proyecto':proyecto,'releases':releases},
                                  context_instance=RequestContext(request))

@login_required(login_url='/admin/login/')    
def cantidad_de_trabajo(request,id):
    proyecto = Proyecto.objects.get(pk=id)
    userstories = UserStory.objects.filter(proyecto=proyecto,estado_actividad='DG')
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'filename="informe.pdf"'
    p = canvas.Canvas(response)
    p.drawString(200, 800, proyecto.nombre)
    p.drawString(50, 780, "Cantidad de trabajo en curso: "+str(userstories.count())+" actividades")
    p.drawString(50,760, "Actividades (UserStory)")
    linea = 750
    for u in userstories:
        linea = linea -15
        p.drawString(50, linea,"Nombre: "+u.nombreUS)
        p.drawString(300,linea,"tiempo estimado: "+str(u.tiempo_estimado) )
        p.drawString(450, linea, "tiempo trabajado: "+str(u.tiempo_trabajado))
        linea = linea - 15
        p.drawString(50, linea, "Descripcion: "+u.descripcion)
        linea = linea -10
    p.showPage()
    p.save()
    return response  

@login_required(login_url='/admin/login/')  
def cantidad_de_trabajo_por_usuario(request,id):
    proyecto = Proyecto.objects.get(pk=id)
    userstories = UserStory.objects.filter(proyecto=proyecto).order_by('usuario')
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'filename="informe.pdf"'
    p = canvas.Canvas(response)
    p.drawString(200, 800, proyecto.nombre)
    p.drawString(50, 780, "Cantidad de trabajo por usuario")
    p.drawString(50,760, "Actividades (UserStory)")
    linea = 750
    username = '...'
    for u in userstories:
        linea = linea -15
        if username != str(u.usuario) and u.usuario != None:
            p.drawString(250,linea,'Usuario: '+ str(u.usuario))
            linea = linea -15
            username = str(u.usuario)
        if u.backlog != True:
            p.drawString(50, linea,"Nombre: "+u.nombreUS)
            p.drawString(300,linea,"tiempo estimado: "+str(u.tiempo_estimado) )
            p.drawString(450, linea, "tiempo trabajado: "+str(u.tiempo_trabajado))
            linea = linea - 15
            p.drawString(50, linea, "Descripcion: "+u.descripcion)
            linea = linea -10
    p.showPage()
    p.save()
    return response  

@login_required(login_url='/admin/login/')
def lista_de_us_todo(request,id):
    proyecto = Proyecto.objects.get(pk=id)
    userstories = UserStory.objects.filter(proyecto=proyecto,estado_actividad='TO').order_by('estado_actividad')
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'filename="informe.pdf"'
    p = canvas.Canvas(response)
    p.drawString(200, 800, proyecto.nombre)
    p.drawString(50, 780, "Lista de actividades faltantes para terminar el trabajo: "+str(userstories.count())+" actividades")
    p.drawString(50,760, "Actividades (UserStory)")
    linea = 750
    for u in userstories:
        linea = linea -15
        p.drawString(50, linea,"Nombre: "+u.nombreUS)
        p.drawString(300,linea,"Prioridad: "+traducir(u.prioridad) )
        linea = linea - 15
        p.drawString(50, linea, "Descripcion: "+u.descripcion)
        linea = linea -10
    p.showPage()
    p.save()
    return response

@login_required(login_url='/admin/login/')    
def lista_de_backlog(request,id):
    proyecto = Proyecto.objects.get(pk=id)
    userstories = UserStory.objects.filter(proyecto=proyecto,backlog=True)
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'filename="informe.pdf"'
    p = canvas.Canvas(response)
    p.drawString(200, 800, proyecto.nombre)
    p.drawString(50, 780, "Backlog")
    p.drawString(50,760, "Actividades (UserStory)")
    linea = 750
    for u in userstories:
        linea = linea -15
        p.drawString(50, linea,"Nombre: "+u.nombreUS)
        p.drawString(300,linea,"tiempo estimado: "+str(u.tiempo_estimado) )
        linea = linea - 15
        p.drawString(50, linea, "Descripcion: "+u.descripcion)
        linea = linea -10
    p.showPage()
    p.save()
    return response

def traducir(prioridad):
    if prioridad == 'N':
        return 'Normal'
    elif prioridad == 'B':
        return 'Baja'
    else:
        return 'Alta'
    
@login_required(login_url='/admin/login/')    
def sprint_backlog(request,idProyecto,idSprint):
    proyecto=get_object_or_404(Proyecto,pk=idProyecto) 
    userstories = UserStory.objects.filter(proyecto=proyecto, sprint_id=idSprint,estado_sprint="B")
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'filename="informe.pdf"'
    p = canvas.Canvas(response)
    p.drawString(200, 800, proyecto.nombre)
    p.drawString(50, 780, "Sprint Backlog")
    p.drawString(50,760, "Actividades (UserStory)")
    linea = 750
    for u in userstories:
        linea = linea -15
        p.drawString(50, linea,"Nombre: "+u.nombreUS)
        p.drawString(300,linea,"tiempo estimado: "+str(u.tiempo_estimado) )
        linea = linea - 15
        p.drawString(50, linea, "Descripcion: "+u.descripcion)
        linea = linea -10
    p.showPage()
    p.save()
    return response

def tiempo_proyecto_grafica(request,id):
    proyecto=get_object_or_404(Proyecto,pk=id) 
    timelines=TimeLine.objects.filter(userstory__proyecto=proyecto).order_by('fecha')
    listaDatos = omitirRepetidos(timelines)
    userstories = UserStory.objects.filter(proyecto=proyecto,estado_sprint="B")
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'filename="informe.pdf"'
    p = canvas.Canvas(response)
    p.drawString(200, 800, proyecto.nombre)
    p.drawString(50, 780, "Tiempo estimado del proyecto: "+str(proyecto.total_horas()))
    p.drawString(350, 780, "Tiempo trabajo en el proyecto"+str(proyecto.total_horas()-proyecto.horas_faltantes()))
    p.drawString(50,760, "Grafico: horas restantes en funcion a dias")
    
    
    if listaDatos == []:
        p.showPage()
        p.save()
        return response
    
    
    '''GRAFICO 1'''
    drawing = Drawing(600, 300)
    
    datos = []
    cat= []
    for l in listaDatos:
        datos.append(l.horas_restantes_proyecto)
        cat.append(l.fecha.strftime('%m/%d/%Y'))
    data = [datos]
    
    lc = HorizontalLineChart()
    lc.x = 50
    lc.y = 50
    lc.height = 200
    lc.width = 400
    lc.data = data
    lc.joinedLines = 1
    lc.categoryAxis.categoryNames = cat
    lc.categoryAxis.labels.boxAnchor = 'n'
    lc.valueAxis.valueMin = 0
    lc.valueAxis.valueMax = proyecto.total_horas()
    lc.valueAxis.valueStep = 5
    lc.lines[0].strokeWidth = 2
    lc.lines[1].strokeWidth = 1.5
    drawing.add(lc)
    renderPDF.draw(drawing, p, 50, 500)
    '''GRAFICO 2'''
    p.drawString(50,480, "Grafico: horas trabajadas en funcion a dias")
    drawing = Drawing(600, 300)
    
    datos = []
    cat= []
    for l in listaDatos:
        datos.append(l.horas)
        cat.append(l.fecha.strftime('%m/%d/%Y'))
    data = [datos]
    
    lc = HorizontalLineChart()
    lc.x = 50
    lc.y = 50
    lc.height = 200
    lc.width = 400
    lc.data = data
    lc.joinedLines = 1
    lc.categoryAxis.categoryNames = cat
    lc.categoryAxis.labels.boxAnchor = 'n'
    lc.valueAxis.valueMin = 0
    lc.valueAxis.valueMax = proyecto.total_horas()/2
    lc.valueAxis.valueStep = 2
    lc.lines[0].strokeWidth = 2
    lc.lines[1].strokeWidth = 1.5
    drawing.add(lc)
    renderPDF.draw(drawing, p, 50, 200)
    
    
    p.showPage()
    p.save()
    return response


@login_required(login_url='/admin/login/')
def informes(request,id):
    proyecto = Proyecto.objects.get(pk=id)
    return render (request,'admin/Proyectos/informes.html',
                              {'proyecto':proyecto})

def sprints_del_proyecto(request,id):
    print "proyecto id : " + str(id)
    proyecto = Proyecto.objects.get(pk=id)
    sprints = Sprint.objects.filter(proyecto=proyecto)
    print sprints
    return render (request,'admin/Proyectos/sprints.html',
                              {'proyecto':proyecto,'sprints':sprints})