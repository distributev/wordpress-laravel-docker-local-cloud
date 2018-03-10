#!/bin/bash

set -ex

GOSU_VERSION="1.10"

#Installing GOSU

apt-get update;
apt-get install -y --no-install-recommends wget;
rm -rf /var/lib/apt/lists/*;
dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')";
wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch";
chmod +x /usr/local/bin/gosu;
# verify that the binary works
gosu nobody true