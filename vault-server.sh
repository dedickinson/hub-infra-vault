#!/bin/bash

CONTAINER_NAME=$1
IMAGE_NAME=$2
DATA_VOLUME=$3
LOG_VOLUME=$4
PORT=8200

EXTIP=$(docker run --rm --net=host hub-debug-general extip.sh)

CONFIG=$(cat config.json)

docker run -d --name $CONTAINER_NAME --cap-add=IPC_LOCK -p 8200:8200 \
    -v $DATA_VOLUME:/vault/file \
    -v $LOG_VOLUME:/vault/logs \
    $IMAGE_NAME server