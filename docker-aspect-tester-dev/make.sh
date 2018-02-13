#!/bin/bash

docker pull dealii/dealii:latest
id="tjhei/aspect-tester-dev"
echo "building: $id"
docker build -t $id .
