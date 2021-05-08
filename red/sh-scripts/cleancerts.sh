function cleanCA(){
    org=$1
    ca=$2

    CA_PATH=../fabric-ca/$org/$ca
    echo "Ubicando carpeta " $CA_PATH
    sudo rm -r $CA_PATH/clients
    sudo rm -r $CA_PATH/msp
    sudo rm $CA_PATH/ca-cert.pem
    sudo rm $CA_PATH/fabric-ca-server.db
    sudo rm $CA_PATH/IssuerPublicKey
    sudo rm $CA_PATH/IssuerRevocationPublicKey
    CA_CHAIN_FILE=$CA_PATH/ca-chain.pem
    if test -f "$CA_CHAIN_FILE"; then
        sudo rm $CA_CHAIN_FILE
    fi
}

function cleanOrgMSP() {
    org=$1

    MSP_PATH=../fabric-ca/$org/msp
    sudo rm -r $MSP_PATH/cacerts
    sudo rm -r $MSP_PATH/intermediatecerts
    sudo rm -r $MSP_PATH/tlscacerts
    sudo rm -r $MSP_PATH/tlsintermediatecerts
}

function cleanLocalMSP() {
    org=$1
    name=$2
    type=$3

    LOCAL_MSP_PATH=../fabric-ca/$org/${type}s/$name/msp
    TLS_FOLDER_PATH=../fabric-ca/$org/${type}s/$name/tls

    sudo rm -r $LOCAL_MSP_PATH
    sudo rm -r $TLS_FOLDER_PATH
}

#cleanCA historiaclinicaelectronica.com root
#cleanCA historiaclinicaelectronica.com int
#cleanCA historiaclinicaelectronica.com tls-root
#cleanCA historiaclinicaelectronica.com tls-int
cleanCA eps1.historiaclinicaelectronica.com root
cleanCA eps1.historiaclinicaelectronica.com int
cleanCA eps1.historiaclinicaelectronica.com tls-root
cleanCA eps1.historiaclinicaelectronica.com tls-int
cleanCA eps2.historiaclinicaelectronica.com root
cleanCA eps2.historiaclinicaelectronica.com int
cleanCA eps2.historiaclinicaelectronica.com tls-root
cleanCA eps2.historiaclinicaelectronica.com tls-int
cleanCA eps3.historiaclinicaelectronica.com root
cleanCA eps3.historiaclinicaelectronica.com int
cleanCA eps3.historiaclinicaelectronica.com tls-root
cleanCA eps3.historiaclinicaelectronica.com tls-int

cleanOrgMSP eps1.historiaclinicaelectronica.com
cleanOrgMSP eps2.historiaclinicaelectronica.com
cleanOrgMSP eps3.historiaclinicaelectronica.com
#cleanOrgMSP historiaclinicaelectronica.com

cleanLocalMSP eps1.historiaclinicaelectronica.com orderer.eps1.historiaclinicaelectronica.com orderer
cleanLocalMSP eps2.historiaclinicaelectronica.com orderer.eps2.historiaclinicaelectronica.com orderer
cleanLocalMSP eps3.historiaclinicaelectronica.com orderer.eps3.historiaclinicaelectronica.com orderer

cleanLocalMSP eps1.historiaclinicaelectronica.com peer0.eps1.historiaclinicaelectronica.com peer
cleanLocalMSP eps2.historiaclinicaelectronica.com peer0.eps2.historiaclinicaelectronica.com peer
cleanLocalMSP eps3.historiaclinicaelectronica.com peer0.eps3.historiaclinicaelectronica.com peer
#cleanLocalMSP historiaclinicaelectronica.com orderer.historiaclinicaelectronica.com orderer

cleanLocalMSP eps1.historiaclinicaelectronica.com admin@eps1.historiaclinicaelectronica.com user
cleanLocalMSP eps2.historiaclinicaelectronica.com admin@eps2.historiaclinicaelectronica.com user
cleanLocalMSP eps3.historiaclinicaelectronica.com admin@eps3.historiaclinicaelectronica.com user
#cleanLocalMSP historiaclinicaelectronica.com admin@historiaclinicaelectronica.com user

cleanLocalMSP eps1.historiaclinicaelectronica.com client@eps1.historiaclinicaelectronica.com user
cleanLocalMSP eps2.historiaclinicaelectronica.com client@eps2.historiaclinicaelectronica.com user
cleanLocalMSP eps3.historiaclinicaelectronica.com client@eps3.historiaclinicaelectronica.com user
