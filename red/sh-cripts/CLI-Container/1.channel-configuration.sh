cd channel-artifacts

export CHANNEL_NAME=historiaclinicaelectronica

#Creación canal

peer channel create -o orderer.historiaclinicaelectronica.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/historiaclinicaelectronica.com/orderers/orderer.historiaclinicaelectronica.com/msp/tlscacerts/tlsca.historiaclinicaelectronica.com-cert.pem


#Unir EPS 1 (org1) al Canal  Sesión 4 1:41:48
peer channel join -b historiaclinicaelectronica.block

#Unir EPS 2 (org2) al Canal

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/users/Admin@eps2.historiaclinicaelectronica.com/msp CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt peer channel join -b historiaclinicaelectronica.block

# Unir EPS 3 (org2) al Canal

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/users/Admin@eps3.historiaclinicaelectronica.com/msp CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt peer channel join -b historiaclinicaelectronica.block

# Transacción de configuración Anchor Peers EPS1
peer channel update -o orderer.historiaclinicaelectronica.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Eps1MSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/historiaclinicaelectronica.com/orderers/orderer.historiaclinicaelectronica.com/msp/tlscacerts/tlsca.historiaclinicaelectronica.com-cert.pem

# Transacción de configuración Anchor Peers EPS2
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/users/Admin@eps2.historiaclinicaelectronica.com/msp CORE_PEER_ADDRESS=peer0.eps2.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps2MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps2.historiaclinicaelectronica.com/peers/peer0.eps2.historiaclinicaelectronica.com/tls/ca.crt peer channel update -o orderer.historiaclinicaelectronica.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Eps2MSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/historiaclinicaelectronica.com/orderers/orderer.historiaclinicaelectronica.com/msp/tlscacerts/tlsca.historiaclinicaelectronica.com-cert.pem

# Transacción de configuración Anchor Peers EPS3
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/users/Admin@eps3.historiaclinicaelectronica.com/msp CORE_PEER_ADDRESS=peer0.eps3.historiaclinicaelectronica.com:7051 CORE_PEER_LOCALMSPID="Eps3MSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/eps3.historiaclinicaelectronica.com/peers/peer0.eps3.historiaclinicaelectronica.com/tls/ca.crt peer channel update -o orderer.historiaclinicaelectronica.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/Eps3MSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/historiaclinicaelectronica.com/orderers/orderer.historiaclinicaelectronica.com/msp/tlscacerts/tlsca.historiaclinicaelectronica.com-cert.pem

