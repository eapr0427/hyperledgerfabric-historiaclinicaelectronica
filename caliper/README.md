# Caliper setup with NPMS

npm init -y
npm install --only=prod @hyperledger/caliper-cli@0.3.2
npx caliper bind --caliper-bind-sut fabric:latest-v2 --caliper-bind-sdk latest-v2 --caliper-fabric-gateway-usegateway --caliper-flow-only-test

# Launch Caliper master

npx caliper launch master \
    --caliper-workspace . \
    --caliper-benchconfig benchmarks/scenario/currency-lifecycle/config.yaml \
    --caliper-networkconfig networks/acme-network-local.yaml \
    --caliper-flow-only-test \
    --caliper-fabric-gateway-usegateway \
     --caliper-fabric-gateway-discovery