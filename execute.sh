#!/bin/sh

export BROKER_UUID="${BROKER_UUID:-`/kafka/storage -Dorg.slf4j.simpleLogger.defaultLogLevel=off random-uuid`}"

/kafka/storage format -t $BROKER_UUID -c /kafka/server.single.properties

/kafka/server /kafka/server.single.properties