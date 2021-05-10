function joinChannel() {
  org=$1
  mspID=$2
  peerName=$3
  peerAddress=$4

  export CORE_PEER_ADDRESS=$peerAddress
  export CORE_PEER_LOCALMSPID=$mspID
  export CORE_PEER_TLS_ENABLED=true
  export CORE_PEER_TLS_ROOTCERT_FILE=$(cd ../ && echo $PWD/fabric-ca/$org/peers/$peerName/tls/ca.crt)
  export CORE_PEER_MSPCONFIGPATH=$(cd ../ && echo $PWD/fabric-ca/$org/users/admin@$org/msp)
  #peer channel join -b ../channel-artifacts/genesis.block

  peer channel join -b ../channel-artifacts/historiaclinicaelectronica.genesis.block
}

function updateChannelWithAnchorTx() {
    org=$1
    msp=$2
    peerAddress=$3
    ordererAddress=$4

    export CORE_PEER_ADDRESS=$peerAddress
    export CORE_PEER_LOCALMSPID=$msp
    export CORE_PEER_MSPCONFIGPATH=$(cd ../ && echo $PWD/fabric-ca/$org/users/admin@$org/msp)
    export ORDERER_CA=$(cd ../ && echo $PWD/fabric-ca/$org/orderers/orderer.$org/tls/ca.crt)

    peer channel update -c historiaclinicaelectronica -f ../channel-artifacts/${msp}anchors.tx -o $ordererAddress --tls --cafile $ORDERER_CA
}

which peer
if [ "$?" -ne 0 ]; then
    echo "peer tool not found. exiting"
    exit 1
fi

export FABRIC_CFG_PATH=$(cd ../ && pwd)
export CORE_PEER_MSPCONFIGPATH=$(cd ../ && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/users/admin@eps1.historiaclinicaelectronica.com/msp)
export CLIENTAUTH_CERTFILE=$(cd ../ && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/users/admin@eps1.historiaclinicaelectronica.com/tls/server.crt)
export CLIENTAUTH_KEYFILE=$(cd ../ && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/users/admin@eps1.historiaclinicaelectronica.com/tls/server.key)
export CORE_PEER_LOCALMSPID=Eps1MSP
export ORDERER_CA=$(cd ../ && echo $PWD/fabric-ca/eps1.historiaclinicaelectronica.com/orderers/orderer.eps1.historiaclinicaelectronica.com/tls/ca.crt)
# Create the application channel
peer channel create -o localhost:7050 -c historiaclinicaelectronica -f ../channel-artifacts/channel.tx --outputBlock ../channel-artifacts/historiaclinicaelectronica.genesis.block --tls --cafile $ORDERER_CA --clientauth --certfile $CLIENTAUTH_CERTFILE --keyfile $CLIENTAUTH_KEYFILE
# sleep 1
# # Let the peers join the channel
joinChannel eps1.historiaclinicaelectronica.com Eps1MSP peer0.eps1.historiaclinicaelectronica.com localhost:7051
joinChannel eps2.historiaclinicaelectronica.com Eps2MSP peer0.eps2.historiaclinicaelectronica.com localhost:8051
joinChannel eps3.historiaclinicaelectronica.com Eps3MSP peer0.eps3.historiaclinicaelectronica.com localhost:9051
# # Set the anchor peers in the network
updateChannelWithAnchorTx eps1.historiaclinicaelectronica.com Eps1MSP localhost:7051 localhost:7050
updateChannelWithAnchorTx eps2.historiaclinicaelectronica.com Eps2MSP localhost:8051 localhost:8050
updateChannelWithAnchorTx eps3.historiaclinicaelectronica.com Eps3MSP localhost:9051 localhost:9050