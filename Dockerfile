FROM      ubuntu:trusty
MAINTAINER Wurstmeister
MAINTAINER srangwal

RUN       apt-get update; apt-get install -y unzip  openjdk-6-jdk wget git docker.io

RUN       wget -q http://mirror.gopotato.co.uk/apache/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz -O /tmp/kafka_2.10-0.8.2.0.tgz
RUN       tar xfz /tmp/kafka_2.10-0.8.2.0.tgz -C /opt

VOLUME    ["/kafka"]

ENV       KAFKA_HOME /opt/kafka_2.10-0.8.2.0

RUN       mkdir -p /opt/mirrormaker/
ADD       ./image-files/consumer.config /opt/mirrormaker/
ADD       ./image-files/producer.config /opt/mirrormaker/

ADD       ./image-files/start-mirrormaker.sh /usr/bin/start-mirrormaker.sh
CMD       start-mirrormaker.sh
