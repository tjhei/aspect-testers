#!/bin/bash
#
# run with argument "mark" to mark instead of run

MARK=""
if [ "$1" == "mark" ]
then
  MARK="-mark";
fi
ID="aspect-8.5-gcc-hd"
MACHINE="test"
docker-machine-Linux-x86_64 start $MACHINE
eval $(docker-machine-Linux-x86_64 env $MACHINE)
docker ps | exit 1

echo "starting $ID$MARK at `date` on $MACHINE"

while :
do
  docker ps | exit 2

  if [ -n "$MARK" ]
  then
      python runner.py mark-pullrequests
  else
      python runner.py do-pullrequests
      python runner.py render

      echo "rsync ..."
      rsync -az results.html logs/ timo.ces:public_html/cib/$ID/
      ssh timo.ces chmod -R a+rX ~/public_html/cib/$ID/

  fi

  curl http://www.math.clemson.edu/~heister/alive.php?id=$ID$MARK >/dev/null 2>&1

  echo "$ID$MARK loop.sh sleeping ... (`date`)"
  sleep 60
done
