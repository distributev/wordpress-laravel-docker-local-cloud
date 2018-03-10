#!/bin/bash

set -ex

NODE_VERSION="8.9.4"
YARN_VERSION="1.3.2"

ARCH= && dpkgArch="$(dpkg --print-architecture)"

case "${dpkgArch##*-}" in
  amd64) ARCH='x64';;
  ppc64el) ARCH='ppc64le';;
  s390x) ARCH='s390x';;
  arm64) ARCH='arm64';;
  armhf) ARCH='armv7l';;
  i386) ARCH='x86';;
  *) echo "unsupported architecture"; exit 1 ;;
esac

curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz"
curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt"
grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c -
tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt
ln -s /usr/local/bin/node /usr/local/bin/nodejs
npm install -g webpack@3.10.0

curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
mkdir -p /opt/yarn
tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1
ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn
ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg
rm yarn-v$YARN_VERSION.tar.gz
