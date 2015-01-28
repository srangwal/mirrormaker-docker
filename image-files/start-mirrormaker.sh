#!/bin/bash

[[ -z "$WHITELIST" ]] && echo "WHITELIST is required" && exit 1

export MIRRORMAKER_CONFIG_DIR=/opt/mirrormaker

export KAFKA_ZOOKEEPER_CONNECT=$ZK_PORT_2181_TCP_ADDR:$ZK_PORT_2181_TCP_PORT
echo "ZOOKEEPER: $KAFKA_ZOOKEEPER_CONNECT"

export KAFKA_BROKER_LIST="$KAFKA_PORT_9092_TCP_ADDR:$KAFKA_PORT_9092_TCP_PORT"
echo "BROKER LIST: $KAFKA_BROKER_LIST"


echo "group.id=mirrormaker-$RANDOM" >> $MIRRORMAKER_CONFIG_DIR/consumer.config
echo "zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT" >> $MIRRORMAKER_CONFIG_DIR/consumer.config


echo "metadata.broker.list=$KAFKA_BROKER_LIST" >> $MIRRORMAKER_CONFIG_DIR/producer.config

echo "Consumer config"
cat $MIRRORMAKER_CONFIG_DIR/consumer.config

echo "Producer config"
cat $MIRRORMAKER_CONFIG_DIR/producer.config
echo "======="

echo $WHITELIST

# Uncomment the line below for debugging mirror maker issues
#sed -i "s/log4j.rootLogger=WARN, stdout/log4j.rootLogger=DEBUG, stdout/" $KAFKA_HOME/config/tools-log4j.properties

$KAFKA_HOME/bin/kafka-run-class.sh kafka.tools.MirrorMaker --consumer.config $MIRRORMAKER_CONFIG_DIR/consumer.config --num.streams 3 --producer.config $MIRRORMAKER_CONFIG_DIR/producer.config --whitelist="$WHITELIST"
