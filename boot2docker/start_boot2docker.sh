#! /bin/sh

boot2docker init
boot2docker start
eval "$(boot2docker shellinit)"

boot2docker ip
