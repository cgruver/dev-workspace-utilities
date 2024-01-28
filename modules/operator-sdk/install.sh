#!/usr/bin/env bash

curl -fsSL -o ${TOOLS_DIR}/bin/operator-sdk https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}/operator-sdk_linux_amd64
chmod +x ${TOOLS_DIR}/bin/operator-sdk
