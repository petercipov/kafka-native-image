FROM ghcr.io/graalvm/graalvm-ce:latest AS build_image
WORKDIR build
RUN gu install native-image
RUN curl -o  apache-maven-3.8.4-bin.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
RUN tar -xvf ./apache-maven-3.8.4-bin.tar.gz
ADD pom.xml pom.xml
ADD storage storage
ADD server server

RUN ./apache-maven-3.8.4/bin/mvn clean package
RUN cd server && sh ./build-image.sh && cd ..
RUN cd storage && sh ./build-image.sh && cd ..


FROM docker.io/library/alpine:3.15.0
WORKDIR kafka
COPY --from=build_image /build/server/server-1.0 /kafka/server
COPY --from=build_image /build/storage/storage-1.0 /kafka/storage
COPY ./execute.sh /kafka/execute.sh
COPY ./server.single.properties /kafka/server.single.properties

EXPOSE 9092/tcp
EXPOSE 9093/tcp

RUN ./execute.sh


