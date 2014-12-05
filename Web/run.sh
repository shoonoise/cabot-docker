#!/bin/bash

export DATABASE_URL="postgres://docker:docker@$DATABASE_POSTGRE_HOST:5432/docker"
export CELERY_BROKER_URL="redis://$CELERY_BROKER_REDIS_HOST:6379/1"
export SES_HOST="$MAIL_EXIM_HOST"
export SES_USER=""
export SES_PASS=""
export SES_PORT="225"

service nginx restart &&\
gunicorn cabot.wsgi:application --config gunicorn.conf --log-level info --log-file /var/log/gunicorn &\
celery worker -B -A cabot --loglevel=INFO --concurrency=16 -Ofair
