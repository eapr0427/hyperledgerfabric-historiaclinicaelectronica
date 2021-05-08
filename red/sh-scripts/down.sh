cd .. && docker-compose -f docker-compose-root-ca.yaml -f docker-compose-int-ca.yaml -f docker-compose-cli-couchdb.yaml down
docker rm $(docker ps -aq --filter 'name=cli')
docker rm $(docker ps -aq --filter 'name=peer')
docker rm $(docker ps -aq --filter 'name=couch')
docker rm $(docker ps -aq --filter 'name=orderer')
docker rm $(docker ps -aq --filter 'name=ca')
docker rm $(docker ps -aq --filter 'name=controlhistoriaclinica')
docker rmi $(docker images -q --filter 'reference=*controlhistoriaclinica*')
cd sh-scripts && ./cleancerts.sh
sudo rm -r ../channel-artifacts/*
sudo rm -r ../fabric-ca/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/production
sudo rm -r ../fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/production
sudo rm -r ../fabric-ca/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/production
sudo rm -r ../fabric-ca/eps1.historiaclinicaelectronica.com/orderers/orderer.eps1.historiaclinicaelectronica.com/production
sudo rm -r ../fabric-ca/eps2.historiaclinicaelectronica.com/orderers/orderer.eps2.historiaclinicaelectronica.com/production
sudo rm -r ../fabric-ca/eps3.historiaclinicaelectronica.com/orderers/orderer.eps3.historiaclinicaelectronica.com/production

