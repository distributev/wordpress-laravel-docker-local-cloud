#!/bin/bash
set -ax

BEDROCK_PATH=$1

echo "Installing bedrock..."
composer create-project roots/bedrock $BEDROCK_PATH
