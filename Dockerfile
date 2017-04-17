# Ports:
# 8080 - Zeppelin web application port
# 8443 - Zeppelin web application secure port

# Volumes:
# /opt/zeppelin/logs
# /opt/zeppelin/notebook

FROM openjdk:8-jdk-alpine

LABEL maintainer "kamilduda01@gmail.com"

ENV ZEPPELIN_HOME=/opt/zeppelin
ENV PATH="$PATH:$ZEPPELIN_HOME"

# Update system
RUN \
  apk update && \
  apk upgrade && \
  apk add wget tar bash&& \
  rm -rf /var/cache/apk/* && \
  rm -rf /var/lib/apk/* && \
  rm -rf /etc/apk/cache/*

### Install Zeppelin
ARG ZEPPELIN_MIRROR=http://ftp.ps.pl/pub/apache/zeppelin
ARG ZEPPELIN_VERSION=0.7.1
ARG ZEPPELIN_ARCHIVE=zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz
ARG ZEPPELIN_URL=${ZEPPELIN_MIRROR}/zeppelin-${ZEPPELIN_VERSION}/${ZEPPELIN_ARCHIVE}

RUN \
  mkdir -p "${ZEPPELIN_HOME}" && \
  wget $ZEPPELIN_URL && \
  tar -xzf $ZEPPELIN_ARCHIVE --strip-components=1 -C $ZEPPELIN_HOME && \
  rm -f $ZEPPELIN_ARCHIVE


### Install Spark
# Version
ARG SPARK_VERSION="2.1.0"
ARG HADOOP_VERSION="2.7"

# Set home and path
ENV SPARK_HOME="/usr/local/spark-$SPARK_VERSION"
ENV PATH="$PATH:$SPARK_HOME/bin"
ENV PATH="$PATH:$SPARK_HOME/sbin"

ARG SPARK_ARCHIVE=spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz
ARG SPARK_URL=http://ftp.ps.pl/pub/apache/spark/spark-$SPARK_VERSION/$SPARK_ARCHIVE

# Download and install
RUN \
  mkdir -p "${SPARK_HOME}" && \
  wget $SPARK_URL && \
  tar -xzf $SPARK_ARCHIVE --strip-components=1 -C $SPARK_HOME && \
  rm -f $SPARK_ARCHIVE


VOLUME ${ZEPPELIN_HOME}/logs
VOLUME ${ZEPPELIN_HOME}/notebook

EXPOSE 8080 8443

WORKDIR ${ZEPPELIN_HOME}
CMD bash bin/zeppelin.sh run
