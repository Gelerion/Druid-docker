FROM openjdk:8

ARG DRUID_VERSION=0.14.2-incubating
ENV DRUID_VERSION ${DRUID_VERSION}
ENV LOG_LEVEL info

RUN apt-get update \
      && apt-get install -y curl gettext-base

# Install druid
RUN curl http://apache.spd.co.il/incubator/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz > /opt/druid-${DRUID_VERSION}-bin.tar.gz \
      && tar -xvf /opt/druid-${DRUID_VERSION}-bin.tar.gz -C /opt/ \
      && rm -f /opt/druid-${DRUID_VERSION}-bin.tar.gz \
      && mv /opt/apache-druid-${DRUID_VERSION} /opt/druid \
      && mkdir -p /var/log/druid \
      && mkdir -p /opt/druid/data \
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