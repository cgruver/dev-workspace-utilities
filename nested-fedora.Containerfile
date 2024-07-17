FROM quay.io/fedora/fedora:40

USER root
ENV  BUILDAH_ISOLATION="chroot"
ENV HOME="/home/user" 
ENV VSCODE_NODEJS_RUNTIME_DIR="/usr/local/node/bin/" 
ENV JAVA_HOME="/etc/alternatives/jre_21_openjdk" 
ENV JBANG_DIR="/usr/local/jbang" 
ENV PATH="${PATH}:/usr/local/node/bin"
ARG MAVEN_VERSION="3.9.6"
ARG QUARKUS_VERSION="3.6.6"
ARG NODE_VERSION="v18.19.0"
COPY entrypoint-nested.sh /

RUN dnf --setopt=tsflags=nodocs --setopt=install_weak_deps=0 install -y procps-ng openssl openssh-clients libbrotli git tar gzip zip xz unzip which shadow-utils bash zsh vim-enhanced wget2 jq ca-certificates podman buildah skopeo podman-docker fuse-overlayfs slirp4netns python3.9 python3-pip python3-devel java-21-openjdk-devel ; \
  dnf update -y ; \
  dnf clean all ; \
  mkdir -p ${HOME} ; \
  mkdir -p /usr/local/bin ; \
  chgrp -R 0 /home ; \
  chmod -R g=u /home ; \
  chown 0:0 /entrypoint-nested.sh ; \
  chmod +x /entrypoint-nested.sh ; \
  chown 0:0 /etc/passwd ; \
  chown 0:0 /etc/group ; \
  chmod g=u /etc/passwd /etc/group ; \
  # Setup for rootless podman
  setcap cap_setuid+ep /usr/bin/newuidmap ; \
  setcap cap_setgid+ep /usr/bin/newgidmap ; \
  touch /etc/subgid /etc/subuid ; \
  chown 0:0 /etc/subgid ; \
  chown 0:0 /etc/subuid ; \
  chmod -R g=u /etc/subuid /etc/subgid ; \
  # Create Sym Links for OpenShift CLI (Assumed to be retrieved by an init-container)
  ln -s /projects/bin/oc /usr/local/bin/oc ; \
  ln -s /projects/bin/kubectl /usr/local/bin/kubectl ; \
  # Ansible
  pip3 install ansible-navigator ; \
  pip3 install ansible ; \
  pip3 install ansible-lint ; \
  # AWS CLI
  TEMP_DIR="$(mktemp -d)" ; \
  curl -fsSL -o ${TEMP_DIR}/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip ; \
  unzip ${TEMP_DIR}/awscliv2.zip -d ${TEMP_DIR} ; \
  ${TEMP_DIR}/aws/install ; \
  rm -rf "${TEMP_DIR}" ; \
  pip3 install aws-sam-cli ; \
  pip3 install awscli-local ; \
  # Maven
  TEMP_DIR="$(mktemp -d)" ; \
  mkdir -p /usr/local/maven /usr/local/maven/ref ; \
  curl -fsSL -o ${TEMP_DIR}/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz ; \ 
  tar -xzf ${TEMP_DIR}/apache-maven.tar.gz -C /usr/local/maven --strip-components=1 ; \
  rm -rf "${TEMP_DIR}" ; \
  cd /usr/local/bin ; \
  ln -s ../maven/bin/mvn mvn ; \
  # Quarkus CLI
  TEMP_DIR="$(mktemp -d)" ; \
  mkdir -p /usr/local/quarkus-cli/lib ; \
  mkdir /usr/local/quarkus-cli/bin ; \
  curl -fsSL -o ${TEMP_DIR}/quarkus-cli.tgz https://github.com/quarkusio/quarkus/releases/download/${QUARKUS_VERSION}/quarkus-cli-${QUARKUS_VERSION}.tar.gz ; \
  tar -xzf ${TEMP_DIR}/quarkus-cli.tgz -C ${TEMP_DIR} ; \
  cp ${TEMP_DIR}/quarkus-cli-${QUARKUS_VERSION}/bin/quarkus /usr/local/quarkus-cli/bin ; \
  cp ${TEMP_DIR}/quarkus-cli-${QUARKUS_VERSION}/lib/quarkus-cli-${QUARKUS_VERSION}-runner.jar /usr/local/quarkus-cli/lib ; \
  chmod +x /usr/local/quarkus-cli/bin/quarkus ; \
  rm -rf "${TEMP_DIR}" ; \
  cd /usr/local/bin ; \
  ln -s ../quarkus-cli/bin/quarkus quarkus ; \
  mkdir -p ${JBANG_DIR} ; \
  curl -Ls https://sh.jbang.dev | bash -s - app setup ; \
  ln -s ${JBANG_DIR}/bin/jbang /usr/local/bin/jbang ; \
  # Node
  TEMP_DIR="$(mktemp -d)" ; \
  curl -fsSL -o ${TEMP_DIR}/node.tz https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz ; \
  tar -x --no-auto-compress -f ${TEMP_DIR}/node.tz -C ${TEMP_DIR} ; \
  mv ${TEMP_DIR}/node-${NODE_VERSION}-linux-x64 /usr/local/node ; \
  rm -rf "${TEMP_DIR}" ; \
  chmod -R g=u ${HOME}

ENTRYPOINT ["/entrypoint-nested.sh"]
CMD ["tail", "-f", "/dev/null"]
