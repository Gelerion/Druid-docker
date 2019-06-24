#!/usr/bin/env bash
envsubst < /opt/druid/conf/_common/common.runtime.properties_env > /opt/druid/conf/_common/common.runtime.properties
envsubst < /opt/druid/conf/_common/log4j2.xml_env > /opt/druid/conf/_common/log4j2.xml
envsubst < /opt/druid/conf/${DRUID_SERVICE}/runtime.properties_env > /opt/druid/conf/${DRUID_SERVICE}/runtime.properties

# pull deps
/usr/bin/druid-pull-deps.sh

# start service
java ${DRUID_JVM_ARGS} -cp /opt/druid/conf/_common:/opt/druid/conf/_common/hadoop_xml/:/opt/druid/conf/${DRUID_SERVICE}:/opt/druid/lib/*: org.apache.druid.cli.Main server ${DRUID_SERVICE}