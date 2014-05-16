#!/bin/bash

service nginx restart &&\
python manage.py collectstatic --noinput &&\
python manage.py compress --force &&\
python manage.py syncdb --noinput && \
python manage.py migrate && \
python manage.py loaddata fixture.json &&\
gunicorn wsgi:application --config gunicorn.conf &\
celery worker -B -A app.cabotapp.tasks --loglevel=INFO --concurrency=16 -Ofair
