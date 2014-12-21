FROM debian:jessie

RUN apt-get update && apt-get install -y openjdk-7-jre-headless
ADD http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz /
RUN tar -xzf /zookeeper-3.4.6.tar.gz
RUN rm /zookeeper-3.4.6.tar.gz
ADD /zoo.cfg /zookeeper-3.4.6/conf/zoo.cfg
ADD /start.sh /

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888
VOLUME /var/lib/zookeeper

CMD ["/start.sh"]
