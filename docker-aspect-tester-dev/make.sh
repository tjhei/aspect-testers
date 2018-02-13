#!/bin/bash
id="tjhei/aspect-tester-dev"
echo "building: $id"
docker build -t $id .
