#!/bin/bash

export DATABASE_URL="postgres://docker:docker@db:5432/docker"
export CELERY_BROKER_URL="redis://celery_broker:6379/1"
export SES_HOST="smtp_server"
export SES_USER=""
export SES_PASS=""
export SES_PORT="25"

python manage.py collectstatic --noinput &&\
python manage.py compress --force &&\
python manage.py syncdb --noinput && \
python manage.py migrate && \
python manage.py loaddata fixture.json

gunicorn cabot.wsgi:application --config gunicorn.conf --log-level info --log-file /var/log/gunicorn &\
celery worker -B -A cabot --loglevel=INFO --concurrency=16 -Ofair
