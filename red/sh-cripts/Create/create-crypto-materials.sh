#!/bin/bash
###########################################
#

echo '####################################################'
echo 'Recreate crypto config'
echo '####################################################'
cryptogen generate --config=./crypto-config.yaml


echo '####################################################'
echo 'Creación de bloque génesis'
echo '####################################################'

configtxgen -profile HistoriaClinicaOrdererGenesis -channelID system-channel -outputBlock ./channel-artifacts/genesis.block

echo '####################################################'
echo 'Creación Transacción del Canal'
echo '####################################################'
configtxgen -profile HistoriaClinicaChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID historiaclinicaelectronica

echo '####################################################'
echo 'Creación Anchor transaction files'
echo '####################################################'

configtxgen -profile HistoriaClinicaChannel -outputAnchorPeersUpdate ./channel-artifacts/Eps1MSPanchors.tx -channelID historiaclinicaelectronica -asOrg Eps1MSP

configtxgen -profile HistoriaClinicaChannel -outputAnchorPeersUpdate ./channel-artifacts/Eps2MSPanchors.tx -channelID historiaclinicaelectronica -asOrg Eps2MSP

configtxgen -profile HistoriaClinicaChannel -outputAnchorPeersUpdate ./channel-artifacts/Eps3MSPanchors.tx -channelID historiaclinicaelectronica -asOrg Eps3MSP