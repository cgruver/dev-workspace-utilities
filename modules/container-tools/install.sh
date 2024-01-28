#!/usr/bin/env bash

setcap cap_setuid+ep /usr/bin/newuidmap
setcap cap_setgid+ep /usr/bin/newgidmap
touch /etc/subgid /etc/subuid
chown root:root /etc/subgid
chown root:root /etc/subuid
chmod -R g=u /etc/passwd /etc/group /etc/subuid /etc/subgid