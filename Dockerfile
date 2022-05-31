FROM alpine:latest

ARG JDK_VERSION=17

USER root

RUN apk upgrade --no-cache && apk add --no-cache \
  autoconf \
  automake \
  bash \
  bzip2 \
  clang \
  cmake \
  curl \
  ed \
  gettext \
  git \
  gpg \
  graphviz \
  gzip \
  jq \
  llvm \
  musl \
  nodejs-dev \
  npm \
  openjdk${JDK_VERSION}-doc \
  openjdk${JDK_VERSION}-jdk \
  openjdk${JDK_VERSION}-src \
  openssh \
  openssl \
  rsync \
  sudo \
  tar \
  unzip \
  xz \
  zip \
  zlib

# Install sbt
RUN SBT_VERSION=$(curl -sL https://api.github.com/repos/sbt/sbt/releases/latest | jq -r '.tag_name' | grep -Eo '(\d+\.\d+\.\d+)') \
  && curl -L --retry 5 https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz | tar xzf - -C /opt \
  && ln -s /opt/sbt/bin/sbt /bin/sbt

# Install Maven
RUN M2_VERSION=$(curl -sL https://api.github.com/repos/apache/maven/releases/latest | jq -r '.tag_name' | grep -Eo '(\d+\.\d+\.\d+)') \
  && curl -L --retry 5 https://dlcdn.apache.org/maven/maven-3/${M2_VERSION}/binaries/apache-maven-${M2_VERSION}-bin.tar.gz | tar xzf - -C /opt \
  && ln -s /opt/apache-maven-${M2_VERSION}/bin/mvn /bin/mvn

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/bin/node"
LABEL maintainer="dev <at> zantekk.com"
