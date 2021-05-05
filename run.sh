#!/bin/bash
TAG=devel
docker pull lucab85/avg:$TAG
docker run --name="avg" -dit --mount type=bind,source=$(pwd)/share,target=/share -e AWS_ACCESS_KEY_ID="" -e AWS_SECRET_ACCESS_KEY="" -e AWS_DEFAULT_REGION="" lucab85/avg:$TAG
docker ps -a
docker exec -it "avg" bash
