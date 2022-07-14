#!/bin/bash
cd $(dirname "$0")

. ./config

mkdir -p $path/conf && cp my.cnf $path/conf
mkdir -p $path/initdb && cp initdb.sql $path/initdb

../../cmd/format -tpl=docker-compose-tpl.yaml -data=config -output=docker-compose.yaml

docker-compose -f docker-compose.yaml up -d
