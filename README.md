cabot-docker
============

Docker Images to build full [cabot](https://github.com/arachnys/cabot) environment.

*Still Not Ready for Production*

Overview
============

As Cabot contains several things inside (django, celery, redis, database, etc) and docker using assumes one image for one thing we need several images for Cabot.

I use [maestro-ng](https://github.com/signalfuse/maestro-ng) to manage Docker containers.

Let's try
------------

- [Install](https://github.com/signalfuse/maestro-ng#installation) maestro-ng on host from which you want to manage dockers images (*commonly it's your localhost*).
- [Install](http://docs.docker.io/installation/#installation) and [configure](#docker_conf) Docker on host where Docker containers will run (*commonly it's ec2/Digital Ocean instances, virtual box/vmware vm's, etc*).
- [Update](#maestro_conf) `maestro.yml` according to *your* environment
- Run `python -m maestro -f maestro.yml`

Command `python -m maestro -f maestro.yml fullstatus` should return something like:

```
  #  INSTANCE             SERVICE         SHIP                 CONTAINER       STATUS
  1. postgre_1            postgresql      vm1                  517ef1e         up
     >>  5432/tcp:db
  2. redis_1              redis           vm1                  a5e10da         up
     >>  6379/tcp:broker
  3. cabot_web_1          cabot_web       vm1                  63b9078         up
     >>  8000/tcp:web
     >>  5000/tcp:backend
```

Cabot web UI should be available at `http://_host_with_docker_:8000/`.
Default username/password: `docker/docker`. You can add new users using Django admin interface.

### <a name="docker_conf"></a>Docker configuration

By default maestro expected running Docker daemon in `4243` port, so you need to configure it:

* Add `DOCKER_OPTS="-H tcp://0.0.0.0:4243"` to `/etc/default/docker`
* Restart docker daemon: `restart docker`

### <a name="maestro_conf"></a>Maestro configuration

At first make sure that you are have read maestro-ng [docs](https://github.com/signalfuse/maestro-ng#orchestration).

To *just run* Cabot you need:
* Change `vm1: {ip: localhost}` in `maestro.yml` to host with docker (ip/hostname).

But to complete the work you also need to [rewrite](https://github.com/signalfuse/maestro-ng#passing-extra-environment-variables) default environment variables(eg `GRAPHITE_USER`/`GRAPHITE_PASS`, `SES_HOST`/`SES_USER`/`SES_PASS` and so on).

By default cabot image pulled from [Docker Index](https://index.docker.io/u/shoonoise/cabot-docker/), but you still can build image manual and say maestro use it, just change `image: shoonoise/cabot-docker` in `cabot web` section to your image's name. 
The same way to change all other images (*postgresql*, *redis*, etc).
