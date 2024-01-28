#!/usr/bin/env bash

TEMP_DIR="$(mktemp -d)" 
mkdir -p ${TOOLS_DIR}/maven ${TOOLS_DIR}/maven/ref 
curl -fsSL -o ${TEMP_DIR}/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz 
tar -xzf ${TEMP_DIR}/apache-maven.tar.gz -C ${TOOLS_DIR}/maven --strip-components=1  
rm -rf "${TEMP_DIR}"
cd ${TOOLS_DIR}/bin
ln -s ../maven/bin/mvn mvn
