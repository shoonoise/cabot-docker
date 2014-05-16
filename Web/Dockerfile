# Cabot Dockerfile
#
# https://github.com/shoonoise/cabot-docker
#
# VERSION 1.0

FROM yandex/ubuntu:latest
MAINTAINER Alexander Kushnarev <avkushnarev@gmail.com>

# Prepare
RUN apt-get update
RUN apt-get install -y python-pip build-essential nodejs libpq-dev python-dev npm nginx

# Deploy cabot
RUN git clone https://github.com/shoonoise/cabot.git /cabot
ADD fixture.json /cabot/
ADD run.sh /cabot/
ADD nginx.conf /etc/nginx/nginx.conf

# Install dependencies
RUN pip install -r /cabot/requirements.txt
RUN npm install --no-color -g coffee-script less@1.3 --registry http://registry.npmjs.org/

# Set env var
ENV PATH $PATH:/cabot/app
ENV PYTHONPATH $PYTHONPATH:/cabot/app

# Cabot settings
ENV DJANGO_SETTINGS_MODULE app.settings
ENV HIPCHAT_URL https://api.hipchat.com/v1/rooms/message
ENV LOG_FILE /var/log/cabot
ENV PORT 5000
ENV ADMIN_EMAIL you@example.com
ENV CABOT_FROM_EMAIL noreply@example.com
ENV DEBUG t

# URL of calendar to synchronise rota with
ENV CALENDAR_ICAL_URL http://www.google.com/calendar/ical/example.ics

ENV DJANGO_SECRET_KEY 2FL6ORhHwr5eX34pP9mMugnIOd3jzVuT45f7w430Mt5PnEwbcJgma0q8zUXNZ68A

# Hostname of your Graphite server instance
ENV GRAPHITE_API http://graphite.example.com/
ENV GRAPHITE_USER username
ENV GRAPHITE_PASS password

# Hipchat integration
ENV HIPCHAT_ALERT_ROOM 48052
ENV HIPCHAT_API_KEY your_hipchat_api_key

# Jenkins integration
ENV JENKINS_API https://jenkins.example.com/
ENV JENKINS_USER username
ENV JENKINS_PASS password

# SMTP settings
ENV SES_HOST email-smtp.us-east-1.amazonaws.com
ENV SES_USER username
ENV SES_PASS password
ENV SES_PORT 465

# Twilio integration for SMS and telephone alerts
ENV TWILIO_ACCOUNT_SID your_account_sid
ENV TWILIO_AUTH_TOKEN your_auth_token
ENV TWILIO_OUTGOING_NUMBER +14155551234

# Used for pointing links back in alerts etc.
ENV WWW_HTTP_HOST cabot.example.com
ENV WWW_SCHEME http

ADD env_vars /cabot/

# Run cabot
WORKDIR /cabot/
CMD . /cabot/env_vars && /cabot/run.sh
