#! /bin/sh

NEWS_MONGO=news-mongo
NEWS_SERVER=news-server
WORDS_WEB_FRONT=words-webfront

# stop and remove the existing db
MONGO_ID=$(docker ps -a | grep $NEWS_MONGO | awk '{print $1}')
if [ "$MONGO_ID" != "" ]
then
  echo "stoping and removing running DB.."
  echo $MONGO_ID | xargs docker stop
  echo $MONGO_ID | xargs docker rm
fi

# start mongodb
if [ "$1" = "start" ]
then
  echo "starting news-mongo"
  docker run -d -P --name $NEWS_MONGO mongo
fi

# stop and remove the existing news server
NEWS_SERVER_ID=$(docker ps -a | grep $NEWS_SERVER | awk '{print $1}')
if [ "$NEWS_SERVER_ID" != "" ]
then
  echo "stoping and removing running news server.."
  echo $NEWS_SERVER_ID | xargs docker stop
  echo $NEWS_SERVER_ID | xargs docker rm
fi

# start news-server
if [ "$1" = "start" ]
then
  echo "starting news-server"
  docker run -d -p 8005:8005 --link $NEWS_MONGO:db --name $NEWS_SERVER sorik/news-server
fi

# stop and remove the existing webfront
WORDS_WEB_FRONT_ID=$(docker ps -a | grep $WORDS_WEB_FRONT | awk '{print $1}')
if [ "$WORDS_WEB_FRONT_ID" != "" ]
then
  echo "stoping and removing running words webfront.."
  echo $WORDS_WEB_FRONT_ID | xargs docker stop
  echo $WORDS_WEB_FRONT_ID | xargs docker rm
fi

# start words-webfront
if [ "$1" = "start" ]
then
  echo "starting words-webfront"
  docker run -d -p 8004:80 --link $NEWS_SERVER:news-server --name $WORDS_WEB_FRONT sorik/words-webfront
fi

# display ip
if [ "$1" = "start" ]
then
  echo "all services are running..."
  echo $(boot2docker ip)
  echo $(docker ps)
fi
