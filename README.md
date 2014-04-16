cabot-docker
============

Docker Images to build full [cabot](https://github.com/arachnys/cabot) environment

*It works, but still under development.*

### How To

As Cabot contains several things inside (django, celery, redis, database, etc) and docker using assumes one image for one thing we need several images for Cabot.

I use [maestro-ng](https://github.com/signalfuse/maestro-ng) to manage Docker containers.

#### Let's try 

- Install maestro-ng, docker, setup VM
- Build Cabot image in target VM (**TODO**: pull image to docker index)
- Edit `maestro.yml` according to your environment (**TODO**: need some instructions for this)
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

Cabot web UI should be available at `http:your_vm_host:8000/`.
