*NOTE: This work is derived out of work by wurstmeister at [wurstmeister/kafka-docker](https://github.com/wurstmeister/kafka-docker)*

# mirrormaker-docker
Docker setup for apache kafka mirrormaker

# Requirements
- Docker
- docker-enter (install with `$> docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter`)
- fig

# Setup
 - Modify all `KAFKA_ADVERTISED_HOST_NAME` in `fig.yml` to match the IP address of the host machine running docker. see [kafka-docker](https://github.com/wurstmeister/kafka-docker) for more info
 - Whitelist for mirrormaker is specified as `WHITELIST` in `fig.yml`. For testing it is set to 'MM-.\*'
 - Change files ./image-files/\*.config to suit your requirements, if any.


# Starting a cluster
```sh
$> fig up -d
$> fig scale kafkadc1=2
$> fig scale kafkadc2=2
```
This will start two kakfa clusters, dc1 and dc2 and a mirrormaker that will replicate any topic with name 'MM-.\*' in dc2 to dc1


# Testing mirromaker
* Start a consumer in DC1
```sh
$> docker-enter mirrormakerdocker_kafkadc1_1
$> $KAFKA_HOME/bin/kafka-console-consumer.sh --zookeeper=$ZK_PORT_2181_TCP_ADDR:$ZK_PORT_2181_TCP_PORT --from-beginning --topic MM-TEST
```
* Start a producer in DC2 (in another terminal)
```sh
$> docker-enter mirrormakerdocker_kafkadc2_1
$> $KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic MM-TEST
```

# Stopping the cluster
```sh
$> fig stop
```
