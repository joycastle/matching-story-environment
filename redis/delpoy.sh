#!/bin/bash
. ./config

mkdir -p $path/conf && cp redis.conf $path/conf

../cmd/format -tpl=docker-compose-tpl.yaml -data=config -output=docker-compose.yaml

docker-compose -f docker-compose.yaml up -d --force-recreate
