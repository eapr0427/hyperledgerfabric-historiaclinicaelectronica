#EPS 1

export CHANNEL_NAME=historiaclinicaelectronica
export CHAINCODE_NAME=controlhistoriaclinica
export CHAINCODE_VERSION=1
export CC_RUNTIME_LANGUAGE=golang
# CC_SRC_PATH es la ruta al chaincode
export CC_SRC_PATH="../../chaincode/$CHAINCODE_NAME/"
export CC_VERSION=v1.0
#export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/historiaclinicaelectronica.com/msp/tlscacerts/tlsca.historiaclinicaelectronica.com-cert.pem
export ORDERER_CA=$PWD/crypto/eps1.historiaclinicaelectronica.com/orderers/orderer.eps1.historiaclinicaelectronica.com/tls/ca.crt
export CORE_PEER_ADDRESS=peer0.eps1.historiaclinicaelectronica.com:7051
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/crypto/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/tls/ca.crt
#export CORE_PEER_TLS_ROOTCERT_FILE=$(cd ../../red && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/tls/ca.crt)

export CORE_PEER_MSPCONFIGPATH=$PWD/crypto/eps1.historiaclinicaelectronica.com/users/admin@eps1.historiaclinicaelectronica.com/msp
#export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/users/admin@eps1.historiaclinicaelectronica.com/msp)

export CC_SEQUENCE=1
export ORDERER_ADDRESS=orderer.eps1.historiaclinicaelectronica.com:7050


#Descarga dependencias
#export FABRIC_CFG_PATH=$PWD/configtx
#pushd ../chaincode/$CHAINCODE_NAME
#GO111MODULE=on go mod vendor
#popd

#CICLO DE VIDA DEL CHAINCODE
#RUTA: /opt/gopath/src/github.com/hyperledger/fabric/peer

# 1. Empaquetar el chaincode
peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} --label ${CHAINCODE_NAME}_${CHAINCODE_VERSION} >&log.txt

#si hay error de mismatch borrar archivo go.sum - SESION 5 MInuto 1:22:13

#2. peer lifecycle chaincode install example
# Instalación en cada peer del empaquetado (Chaincode) - SESION 5 MInuto 1:30:52
#peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
#Bram credenciales peer0 eps 1
peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE
#peer lifecycle chaincode install controlhistoriaclinica.tar.gz

#Chaincode code package identifier: controlhistoriaclinica_1:b3ed006f1fad0e2802a9c062f71bf925bb0124699cf422f1cc6af8d523b6976e
#Actualizar este  valor con el que obtengan al empaquetar el chaincode: controlhistoriaclinica_1:b3ed006f1fad0e2802a9c062f71bf925bb0124699cf422f1cc6af8d523b6976e
export CC_PACKAGE_ID=4064ea5aedaa26edd3eba3c867f984c5c197c61202c60d761f90db1c517c27d6

peer lifecycle chaincode approveformyorg -o $ORDERER_ADDRESS --tls \
--cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CHAINCODE_NAME \
--version $CC_VERSION --package-id $CC_PACKAGE_ID --sequence $CC_SEQUENCE --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE \
--peerAddresses $CORE_PEER_ADDRESS --signature-policy "OUTOF(2, 'Eps1MSP.peer','Eps2MSP.peer','Eps3MSP.peer')" #--collections-config collections.json 

#Para verificar las políticas de endorsamiento:
peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --signature-policy "OR ('Eps1MSP.peer','Eps3MSP.peer')" --output json
 

# EPS2
#host linux ruta de ejecucion de los comandos: ~/hyperledgerfabric-historiaclinicaelectronica/red/channel-artifacts

