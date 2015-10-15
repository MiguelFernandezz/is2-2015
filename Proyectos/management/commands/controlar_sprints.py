from django.core.management.base import BaseCommand, CommandError
import schedule
import time
from Proyectos.models import Sprint, UserStory
from django.views.generic.dates import timezone_today
from Proyectos.models import Sprint

class Command(BaseCommand):
    """
        Esta clase permite que se pueda crear un comando a ser ejecutado desde la consola de la siguiente
        forma  python manage.py controlarsprints el cual controla que todos los sprints cuya fecha de finalizacion
        hayan concluido, que sus User Stories pasen al siguiente sprint dentro del proyecto
    """
    help = 'Controla la fecha de finalizacion de los sprints. Si ya finalizo, todos sus Users Stories pasan al siguiente Sprint del proyecto.'
    args = 'No necesita argumentos.'    
    def job(self):
        self.stdout.write("Controlando sprints..")
        sprints=Sprint.objects.all().order_by('proyecto','fecha_inicio')
        for s in sprints:
          if s.fecha_fin <= timezone_today() and not s.finalizado:
              self.stdout.write("Sprint "+s.nombreSprint+" finalizado...")
              userstories=UserStory.objects.filter(sprint=s)
              sprint2=Sprint.objects.filter(proyecto=s.proyecto,fecha_inicio__gte=s.fecha_fin).order_by('fecha_inicio')
              if sprint2.exists():
                  self.stdout.write("pasando User Stories al siguiente Sprint...")
                  for us in userstories:
                      self.stdout.write(us.nombreUS+"...")
                      us.sprint=sprint2[0]
                      us.save()
              
              s.finalizado=True
              s.save()
              
    def handle(self, *args, **options):
        """
            En este metodo se ejecuta la logica del comando "controlar_sprints", 
            el cual llama a la funcion job cada cierto tiempo, definido en schedule.every().minutes.do(self.job)
        """
        self.stdout.write("Ejecutando Schedule que controla la finalizacion de Sprints..")
        schedule.every(1).minutes.do(self.job)
        while True:
            schedule.run_pending()
            time.sleep(1)