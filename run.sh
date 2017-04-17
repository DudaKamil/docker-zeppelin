#!/usr/bin/env bash

## IN PROGRESS

# bind web ui to 9080
docker run --network dockerspark_spark-network -p 9080:8080 -p 9443:8443 --name docker-zeppelin --link docker-spark-1 kduda/zeppelin:latest
