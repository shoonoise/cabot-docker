cabot-docker
============

Docker Images to build full [cabot](https://github.com/arachnys/cabot) environment.

*Still Not Ready for Production*

Overview
============

As Cabot contains several things inside (django, celery, redis, database, etc) and docker using assumes one container for one thing we need several images for Cabot.

~~I use [maestro-ng](https://github.com/signalfuse/maestro-ng) to manage Docker containers.~~

To manage containers I suggest to use [docker-compose](https://docs.docker.com/compose/).

Let's try
------------

- [Install](https://docs.docker.com/installation/) Docker on host where Docker containers will run (*commonly it's ec2/Digital Ocean instances, virtual box/vmware vm's, etc*).

- [Install](https://docs.docker.com/compose/install/) docker-compose.

- Clone the repository (`git clone https://github.com/shoonoise/cabot-docker.git && cd cabot-docker`)

- Change the settings in `cabot_env` and link them to the correct API's. You can find more information on the official Wiki at http://cabotapp.com/use/configuration.html

- Run `docker-compose up -d`

Command `docker-compose ps` should return something like:

```
           Name                          Command               State                    Ports
--------------------------------------------------------------------------------------------------------------
cabotdocker_app_1             /bin/sh -c . /cabot/migrat ...   Up      0.0.0.0:5000->5000/tcp
cabotdocker_celery_broker_1   /entrypoint.sh redis-server      Up      0.0.0.0:6379->6379/tcp
cabotdocker_db_1              /usr/local/bin/run               Up      0.0.0.0:5432->5432/tcp
cabotdocker_nginx_1           nginx -g daemon off;             Up      443/tcp, 80/tcp, 0.0.0.0:8080->8080/tcp
```

Cabot web UI should be available at `http://_host_with_docker_:8080/`.

> if you use `docker-machine`, command `docker-machine ip default` shows ip for `default` host.

Default username/password: `docker/docker`. You can add new users using Django admin interface.

To complete the work you also need to rewrite variables in `cabot_env` file.
