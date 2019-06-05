Apache Druid (incubating) Configuration Reference:
 http://druid.io/docs/latest/configuration/index.html

For more explanations and "production-ready" configuration take a look on:
 https://github.com/znly/docker-druid/tree/master/conf/druid

We may use two possible options in order to reduce image size
 - Run docker-slim command as shown here: https://github.com/docker-slim/docker-slim
 - Use multi stages build with distroless as a base image, as shown here: https://github.com/gerbal/incubator-druid/blob/master/distribution/docker/Dockerfile

Alternatives:
 https://github.com/khwj/docker-druid
 https://github.com/wizzie-io/druid-docker
 https://github.com/druid-io/docker-druid
 https://github.com/anskarl/druid-docker-cluster

Druid Scala client library: 
 https://github.com/ing-bank/scruid