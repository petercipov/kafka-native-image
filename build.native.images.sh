#!/bin/bash
mvn clean package
cd server && sh ./build-image.sh && cd ..

mkdir -p ./kafka
mv ./server/server-1.0 ./kafka/server
mv ./execute.sh ./kafka/execute.sh

chmod -R 777 ./kafka

