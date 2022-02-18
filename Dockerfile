FROM ubuntu:latest
WORKDIR kafka
ADD ./kafka /kafka
COPY ./storage/kraft-combined-logs /tmp/kraft-combined-logs

EXPOSE 9092/tcp
EXPOSE 9093/tcp

CMD ["sh", "/kafka/execute.sh"]


