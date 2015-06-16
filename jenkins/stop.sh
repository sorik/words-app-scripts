#! /bin/bash

NAME=words-app-ci
JENKINS_ID=$(docker ps -a | grep $NAME | awk '{print $1}')

echo $JENKINS_ID | xargs docker stop
echo $JENKINS_ID | xargs docker rm