FROM registry.access.redhat.com/ubi9-minimal

EXPOSE 9042 9160 7000 7001

ENV CASSANDRA_VERSION="4.1.6" \
    CASSANDRA_HOME="/opt/apache-cassandra" \
    HOME="/home/cassandra" \
    PATH="${PATH}:/opt/apache-cassandra/bin" 

USER root

COPY entrypoint.sh /entrypoint.sh
COPY cassandra.yaml /cassandra.yaml

RUN microdnf --disableplugin=subscription-manager install -y procps-ng bash tar java-11-openjdk-devel bind-utils vim-enhanced vim-minimal which; \
  microdnf update -y ; \
  microdnf clean all ; \
  TEMP_DIR="$(mktemp -d)" ; \
  curl -fsSL -o ${TEMP_DIR}/cassandra.tgz https://dlcdn.apache.org/cassandra/${CASSANDRA_VERSION}/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz ; \
  tar -xzf ${TEMP_DIR}/cassandra.tgz -C /opt ; \
  rm -rf "${TEMP_DIR}" ; \
  ln -s /opt/apache-cassandra-${CASSANDRA_VERSION} /opt/apache-cassandra ; \
  chmod +x /entrypoint.sh ; \
  mkdir -p ${HOME} ; \
  mkdir -p /cassandra ; \
  chown -R 0:0 ${HOME} /cassandra ; \
  chown 0:0 /etc/passwd /etc/group /cassandra.yaml; \
  chmod -R go+rw ${HOME} /opt/apache-cassandra-${CASSANDRA_VERSION} /cassandra ; \
  chmod -R g=u ${HOME} /opt/apache-cassandra-${CASSANDRA_VERSION} /cassandra /etc/passwd /etc/group /cassandra.yaml

VOLUME /cassandra

ENTRYPOINT [ "/entrypoint.sh" ]