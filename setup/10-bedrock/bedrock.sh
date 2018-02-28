#!/bin/bash
set -ax

BEDROCK_PATH=$1

if [ ! -d $BEDROCK_PATH ]; then

  echo "Installing bedrock..."
  composer create-project roots/bedrock $BEDROCK_PATH
  
fi

