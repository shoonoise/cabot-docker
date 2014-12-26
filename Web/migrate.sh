#!/bin/bash

export DATABASE_URL="postgres://docker:docker@$DATABASE_POSTGRE_HOST:$DATABASE_POSTGRE_DB_PORT/docker"
export CELERY_BROKER_URL="redis://$CELERY_BROKER_REDIS_HOST:$CELERY_BROKER_REDIS_BROKER_PORT/1"
export SES_HOST="$MAIL_EXIM_HOST"
export SES_USER=""
export SES_PASS=""
export SES_PORT="225"

python manage.py collectstatic --noinput &&\
python manage.py compress --force &&\
python manage.py syncdb --noinput && \
python manage.py migrate && \
python manage.py loaddata fixture.json 