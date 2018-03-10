#!/bin/bash

#dos2unix to convert script from DOS format to the Unix. Otherwise we'll have bugs when running containers on Windows
apt-get install -y zip unzip netcat