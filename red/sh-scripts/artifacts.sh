function generateAnchorConfigurationTx() {
    msp=$1
    configtxgen -outputAnchorPeersUpdate ../channel-artifacts/${msp}anchors.tx -profile HistoriaClinicaChannel -asOrg $msp -channelID historiaclinicaelectronica
}

which configtxgen
if [ "$?" -ne 0 ]; then
    echo "configtxgen tool not found. exiting"
    exit 1
fi
export FABRIC_CFG_PATH=$(cd ../ && pwd)
configtxgen -profile HistoriaClinicaOrdererGenesis -channelID system-channel -outputBlock ../channel-artifacts/genesis.block
configtxgen -profile HistoriaClinicaChannel -outputCreateChannelTx ../channel-artifacts/channel.tx -channelID historiaclinicaelectronica
generateAnchorConfigurationTx Eps1MSP
generateAnchorConfigurationTx Eps2MSP
generateAnchorConfigurationTx Eps3MSP

