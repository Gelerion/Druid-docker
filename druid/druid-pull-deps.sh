#!/usr/bin/env bash

function add_user_defined_extensions {
  for ext in ${DRUID_PULL_EXTENSION}; do
  	extensions+="-c $ext "
  done
}

function add_user_defined_hadoop_extensions {
  if [[ ! -z "${HADOOP_VERSION}" ]]; then
  	extensions+="-h org.apache.hadoop:hadoop-client:${HADOOP_VERSION} "

  	# downaload additional haddop extensions, hadoop-aws for example
  	for hadoop_ext in ${DRUID_HADOOP_EXTENIONS}; do
  		extensions+="-h ${hadoop_ext}:${HADOOP_VERSION} "
  	done

  else 
  	extensions="--no-default-hadoop ${extensions}" 
  fi
}

pushd /opt/druid
if [[ ! -z "${DRUID_PULL_EXTENSION}" ]]; then

  IFS=';'

  extensions=""
  add_user_defined_extensions
  add_user_defined_hadoop_extensions

  IFS=' '

  command="org.apache.druid.cli.Main tools pull-deps --defaultVersion ${DRUID_VERSION} ${extensions}"

  java -cp "lib/*" \
  	-Dlog4j.configurationFile=file:///opt/druid/conf/_common/log4j2.xml \
  	-Ddruid.extensions.directory="extensions" \
  	-Ddruid.extensions.hadoopDependenciesDir="hadoop-dependencies" \
  	$command
fi
popd