#mkdir ./fabric-ca
./fix-docker-deamon.sh
sleep 5
cd .. && docker-compose -f docker-compose-root-ca.yaml up -d
sleep 5
sudo chmod 777 -R fabric-ca

cd sh-scripts && ./rootca.sh #### OK

cd .. && docker-compose -f docker-compose-int-ca.yaml up -d   ####OK
sleep 5
#############
sudo chmod 777 -R fabric-ca ####OK
sleep 5
cd sh-scripts && ./intca.sh ####OK

# OK
./identities.sh

./msp.sh

./artifacts.sh
cd .. && docker-compose -f docker-compose-cli-couchdb.yaml up -d
sleep 5
cd sh-scripts && ./channels.sh #video 8 MIn 1:17:09

