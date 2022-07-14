#!/bin/bash
cd $(dirname "$0")
. ./config

if [ -d "./matching-story-robot-service" ];then
	rm -rf ./matching-story-robot-service
fi

git clone --branch ${branch} git@github.com:joycastle/matching-story-robot-service.git

mkdir -p ./dev

../../cmd/format -tpl=docker-compose-tpl.yaml -data=config -output=docker-compose.yaml
../../cmd/format -tpl=dev-tpl/redis.yaml -data=config -output=dev/redis.yaml
../../cmd/format -tpl=dev-tpl/mysql.yaml -data=config -output=dev/mysql.yaml
../../cmd/format -tpl=dev-tpl/rpc.yaml -data=config -output=dev/rpc.yaml

cp -r dev ./matching-story-robot-service/conf
cp ./Dockerfile ./matching-story-robot-service/
cp ./docker-compose.yaml ./matching-story-robot-service/

cd ./matching-story-robot-service/

sh deploy/pull_config.sh dev

docker-compose -f docker-compose.yaml build
docker-compose -f docker-compose.yaml up -d
