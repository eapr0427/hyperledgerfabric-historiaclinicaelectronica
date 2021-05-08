function createChannelMSP() {
    org=$1

    MSP_PATH=../fabric-ca/$org/msp
    mkdir -p $MSP_PATH
    mkdir $MSP_PATH/cacerts && cp ../fabric-ca/$org/root/ca-cert.pem $MSP_PATH/cacerts/ca-cert.pem
    mkdir $MSP_PATH/intermediatecerts && cp ../fabric-ca/$org/int/ca-cert.pem $MSP_PATH/intermediatecerts/ca-cert.pem
    mkdir $MSP_PATH/tlscacerts && cp ../fabric-ca/$org/tls-root/ca-cert.pem $MSP_PATH/tlscacerts/ca-cert.pem
    mkdir $MSP_PATH/tlsintermediatecerts && cp ../fabric-ca/$org/tls-int/ca-cert.pem $MSP_PATH/tlsintermediatecerts/ca-cert.pem
}

function createLocalMSP() {
    org=$1
    name=$2
    type=$3

    LOCAL_MSP_PATH=../fabric-ca/$org/${type}s/$name/msp

    mkdir -p $LOCAL_MSP_PATH
    cp ../fabric-ca/$org/msp/config.yaml $LOCAL_MSP_PATH
    mkdir $LOCAL_MSP_PATH/cacerts && cp ../fabric-ca/$org/root/ca-cert.pem $LOCAL_MSP_PATH/cacerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/intermediatecerts && cp ../fabric-ca/$org/int/ca-cert.pem $LOCAL_MSP_PATH/intermediatecerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/tlscacerts && cp ../fabric-ca/$org/tls-root/ca-cert.pem $LOCAL_MSP_PATH/tlscacerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/tlsintermediatecerts && cp ../fabric-ca/$org/tls-int/ca-cert.pem $LOCAL_MSP_PATH/tlsintermediatecerts/ca-cert.pem
    mkdir $LOCAL_MSP_PATH/signcerts && cp -r ../fabric-ca/$org/int/clients/$name/msp/signcerts $LOCAL_MSP_PATH/
    key=$(find ../fabric-ca/$org/int/clients/$name/msp/keystore -name *_sk)
    mkdir $LOCAL_MSP_PATH/keystore && cp $key $LOCAL_MSP_PATH/keystore/priv.key
}

function createTLSFolder(){
    org=$1
    name=$2
    type=$3

    TLS_FOLDER_PATH=../fabric-ca/$org/${type}s/$name/tls

    mkdir -p $TLS_FOLDER_PATH
    cp ../fabric-ca/$org/tls-int/ca-chain.pem $TLS_FOLDER_PATH/ca.crt
    cp ../fabric-ca/$org/tls-int/clients/$name/msp/signcerts/cert.pem $TLS_FOLDER_PATH/server.crt
    key=$(find ../fabric-ca/$org/tls-int/clients/$name/msp/keystore -name *_sk)
    cp $key $TLS_FOLDER_PATH/server.key
}

createChannelMSP eps1.historiaclinicaelectronica.com
createChannelMSP eps2.historiaclinicaelectronica.com
createChannelMSP eps3.historiaclinicaelectronica.com

createLocalMSP eps1.historiaclinicaelectronica.com peer0.eps1.historiaclinicaelectronica.com peer
createTLSFolder eps1.historiaclinicaelectronica.com peer0.eps1.historiaclinicaelectronica.com peer

createLocalMSP eps2.historiaclinicaelectronica.com peer0.eps2.historiaclinicaelectronica.com peer
createTLSFolder eps2.historiaclinicaelectronica.com peer0.eps2.historiaclinicaelectronica.com peer

createLocalMSP eps3.historiaclinicaelectronica.com peer0.eps3.historiaclinicaelectronica.com peer
createTLSFolder eps3.historiaclinicaelectronica.com peer0.eps3.historiaclinicaelectronica.com peer

createLocalMSP eps1.historiaclinicaelectronica.com orderer.eps1.historiaclinicaelectronica.com orderer
createTLSFolder eps1.historiaclinicaelectronica.com orderer.eps1.historiaclinicaelectronica.com orderer

createLocalMSP eps2.historiaclinicaelectronica.com orderer.eps2.historiaclinicaelectronica.com orderer
createTLSFolder eps2.historiaclinicaelectronica.com orderer.eps2.historiaclinicaelectronica.com orderer

createLocalMSP eps3.historiaclinicaelectronica.com orderer.eps3.historiaclinicaelectronica.com orderer
createTLSFolder eps3.historiaclinicaelectronica.com orderer.eps3.historiaclinicaelectronica.com orderer

createLocalMSP eps1.historiaclinicaelectronica.com admin@eps1.historiaclinicaelectronica.com user
createTLSFolder eps1.historiaclinicaelectronica.com admin@eps1.historiaclinicaelectronica.com user

createLocalMSP eps2.historiaclinicaelectronica.com admin@eps2.historiaclinicaelectronica.com user
createTLSFolder eps2.historiaclinicaelectronica.com admin@eps2.historiaclinicaelectronica.com user

createLocalMSP eps3.historiaclinicaelectronica.com admin@eps3.historiaclinicaelectronica.com user
createTLSFolder eps3.historiaclinicaelectronica.com admin@eps3.historiaclinicaelectronica.com user


createLocalMSP eps1.historiaclinicaelectronica.com client@eps1.historiaclinicaelectronica.com user
createTLSFolder eps1.historiaclinicaelectronica.com client@eps1.historiaclinicaelectronica.com user

createLocalMSP eps2.historiaclinicaelectronica.com client@eps2.historiaclinicaelectronica.com user
createTLSFolder eps2.historiaclinicaelectronica.com client@eps2.historiaclinicaelectronica.com user

createLocalMSP eps3.historiaclinicaelectronica.com client@eps3.historiaclinicaelectronica.com user
createTLSFolder eps3.historiaclinicaelectronica.com client@eps3.historiaclinicaelectronica.com user
