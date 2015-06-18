#! /bin/sh

boot2docker init -m 4096
boot2docker start
eval "$(boot2docker shellinit)"

boot2docker ip
