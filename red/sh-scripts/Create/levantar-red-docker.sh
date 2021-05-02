echo '####################################################'
echo 'SET VARIABLES'
echo '####################################################'
export CHANNEL_NAME=historiaclinicaelectronica
export VERBOSE=false
export FABRIC_CFG_PATH=$PWD

echo '####################################################'
echo 'LEVANTAR RED DOCKER'
echo '####################################################'
sudo CHANNEL_NAME=$CHANNEL_NAME docker-compose -f ../../docker-compose-cli-couchdb.yaml up -d


echo '####################################################'
echo 'LEVANTAR PORTAINER'
echo '####################################################'

#EAPR 25/04/2021 Creo que no es necesario correr este script para levantar portainer luego de reiniciar linux
#docker volume create portainer_data


sudo docker run -d -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer