"""
WSGI config for taguato project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/howto/deployment/wsgi/
"""

'''
# -.- coding: utf-8 -.-
import os, sys

sys.path.append('/home/miguel/workspace/taguato')

os.environ["DJANGO_SETTINGS_MODULE"]='taguato.settings'
os.environ.setdefault('LANG', "en_US.UTF-8")
os.environ.setdefault("LC_ALL", "en_US.UTF-8")

activate_this='/home/miguel/workspace/taguato/venv/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
'''


import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "taguato.settings")

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
