FROM ubuntu:latest
WORKDIR kafka
COPY server/server-1.0 /kafka/server
COPY /build/metadata/metadata-1.0 /kafka/metadata
COPY /tmp/kraft-combined-logs /tmp/kraft-combined-logs
COPY ./execute.sh /kafka/execute.sh

RUN chmod -R 777 /kafka

EXPOSE 9092/tcp
EXPOSE 9093/tcp

CMD ["sh", "/kafka/execute.sh"]


