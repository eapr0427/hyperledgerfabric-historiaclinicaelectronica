#!/bin/bash
###########################################
#
# Simple Shell script to clean/remove all container/images
#
# The script will 
#  - first stop all running containers (if any),
#  - remove containers
#  - remove images
#  - remove volumes
#

# stop all running containers
echo '####################################################'
echo 'Stopping running containers (if available)...'
echo '####################################################'
docker stop $(docker ps -aq)

# remove all stopped containers
echo '####################################################'
echo 'Removing containers ..'
echo '####################################################'
docker rm -f $(docker ps -aq)


# remove all images
#echo '####################################################'
#echo 'Removing images ...'
#echo '####################################################'
#docker rmi $(docker images -q)

# remove all stray volumes if any
echo '####################################################'
echo 'Revoming docker container volumes (if any)'
echo '####################################################'
docker volume rm $(docker volume ls -q)



echo '####################################################'
echo 'pruning docker VOLUMES'
echo '####################################################'
docker volume prune -f

echo '####################################################'
echo 'pruning networks'
echo '####################################################'
docker network prune -f

echo '####################################################'
echo 'Removing crypto config'
echo '####################################################'
rm -rf crypto-config

echo '####################################################'
echo 'Removing channel artifacts'
echo '####################################################'
rm -rf channel-artifacts/*.block channel-artifacts/*.tx crypto-config