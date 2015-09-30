from django.shortcuts import render_to_response
from django.template.context import RequestContext
from django.contrib.auth.models import User
from django.contrib import messages
import requests
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
import socket
import urllib2
from taguato.settings import BASE_DIR
import string
from random import sample, choice


def forgot_password(request):
    if request.method=='POST':
        username=request.POST.get('username','')
        if User.objects.filter(username=username).exists():
            user=User.objects.get(username=username)
            if user.email !='' and user.email !=None:
                
                if internet_on():
                    new_pass=generate_password()
                    user.set_password(new_pass)
                    user.save()
                    send_complex_message(new_pass,user.username,user.email)
                    messages.success(request,"Mensaje enviado. Verifique su correo.")
                else:
                    messages.error(request,"No se puede establecer la conexion. Verifique que tenga acceso a internet.")
            else:
                messages.error(request,"El usuario no posee email")
        else:
            messages.error(request,"El usuario no existe")
    return render_to_response('admin/forgot_password.html',{},
                                  context_instance=RequestContext(request)) 


def generate_password():
    chars = string.letters + string.digits
    length = 5
    return ''.join(choice(chars) for _ in range(length)) 
    
def send_complex_message(password,username,correo):
    f = open(BASE_DIR+'/Templates/mensaje_password.html', 'r')
    html=f.read()
    vector=html.split("username")
    html=vector[0]+username+vector[1]
    vector=html.split("<li><b>Password:</b>")
    html=vector[0]+"<li><b>Password: </b>"+password+vector[1]

    return requests.post(
        "https://api.mailgun.net/v2/sandbox2760868a83624ed587c6e3c7706503e3.mailgun.org/messages",
        auth=("api", "key-5412aff4c4c60423be7566da641215c0"),
        #files=[("attachment", open("mensaje_password.html")),],
        data={"from": "taguato <soporte@taguato.com>",
              "to": correo,
              "subject": "Recuperacion de Password",
              "text": "Testing some Mailgun awesomness!",
              "html": html})



def internet_on():
    ''' En esta funcion se verifica la conexion a internet para poder enviar 
        el correo con el password nuevo'''
    try:
        response=urllib2.urlopen('http://74.125.228.100',timeout=3)
        return True
    except urllib2.URLError as err: pass
    return False
 