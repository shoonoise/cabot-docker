#!/bin/bash

export DATABASE_URL="postgres://docker:docker@$DATABASE_POSTGRE_HOST:$DATABASE_POSTGRE_DB_PORT/docker"
export CELERY_BROKER_URL="redis://$CELERY_BROKER_REDIS_HOST:$CELERY_BROKER_REDIS_BROKER_PORT/1"
export SES_HOST="$MAIL_EXIM_HOST"
export SES_USER=""
export SES_PASS=""
export SES_PORT="225"

service nginx restart &&\
gunicorn cabot.wsgi:application --config gunicorn.conf --log-level info --log-file /var/log/gunicorn &\
celery worker -B -A cabot --loglevel=INFO --concurrency=16 -Ofair
