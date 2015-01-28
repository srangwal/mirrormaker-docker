FROM      ubuntu:trusty
MAINTAINER Wurstmeister
MAINTAINER srangwal

RUN       apt-get update; apt-get install -y unzip  openjdk-6-jdk wget git docker.io

RUN       wget -q http://mirror.gopotato.co.uk/apache/kafka/0.8.2-beta/kafka_2.9.1-0.8.2-beta.tgz -O /tmp/kafka_2.9.1-0.8.2-beta.tgz
RUN       tar xfz /tmp/kafka_2.9.1-0.8.2-beta.tgz -C /opt

VOLUME    ["/kafka"]

ENV       KAFKA_HOME /opt/kafka_2.9.1-0.8.2-beta

RUN       mkdir -p /opt/mirrormaker/
ADD       ./image-files/consumer.config /opt/mirrormaker/
ADD       ./image-files/producer.config /opt/mirrormaker/

ADD       ./image-files/start-mirrormaker.sh /usr/bin/start-mirrormaker.sh
CMD       start-mirrormaker.sh
