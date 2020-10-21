FROM ubuntu:focal

ENV ES_JAVA_OPTS="-Xms512m -Xmx512m"

RUN apt update; \
    apt install -y wget software-properties-common; \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -; \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/; \
    apt install -y adoptopenjdk-8-hotspot; \
    apt remove -y --purge software-properties-common; \
    apt autoremove -y --purge;

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-6.4.2.deb; \
    apt install ./elasticsearch-oss-6.4.2.deb; \
    rm -f elasticsearch-oss-6.4.2.deb; \
    apt clean;

RUN chmod -vR 755 /etc/elasticsearch/; \
    chmod -vR 755 /var/lib/elasticsearch/; \
    chmod -vR 755 /usr/share/elasticsearch/;

VOLUME [ "/usr/share/elasticsearch/data" ]
#EXPOSE 9200

CMD [ "/etc/init.d/elasticsearch", "start" ]
