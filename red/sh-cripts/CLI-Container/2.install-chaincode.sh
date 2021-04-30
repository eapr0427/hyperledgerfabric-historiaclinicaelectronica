export CHANNEL_NAME=historiaclinicaelectronica
export CHAINCODE_NAME=controlhistoriaclinica
export CHAINCODE_VERSION=1
export CC_RUNTIME_LANGUAGE=golang
# CC_SRC_PATH es la ruta al chaincode
export CC_SRC_PATH="../../../chaincode/$CHAINCODE_NAME/"
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/historiaclinicaelectronica.com/msp/tlscacerts/tlsca.historiaclinicaelectronica.com-cert.pem

#Descarga dependencias
#export FABRIC_CFG_PATH=$PWD/configtx
#pushd ../chaincode/$CHAINCODE_NAME
#GO111MODULE=on go mod vendor
#popd

#CICLO DE VIDA DEL CHAINCODE

# 1. Empaquetar el chaincode
peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} --label ${CHAINCODE_NAME}_${CHAINCODE_VERSION} >&log.txt


#2. peer lifecycle chaincode install example
# Instalación en cada peer del empaquetado (Chaincode)
#first peer peer0.org1.acme.com
peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
#peer lifecycle chaincode install controlhistoriaclinica.tar.gz



#Chaincode code package identifier: controlhistoriaclinica_1:b3ed006f1fad0e2802a9c062f71bf925bb0124699cf422f1cc6af8d523b6976e
#Actualizar este  valor con el que obtengan al empaquetar el chaincode: controlhistoriaclinica_1:b3ed006f1fad0e2802a9c062f71bf925bb0124699cf422f1cc6af8d523b6976e
export CC_PACKAGEID=b3ed006f1fad0e2802a9c062f71bf925bb0124699cf422f1cc6af8d523b6976e

# peer0.org2
#Instalación Chaincode Organización 2

#CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.acme.com/users/Admin@org2.acme.com/msp CORE_PEER_ADDRESS=peer0.org2.acme.com:7051 CORE_PEER_LOCALMSPID="Org2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.acme.com/peers/peer0.org2.acme.com/tls/ca.crt peer lifecycle chaincode install  ${CHAINCODE_NAME}.tar.gz
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/users/Admin@eps2.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz

# peer0.org3
# Instalación Chaincode Organización 3
#CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3.acme.com/users/Admin@org3.acme.com/msp CORE_PEER_ADDRESS=peer0.org3.acme.com:7051 CORE_PEER_LOCALMSPID="Org3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3.acme.com/peers/peer0.org3.acme.com/tls/ca.crt peer lifecycle chaincode install  ${CHAINCODE_NAME}.tar.gz
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/users/Admin@eps3.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz


#Endorsement policy for lifecycle chaincode 
######## PASO 3 Políticas de Endorsamiento (Aprobar una definición de smartcontract para su organización)
#Aprobación para primera organización

peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --waitForEvent --signature-policy "OR ('Eps1MSP.peer', 'Eps3MSP.peer')" --package-id controlhistoriaclinica_1:$CC_PACKAGEID


#Aprobación para tercera organización
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/users/Admin@eps3.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --waitForEvent --signature-policy "OR ('Eps1MSP.peer', 'Eps3MSP.peer')" --package-id controlhistoriaclinica_1:$CC_PACKAGEID


#Para verificar las políticas de endorsamiento:
peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --signature-policy "OR ('Eps1MSP.peer','Eps3MSP.peer')" --output json
 

 #PASO 4 Commit del Chaincode en la red ORG1 Y ORG3
peer lifecycle chaincode commit -o orderer.historiaclinicaelectronica.com:7050 --tls --cafile $ORDERER_CA --peerAddresses peer0.eps1.historiaclinicaelectronica.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/tls/ca.crt --peerAddresses peer0.eps3.historiaclinicaelectronica.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt  --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --signature-policy "OR ('Eps1MSP.peer','Eps3MSP.peer')"



#check the status of chaincode commit
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --output json

############################################################################
#chaincode is committed and useable in the fabric network
#INIT LEDGER
#peer chaincode invoke -o orderer.acme.com:7050 --tls --cafile $ORDERER_CA -C  $CHANNEL_NAME  -n $CHAINCODE_NAME -c '{"Args":["InitLedger"]}'
#Org1 invokes set() with key “car01” and value “........”.
peer chaincode invoke -o orderer.historiaclinicaelectronica.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Store","ehr:1", "Jovanni Pineda", "Manuel Gutiérrez"]}'


#check the value of key “car01”
peer chaincode query -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Query","ehr:1"]}'



#ERROR CASE Org2 invoke CreateCar().
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/users/Admin@eps2.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt peer chaincode invoke -o orderer.historiaclinicaelectronica.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Store","did:4", "Paciente 2", "Doctor inválido"]}'