#!/bin/bash

docker-machine-Linux-x86_64 start
eval $(docker-machine-Linux-x86_64 env)
docker ps | exit 1

while :
do
  docker ps | exit 2
  python runner.py mark-pullrequests

  curl http://www.math.clemson.edu/~heister/alive.php?id=aspect-8.4.1-hd-mark >/dev/null 2>&1

  echo "aspect-8.4.1-hd-mark: is sleeping"
  sleep 300
done
