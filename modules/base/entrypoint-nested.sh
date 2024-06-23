#!/usr/bin/env bash

if [ ! -d "${HOME}" ]
then
  mkdir -p "${HOME}"
fi

mkdir -p ${HOME}/.config/containers
(echo '[containers]';echo 'netns="private"';echo 'default_sysctls = []';echo '[engine]';echo 'network_cmd_options=[';echo '  "enable_ipv6=false"';echo ']') > ${HOME}/.config/containers/containers.conf
(echo 'unqualified-search-registries = [';echo '  "registry.access.redhat.com",';echo '  "registry.redhat.io",';echo '  "docker.io"'; echo ']'; echo 'short-name-mode = "permissive"') > ${HOME}/.config/containers/registries.conf

if ! whoami &> /dev/null
then
  if [ -w /etc/passwd ]
  then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi
USER=$(whoami)
START_ID=$(( $(id -u)+1 ))
echo "${USER}:${START_ID}:2147483646" > /etc/subuid
echo "${USER}:${START_ID}:2147483646" > /etc/subgid

if [ ! -f ${HOME}/.zshrc ]
then
  (echo "HISTFILE=${HOME}/.zsh_history"; echo "HISTSIZE=1000"; echo "SAVEHIST=1000") > ${HOME}/.zshrc
fi

/usr/libexec/podman/catatonit -- "$@"