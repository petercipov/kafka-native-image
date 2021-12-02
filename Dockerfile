FROM ghcr.io/graalvm/graalvm-ce:latest AS build_image
WORKDIR build
RUN gu install native-image
RUN curl -o  apache-maven-3.8.4-bin.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
RUN tar -xvf ./apache-maven-3.8.4-bin.tar.gz
ADD pom.xml pom.xml
ADD storage storage
ADD server server
ADD metadata metadata
ADD musl_x86.build.prepare.sh musl_x86.build.prepare.sh
RUN source ./musl_x86.build.prepare.sh && echo "PATH: $PATH"
RUN x86_64-linux-musl-gcc || true
RUN ./apache-maven-3.8.4/bin/mvn clean package
RUN cd server && sh ./build-image.sh && cd ..
RUN cd storage && sh ./build-image.sh && cd ..
RUN cd metadata && sh ./build-image.sh && cd ..

FROM docker.io/library/alpine:3.15.0
WORKDIR kafka
COPY --from=build_image /build/server/server-1.0 /kafka/server
COPY --from=build_image /build/storage/storage-1.0 /kafka/storage
COPY --from=build_image /build/metadata/metadata-1.0 /kafka/metadata
COPY ./execute.sh /kafka/execute.sh

RUN chmod -R 777 /kafka

EXPOSE 9092/tcp
EXPOSE 9093/tcp

CMD ["sh", "/kafka/execute.sh"]


