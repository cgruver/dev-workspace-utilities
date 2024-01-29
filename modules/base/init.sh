#!/usr/bin/env bash

microdnf update -y
microdnf clean all
mkdir -p ${HOME}
mkdir -p /usr/local/bin
chgrp -R 0 /home
chmod -R g=u /home
cp /tmp/artifacts/entrypoint.sh /entrypoint.sh
chown 0:0 /entrypoint.sh
chmod +x /entrypoint.sh
chown 0:0 /etc/passwd
chown 0:0 /etc/group
chmod g=u /etc/passwd /etc/group