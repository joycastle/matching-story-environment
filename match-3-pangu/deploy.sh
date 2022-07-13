#!/bin/bash
. ./config

git clone --branch ${branch} git@github.com:joycastle/match-3-pangu-v2.git

../cmd/format -tpl=docker-compose-tpl.yaml -data=config -output=docker-compose.yaml
../cmd/format -tpl=dev-tpl.yaml -data=config -output=dev.yaml

cp ./dev.yaml ./match-3-pangu-v2/config/
cp ./Dockerfile ./match-3-pangu-v2/
cp ./docker-compose.yaml ./match-3-pangu-v2/

cd ./match-3-pangu-v2/

sh script/pull_config.sh dev

docker-compose -f docker-compose.yaml up -d --force-recreate
