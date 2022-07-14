#!/bin/bash

#blue

color=blue
target_path=/home/$color

target_mysql_ip=10.10.10.11
target_mysql_port=13306

target_redis_ip=10.10.10.22
target_redis_port=16379

target_pigeon_branch=master
target_pigeon_ip=10.10.10.33
target_pigeon_port=18089

target_pangu_branch=levin-robot
target_pangu_ip=10.10.10.44
target_pangu_port=13001

target_robot_branch=main
target_robot_ip=10.10.10.55
target_robot_faketime_port=11122


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
redis-ip=$target_redis_ip
mysql-ip=$target_mysql_ip
path=$target_path/pigeon" > $jobs_pigeon_path/config

echo \
"branch=$target_pangu_branch
color=$color
port=$target_pangu_port
ip=$target_pangu_ip
redis-ip=$target_redis_ip
mysql-ip=$target_mysql_ip
pigeon-ip=$target_pigeon_ip
path=$target_path/pangu" > $jobs_pangu_path/config

echo \
"branch=$target_robot_branch
color=$color
port=$target_robot_faketime_port
ip=$target_robot_ip
redis-ip=$target_redis_ip
mysql-ip=$target_mysql_ip
rpc-ip=$target_pangu_ip
path=$target_path/robot" > $jobs_robot_path/config



sh $jobs_mysql_path/deploy.sh
sh $jobs_redis_path/deploy.sh
sleep 1
sh $jobs_pangu_path/deploy.sh
sleep 1
sh $jobs_pigeon_path/deploy.sh
sh $jobs_robot_path/deploy.sh
