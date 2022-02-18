#!/bin/bash


curl -o  apache-maven-3.8.4-bin.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
tar -xvf ./apache-maven-3.8.4-bin.tar.gz
./apache-maven-3.8.4/bin/mvn clean package

cd server && sh ./build-image.sh && cd ..
cd metadata && sh ./build-image.sh && cd ..

