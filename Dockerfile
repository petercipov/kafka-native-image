FROM ghcr.io/graalvm/graalvm-ce:latest AS build_image
WORKDIR build

ADD pom.xml pom.xml
ADD storage storage
ADD server server
ADD metadata metadata
ADD musl_x86.build.prepare.sh musl_x86.build.prepare.sh
ADD build.images.sh build.images.sh

RUN sh ./build.images.sh

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


