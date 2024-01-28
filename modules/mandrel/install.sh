#!/usr/bin/env bash

TEMP_DIR="$(mktemp -d)"
mkdir -p ${TOOLS_DIR}/graalvm 
curl -fsSL -o ${TEMP_DIR}/mandrel-java17-linux-amd64-${MANDREL_VERSION}.tar.gz https://github.com/graalvm/mandrel/releases/download/mandrel-${MANDREL_VERSION}/mandrel-java17-linux-amd64-${MANDREL_VERSION}.tar.gz 
tar xzf ${TEMP_DIR}/mandrel-java17-linux-amd64-${MANDREL_VERSION}.tar.gz -C ${TOOLS_DIR}/graalvm --strip-components=1 
rm -rf "${TEMP_DIR}"
