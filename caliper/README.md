# Caliper setup with NPMS

npm init -y
npm install --only=prod @hyperledger/caliper-cli@0.3.2
npx caliper bind --caliper-bind-sut fabric:latest-v2 --caliper-bind-sdk latest-v2 --caliper-fabric-gateway-usegateway --caliper-flow-only-test

# Launch Caliper master

npx caliper launch master \
    --caliper-workspace . \
    --caliper-benchconfig benchmarks/scenario/hce-lifecycle/config.yaml \
    --caliper-networkconfig networks/hce-network-local.yaml \
    --caliper-flow-only-test \
    --caliper-fabric-gateway-usegateway \
     --caliper-fabric-gateway-discovery

     No CA provided for org Eps1; unable to enrol users
     No admin.Eps1 found in caliper configuration file - unable to perform admin options

     QUEDAMOS AQUI VIDEO https://www.youtube.com/watch?v=ypF36RGaG1Q MINUTO 14:27

     #blocksize
     #blocktype
     #number of endorserments

adhavpavan@gmail.comWhy do certain transactions fail .. could it be the network design?