#!/usr/bin/env bash

setcap cap_setuid+ep /usr/bin/newuidmap
setcap cap_setgid+ep /usr/bin/newgidmap
touch /etc/subgid /etc/subuid
chown 0:0 /etc/subgid
chown 0:0 /etc/subuid
chmod -R g=u /etc/subuid /etc/subgid
