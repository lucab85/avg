#!/bin/bash
TAG=latest
docker pull lucab85/avg:$TAG
docker run --name="avg" -dit --mount type=bind,source=$(pwd)/share,target=/share --env-file=default.env lucab85/avg:$TAG
docker ps -a
docker exec -it "avg" bash
