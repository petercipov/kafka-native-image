#!/bin/sh

echo "process.roles=${CONFIG_PROCESS_ROLES:-broker,controller}" >> ./generated.server.properties
echo "node.id=${CONFIG_NODE_ID:-1}" >> ./generated.server.properties
echo "controller.quorum.voters=${CONFIG_CONTROLLER_QUORUM_VOTERS:-1@localhost:9093}" >> ./generated.server.properties
echo "listeners=${CONFIG_LISTENERS:-PLAINTEXT://:9092,CONTROLLER://:9093}" >> ./generated.server.properties
echo "inter.broker.listener.name=${CONFIG_INTER_BROKER_LISTENER_NAME:-PLAINTEXT}" >> ./generated.server.properties
echo "advertised.listeners=${CONFIG_ADVERTISED_LISTENERS:-PLAINTEXT://localhost:9092}" >> ./generated.server.properties
echo "controller.listener.names=${CONFIG_CONTROLLER_LISTENER_NAMES:-CONTROLLER}" >> ./generated.server.properties
echo "listener.security.protocol.map=${CONFIG_LISTENER_SECURITY_PROTOCOL_MAP:-CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL}" >> ./generated.server.properties
echo "num.network.threads=${CONFIG_NUM_NETWORK_THREADS:-3}" >> ./generated.server.properties
echo "num.io.threads=${CONFIG_NUM_IO_THREADS:-8}" >> ./generated.server.properties
echo "socket.send.buffer.bytes=${CONFIG_SOCKET_SEND_BUFFER_BYTES:-102400}" >> ./generated.server.properties
echo "socket.receive.buffer.bytes=${CONFIG_SOCKET_RECEIVE_BUFFER_BYTES:-102400}" >> ./generated.server.properties
echo "socket.request.max.bytes=${CONFIG_SOCKET_REQUEST_MAX_BYTES:-104857600}" >> ./generated.server.properties
echo "log.dirs=${CONFIG_LOG_DIRS:-/tmp/kraft-combined-logs}" >> ./generated.server.properties
echo "num.partitions=${CONFIG_NUM_PARTITIONS:-1}" >> ./generated.server.properties
echo "num.recovery.threads.per.data.dir=${CONFIG_NUM_RECOVERY_THREADS_PER_DATA_DIR:-1}" >> ./generated.server.properties
echo "offsets.topic.replication.factor=${CONFIG_OFFSETS_TOPIC_REPLICATION_FACTOR:-1}" >> ./generated.server.properties
echo "transaction.state.log.replication.factor=${CONFIG_TRANSACTION_STATE_LOG_REPLICATION_FACTOR:-1}" >> ./generated.server.properties
echo "transaction.state.log.min.isr=${CONFIG_TRANSACTION_STATE_LOG_MIN_ISR:-1}" >> ./generated.server.properties
echo "log.retention.hours=${CONFIG_LOG_RETENTION_HOURS:-168}" >> ./generated.server.properties
echo "log.segment.bytes=${CONFIG_LOG_SEGMENT_BYTES:-1073741824}" >> ./generated.server.properties
echo "log.retention.check.interval.ms=${CONFIG_LOG_RETENTION_CHECK_INTERVAL_MS:-300000}" >> ./generated.server.properties

export CONFIG_SERVER_PATH="${CONFIG_SERVER_PATH:-./generated.server.properties}"

echo "Server config file"
cat $CONFIG_SERVER_PATH

mkdir -p "${CONFIG_LOG_DIRS:-/tmp/kraft-combined-logs}"
export META_PROPERTIES_FILE="${CONFIG_LOG_DIRS:-/tmp/kraft-combined-logs}/meta.properties"

if [ -f "$META_PROPERTIES_FILE" ]; then
    echo "$META_PROPERTIES_FILE exists, skipping generation"
else
    echo "node.id=${CONFIG_NODE_ID:-1}" >> "$META_PROPERTIES_FILE"
    echo "version=1" >> "$META_PROPERTIES_FILE"
    echo "cluster.id=tlmg7bOxQEylD5m0MLNt4Q" >> "$META_PROPERTIES_FILE"
fi

echo "Meta properties"
cat "$META_PROPERTIES_FILE"

/kafka/server $JVM_ARGS $CONFIG_SERVER_PATH