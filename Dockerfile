FROM bigboards/java-8-__arch__
#FROM bigboards/java-8-x86_64

MAINTAINER bigboards (hello@bigboards.io)

ENV DATATORRENT_VERSION 3.4.0

RUN set -x \
    && curl -LO https://www.datatorrent.com/downloads/datatorrent-rts.bin \
    && sudo sh ./datatorrent-rts.bin \
    && sudo rm ./datatorrent-rts.bin \
    && curl -LO http://www.eu.apache.org/dist/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz | tar -xz -C /opt \
    && cd /opt \
    && ln -s ./hadoop-2.6.4 hadoop

ENV DATATORRENT_HOME=/opt/datatorrent/current
ENV HADOOP_PREFIX /opt/hadoop
ENV YARN_HOME /opt/hadoop
ENV HADOOP_YARN_HOME /opt/hadoop
ENV HADOOP_HDFS_HOME /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV HADOOP_MAPRED_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV HDFS_CONF_DIR /opt/hadoop/etc/hadoop
ENV YARN_CONF_DIR /opt/hadoop/etc/hadoop

ADD datatorrent-rts /bin/datatorrent-rts
RUN chmod a+x /bin/datatorrent-rts

ADD hadoop-shell /bin/hadoop-shell
RUN chmod a+x /bin/hadoop-shell

# dtgateway runs on 9090
EXPOSE 9090

CMD ["/bin/datatorrent-rts"]
