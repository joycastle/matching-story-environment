#!/bin/bash
cd $(dirname "$0")
. ./config

if [ -d "./match-3-pigeon" ];then
    rm -rf ./match-3-pigeon
fi

git clone --branch ${branch} git@github.com:joycastle/match-3-pigeon.git

../../cmd/format -tpl=docker-compose-tpl.yaml -data=config -output=docker-compose.yaml
../../cmd/format -tpl=dev-tpl.yaml -data=config -output=dev.yaml

cp ./dev.yaml ./match-3-pigeon/config/
cp ./Dockerfile ./match-3-pigeon/
cp ./docker-compose.yaml ./match-3-pigeon/

cd ./match-3-pigeon/

docker-compose -f docker-compose.yaml build
docker-compose -f docker-compose.yaml up -d
