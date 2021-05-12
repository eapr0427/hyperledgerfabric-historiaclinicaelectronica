#video 9 hyperledger 1:27:20
# Sesión 10: Curso desarrollador Blockchain en Hyperledger Fabric. 1:09:24

export FABRIC_CFG_PATH=$(cd ../../red && pwd)
export CC_NAME=controlhistoriaclinica
export CC_VERSION=v1.0
export CC_SEQUENCE=1
export CHANNEL_NAME=historiaclinicaelectronica

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_LOCALMSPID=Eps1MSP
export CORE_PEER_TLS_ROOTCERT_FILE=$(cd ../../red && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/tls/ca.crt)
export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/users/admin@eps1.historiaclinicaelectronica.com/msp)
export ORDERER_CA=$(cd ../../red && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/orderers/orderer.eps1.historiaclinicaelectronica.com/tls/ca.crt)
export ORDERER_ADDRESS=localhost:7050

# ~/hyperledgerfabric-historiaclinicaelectronica/chaincode/controlhistoriaclinica
peer lifecycle chaincode package ../../red/channel-artifacts/$CC_NAME$CC_VERSION.tar.gz --path . --lang golang --label $CC_NAME$CC_VERSION
peer lifecycle chaincode install ../../red/channel-artifacts/$CC_NAME$CC_VERSION.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

###iMPORTANTE esto debe ir al inicio: controlhistoriaclinicav1.0
export CC_PACKAGE_ID=controlhistoriaclinicav1.0:49e6146e1fe32b679cad6ce484075f4600f8f672fa61324c33a0a1a657b28108

peer lifecycle chaincode approveformyorg -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $CC_PACKAGE_ID --sequence 1 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses $CORE_PEER_ADDRESS #--signature-policy "OUTOF(2, 'Eps1MSP.peer','Eps2MSP.peer','Eps3MSP.peer')"


export CORE_PEER_ADDRESS=localhost:8051
export CORE_PEER_LOCALMSPID=Eps2MSP
export CORE_PEER_TLS_ROOTCERT_FILE=$(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt)
export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/users/admin@eps2.historiaclinicaelectronica.com/msp)
export ORDERER_CA=$(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/orderers/orderer.eps2.historiaclinicaelectronica.com/tls/ca.crt)
export ORDERER_ADDRESS=localhost:8050
peer lifecycle chaincode install ../../red/channel-artifacts/$CC_NAME$CC_VERSION.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE
peer lifecycle chaincode approveformyorg -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $CC_PACKAGE_ID --sequence $CC_SEQUENCE --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses $CORE_PEER_ADDRESS #--signature-policy "OUTOF(2, 'Eps1MSP.peer','Eps2MSP.peer','Eps3MSP.peer')" #--collections-config collections.json

export CORE_PEER_ADDRESS=localhost:9051
export CORE_PEER_LOCALMSPID=Eps3MSP
export CORE_PEER_TLS_ROOTCERT_FILE=$(cd ../../red && echo $PWD/fabric-ca/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt)
export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps3.historiaclinicaelectronica.com/users/admin@eps3.historiaclinicaelectronica.com/msp)
export ORDERER_CA=$(cd ../../red && echo $PWD/fabric-ca/eps3.historiaclinicaelectronica.com/orderers/orderer.eps3.historiaclinicaelectronica.com/tls/ca.crt)
export ORDERER_ADDRESS=localhost:9050
peer lifecycle chaincode install ../../red/channel-artifacts/$CC_NAME$CC_VERSION.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tls $CORE_PEER_TLS_ENABLED --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE
peer lifecycle chaincode approveformyorg -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $CC_PACKAGE_ID --sequence $CC_SEQUENCE --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses $CORE_PEER_ADDRESS #--signature-policy "OUTOF(2, 'Eps1MSP.peer','Eps2MSP.peer','Eps3MSP.peer')" #--collections-config collections.json 
peer lifecycle chaincode commit -o $ORDERER_ADDRESS --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --sequence $CC_SEQUENCE --tls --cafile $ORDERER_CA --peerAddresses $CORE_PEER_ADDRESS --peerAddresses localhost:7051 --peerAddresses localhost:8051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --tlsRootCertFiles $(cd ../../red && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/peers/peer0.eps1.historiaclinicaelectronica.com/tls/ca.crt) --tlsRootCertFiles $(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt) #--signature-policy "OUTOF(2, 'Eps1MSP.peer','Eps2MSP.peer','Eps3MSP.peer')" #--collections-config collections.json


peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name $CC_NAME --output json


# Set user with permissions to interact with the chaincode
export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps3.historiaclinicaelectronica.com/users/client@eps3.historiaclinicaelectronica.com/msp)

#STORE HCE
peer chaincode invoke -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CC_NAME -c '{"Args":["Store","hce1:1", "Jovanni Pineda", "Mía Pineda"]}' --peerAddresses $CORE_PEER_ADDRESS --peerAddresses localhost:8051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --tlsRootCertFiles $(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt) #--transient "{\"mintPrivateData\":\"$DATA\"}"

#QUERY HCE
peer chaincode invoke -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CC_NAME -c '{"Args":["Query","hce1:1"]}' --peerAddresses $CORE_PEER_ADDRESS --peerAddresses localhost:8051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --tlsRootCertFiles $(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt) #--transient "{\"mintPrivateData\":\"$DATA\"}"


peer chaincode query -C $CHANNEL_NAME -n $CHAINCODE_NAME -c '{"Args":["Query","ehr:1"]}'


# Change org and user
export CORE_PEER_MSPCONFIGPATH=$(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/users/client@eps2.historiaclinicaelectronica.com/msp)
export CORE_PEER_LOCALMSPID=Eps2MSP

#STORE HCE
peer chaincode invoke -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CC_NAME -c '{"Args":["Store","hce1:5", "Nubia Rincón", "Mariana Pineda"]}' --peerAddresses $CORE_PEER_ADDRESS --peerAddresses localhost:8051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --tlsRootCertFiles $(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt) #--transient "{\"mintPrivateData\":\"$DATA\"}"

#QUERY HCE
peer chaincode invoke -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n $CC_NAME -c '{"Args":["Query","hce1:5"]}' --peerAddresses $CORE_PEER_ADDRESS --peerAddresses localhost:8051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --tlsRootCertFiles $(cd ../../red && echo $PWD/fabric-ca/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt) #--transient "{\"mintPrivateData\":\"$DATA\"}"