#! /bin/bash

NAME=words-app-ci

ERROR=1
while [ $ERROR -eq 1 ]
do
    echo ">> stop and remove words-app-ci container when it exists"
    ./stop.sh

    echo ">> start words-app-ci container"
    docker run --privileged=true -d -p 8080:8080 -v /opt/development/jenkins_home:/var/jenkins_home --name $NAME sorik/words-app-ci

    JENKINS_ID=$(docker ps -a | grep $NAME | awk '{print $1}')
    echo ">>>> waiting for this container to be ready to start docker..."
    sleep 10
    docker exec $JENKINS_ID sudo service docker start
    ERROR=$(docker exec -t $JENKINS_ID docker info | grep FATA | wc -l)
    if [ $ERROR -eq 1 ]; then
        echo ">>>> failed to start jenkins with docker running.. try again.."
    else
        echo ">>>> successfully started."
    fi
done


#docker exec -i -t $JENKINS_ID bash -c "apt-get install -y leiningen"