export CORE_PEER_ADDRESS=localhost:8051
#export CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:8051
#export CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051
export CORE_PEER_LOCALMSPID=Eps2MSP
export CORE_PEER_TLS_ROOTCERT_FILE=$(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt)
#export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/crypto/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/users/admin@eps2.historiaclinicaelectronica.com/msp)
#export CORE_PEER_MSPCONFIGPATH=$PWD/crypto/eps2.historiaclinicaelectronica.com/users/admin@eps2.historiaclinicaelectronica.com/msp
#CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/users/Admin@eps2.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz
export ORDERER_CA=$(cd ../../red && echo $PWD/fabric-ca/org2.acme.com/orderers/orderer.org2.acme.com/tls/ca.crt)
#export ORDERER_CA=$PWD/crypto/eps2.historiaclinicaelectronica.com/orderers/orderer.eps2.historiaclinicaelectronica.com/tls/ca.crt
export ORDERER_ADDRESS=localhost:8050
#export ORDERER_ADDRESS=orderer.eps2.historiaclinicaelectronica.com:8050
#export ORDERER_ADDRESS=orderer.eps2.historiaclinicaelectronica.com:7050

#peer lifecycle chaincode install ../../acme-network/channel-artifacts/$CC_NAME$CC_VERSION.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE
peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE
#peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE




####EPS3

export ORDERER_CA=$PWD/crypto/eps3.historiaclinicaelectronica.com/orderers/orderer.eps3.historiaclinicaelectronica.com/tls/ca.crt
export CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=$PWD/crypto/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=$PWD/crypto/eps3.historiaclinicaelectronica.com/users/admin@eps3.historiaclinicaelectronica.com/msp
export CC_SEQUENCE=1
export ORDERER_ADDRESS=orderer.eps3.historiaclinicaelectronica.com:9050




######## PASO 3 Políticas de Endorsamiento (Aprobar una definición de smartcontract para su organización)

peer lifecycle chaincode approveformyorg -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $CC_PACKAGE_ID --sequence $CC_SEQUENCE --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses $CORE_PEER_ADDRESS --signature-policy "OUTOF(2, 'Org1MSP.peer','Org2MSP.peer','Org3MSP.peer')" #--collections-config collections.json







#Instalación Chaincode Organización 2


# peer0.org3
# Instalación Chaincode Organización 3
#CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/users/Admin@eps3.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz


#Endorsement policy for lifecycle chaincode 
######## PASO 3 Políticas de Endorsamiento (Aprobar una definición de smartcontract para su organización)
#Aprobación para primera organización

#peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --waitForEvent --signature-policy "OR ('Eps1MSP.peer', 'Eps3MSP.peer')" --package-id controlhistoriaclinica_1:$CC_PACKAGEID





#Aprobación para tercera organización - EPS 3
#CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/users/Admin@eps3.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt peer lifecycle chaincode approveformyorg --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --waitForEvent --signature-policy "OR ('Eps1MSP.peer', 'Eps3MSP.peer')" --package-id controlhistoriaclinica_1:$CC_PACKAGEID


#Para verificar las políticas de endorsamiento:
#peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --signature-policy "OR ('Eps1MSP.peer','Eps3MSP.peer')" --output json
 

 ###########################COMMIT

 #PASO 4 Commit del Chaincode en la red ORG1 Y ORG3
peer lifecycle chaincode commit -o orderer.historiaclinicaelectronica.com:7050 --tls --cafile $ORDERER_CA --peerAddresses peer0.eps1.historiaclinicaelectronica.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/tls/ca.crt --peerAddresses peer0.eps3.historiaclinicaelectronica.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt  --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence 1 --signature-policy "OR ('Eps1MSP.peer','Eps3MSP.peer')"



#check the status of chaincode commit
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --output json

############################################################################
#chaincode is committed and useable in the fabric network
#INIT LEDGER
#Org1 invokes set() with key “car01” and value “........”.
peer chaincode invoke -o orderer.historiaclinicaelectronica.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Store","ehr:1", "Jovanni Pineda", "Manuel Gutiérrez"]}'


#check the value of key “car01”
peer chaincode query -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Query","ehr:1"]}'



#ERROR CASE Org2 invoke CreateCar().
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/users/Admin@eps2.historiaclinicaelectronica.com/msp/ CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt peer chaincode invoke -o orderer.historiaclinicaelectronica.com:7050 --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Store","did:4", "Paciente 2", "Doctor inválido"]}'