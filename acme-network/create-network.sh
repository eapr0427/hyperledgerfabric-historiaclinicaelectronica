#!/bin/bash
###########################################
#

echo '####################################################'
echo 'Recreate crypto config'
echo '####################################################'
cryptogen generate --config=./crypto-config.yaml


echo '####################################################'
echo 'CHANNEL_NAME=marketplace'
echo '####################################################'
export CHANNEL_NAME=marketplace
export VERBOSE=false
export FABRIC_CFG_PATH=$PWD

echo '####################################################'
echo 'LEVANTAR RED DOCKER'
echo '####################################################'
CHANNEL_NAME=$CHANNEL_NAME docker-compose -f docker-compose-cli-couchdb.yaml up -d


echo '####################################################'
echo 'LEVANTAR PORTAINER'
echo '####################################################'

docker volume create portainer_data


docker run -d -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
