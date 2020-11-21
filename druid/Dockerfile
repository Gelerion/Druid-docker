FROM openjdk:8

ARG DRUID_VERSION=0.20.0
ARG MAVEN_REPO_CENTRAL=https://repo1.maven.org/maven2
ENV DRUID_VERSION ${DRUID_VERSION}
ENV MAVEN_REPO_CENTRAL ${MAVEN_REPO_CENTRAL}
ENV LOG_LEVEL info

RUN apt-get update \
      && apt-get install -y curl gettext-base

# Install druid
RUN curl https://downloads.apache.org/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz > /opt/druid-${DRUID_VERSION}-bin.tar.gz \
      && tar -xvf /opt/druid-${DRUID_VERSION}-bin.tar.gz -C /opt/ \
      && rm -f /opt/druid-${DRUID_VERSION}-bin.tar.gz \
      && mv /opt/apache-druid-${DRUID_VERSION} /opt/druid \
      && mkdir -p /var/log/druid \
      && mkdir -p /opt/druid/data \
      && curl ${MAVEN_REPO_CENTRAL}/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar > /opt/druid/extensions/mysql-metadata-storage/mysql-connector-java-5.1.38.jar \
      && rm -rf /opt/druid/conf /opt/druid/conf-quickstart

COPY conf /opt/druid/conf/
COPY druid-start.sh /usr/bin/
COPY druid-service-checker.sh /usr/bin/
COPY druid-pull-deps.sh /usr/bin/

RUN chmod +x /usr/bin/druid-start.sh \
     && chmod +x /usr/bin/druid-service-checker.sh \
     && chmod +x /usr/bin/druid-pull-deps.sh

WORKDIR /opt/druid

CMD druid-start.sh