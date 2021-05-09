#mkdir ./fabric-ca

cd .. && docker-compose -f docker-compose-root-ca.yaml up -d
sleep 5
sudo chmod 777 -R fabric-ca

cd sh-scripts && ./rootca.sh #### OK

cd .. && docker-compose -f docker-compose-int-ca.yaml up -d   ####OK
sleep 5

sudo chmod 777 -R fabric-ca ####OK
sleep 5
cd sh-scripts && ./intca.sh ####OK

# OK
./identities.sh
#createLocalMSP historiaclinicaelectronica.com admin@historiaclinicaelectronica.com user
#createTLSFolder historiaclinicaelectronica.com admin@historiaclinicaelectronica.com user

./msp.sh

./artifacts.sh
cd .. && docker-compose -f docker-compose-cli-couchdb.yaml up -d
sleep 5
cd sh-scripts && ./channels.sh

MIN 35:44
