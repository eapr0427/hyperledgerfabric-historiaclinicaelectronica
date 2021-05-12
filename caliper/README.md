# Caliper setup with NPMS

npm init -y
<!-- npm install --only=prod @hyperledger/caliper-cli@0.3.2 -->
npm install --only=prod @hyperledger/caliper-cli@0.4.1

npx caliper bind --caliper-bind-sut fabric:2.1.0 --caliper-bind-sdk 2.1.0 --caliper-fabric-gateway-usegateway --caliper-flow-only-test

# Launch Caliper master

npx caliper launch manager \
    --caliper-workspace . \
    --caliper-benchconfig benchmarks/scenario/hce-lifecycle/config.yaml \
    --caliper-networkconfig networks/hce-network-local.yaml \
    --caliper-flow-only-test \
    --caliper-fabric-gateway-usegateway \
    --caliper-fabric-gateway-discovery \
    --caliper-fabric-gateway-enabled


<!-- npx caliper launch manager \
    --caliper-workspace . \
    --caliper-benchconfig benchmarks/scenario/hce-lifecycle/config.yaml \
    --caliper-networkconfig networks/hce-network-local.yaml \
    --caliper-fabric-gateway-enabled -->


     QUEDAMOS AQUI VIDEO https://www.youtube.com/watch?v=ypF36RGaG1Q MINUTO 14:27

     #blocksize
     #blocktype
     #number of endorserments
