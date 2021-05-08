sudo docker-compose -f docker-compose-root-ca.yaml up -d
sleep 5
./rootca.sh
docker-compose -f docker-compose-int-ca.yaml up -d