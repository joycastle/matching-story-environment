#!/bin/bash
cd $(dirname "$0")
. ./config

jobs_mysql_path=../jobs/mysql
jobs_redis_path=../jobs/redis
jobs_pigeon_path=../jobs/match-3-pigeon
jobs_pangu_path=../jobs/match-3-pangu
jobs_robot_path=../jobs/matching-story-robot-service

echo \
"color=$color
ip=$target_mysql_ip
port=$target_mysql_port
path=$target_path/mysql" > $jobs_mysql_path/config

echo \
"color=$color
ip=$target_redis_ip
port=$target_redis_port
path=$target_path/redis" > $jobs_redis_path/config

echo \
"branch=$target_pigeon_branch
color=$color
port=$target_pigeon_port
ip=$target_pigeon_ip
redis_ip=$target_redis_ip
mysql_ip=$target_mysql_ip
path=$target_path/pigeon" > $jobs_pigeon_path/config

echo \
"branch=$target_pangu_branch
color=$color
port=$target_pangu_port
ip=$target_pangu_ip
redis_ip=$target_redis_ip
mysql_ip=$target_mysql_ip
pigeon_ip=$target_pigeon_ip
path=$target_path/pangu" > $jobs_pangu_path/config

echo \
"branch=$target_robot_branch
color=$color
port=$target_robot_faketime_port
ip=$target_robot_ip
redis_ip=$target_redis_ip
mysql_ip=$target_mysql_ip
rpc_ip=$target_pangu_ip
path=$target_path/robot" > $jobs_robot_path/config



containerName="$color-mysql"
exist=`docker inspect --format '{{.State.Running}}' ${containerName}`
if [ "${exist}" != "true" ]; then
	sh $jobs_mysql_path/deploy.sh
	sleep 1
fi

containerName="$color-redis"
exist=`docker inspect --format '{{.State.Running}}' ${containerName}`
if [ "${exist}" != "true" ]; then
	sh $jobs_redis_path/deploy.sh
	sleep 1
fi

sh $jobs_pangu_path/deploy.sh
sh $jobs_pigeon_path/deploy.sh
sh $jobs_robot_path/deploy.sh
