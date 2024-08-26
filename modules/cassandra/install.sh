#!/usr/bin/env bash

cp /tmp/artifacts/entrypoint.sh /entrypoint.sh
cp /tmp/artifacts/cassandra.yaml /cassandra.yaml
microdnf update -y
microdnf clean all
TEMP_DIR="$(mktemp -d)"
curl -fsSL -o ${TEMP_DIR}/cassandra.tgz https://dlcdn.apache.org/cassandra/${CASSANDRA_VERSION}/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz
tar -xzf ${TEMP_DIR}/cassandra.tgz -C /opt
rm -rf "${TEMP_DIR}"
ln -s /opt/apache-cassandra-${CASSANDRA_VERSION} /opt/apache-cassandra
chmod +x /entrypoint.sh
mkdir -p ${HOME}
mkdir -p /cassandra
chown -R 0:0 ${HOME} /cassandra /etc/passwd /etc/group /cassandra.yaml
chmod -R go+rw ${HOME} /opt/apache-cassandra-${CASSANDRA_VERSION} /cassandra
chmod -R g=u ${HOME} /opt/apache-cassandra-${CASSANDRA_VERSION} /cassandra /etc/passwd /etc/group /cassandra.yaml