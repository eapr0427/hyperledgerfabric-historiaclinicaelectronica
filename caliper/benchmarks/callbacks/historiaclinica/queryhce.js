"use strict";

const logger = require("@hyperledger/caliper-core").CaliperUtils.getLogger(
  "HCE - Query"
);

module.exports.info = "Querying a Patient HCE";

const contractID = "controlhistoriaclinica";
const version = "v0.1";

// save the objects during init
let bc,
  ctx,
  patient,
  doctor,
  historiaClinicaId,
  receiver,
  clientIdx,
  privateData,
  amount,
  targetPeers,
  receiverIdentity,
  utxoIDs = [];

/**
 * Initializes the workload module before the start of the round.
 * @param {BlockchainInterface} blockchain The SUT adapter instance.
 * @param {object} context The SUT-specific context for the round.
 * @param {object} args The user-provided arguments for the workload module.
 */
module.exports.init = async (blockchain, context, args) => {
  bc = blockchain;
  ctx = context;
  historiaClinicaId = args.historiaClinicaId;

  logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EAPR Initialized workload module");
  return Promise.resolve();
};

module.exports.run = async () => {
  let txArgs = {
    chaincodeFunction: "Query",
    chaincodeArguments: [historiaClinicaId],
  };

  return bc.bcObj.invokeSmartContract(
    ctx,
    "controlhistoriaclinica",
    "v1.0",
    txArgs,
    100
  );
};

module.exports.end = async () => {
  logger.debug("Disposed of workload module");
};
