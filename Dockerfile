FROM ubuntu:latest
WORKDIR kafka
ADD ./kafka /kafka

EXPOSE 9092/tcp
EXPOSE 9093/tcp

CMD ["sh", "/kafka/execute.sh"]


