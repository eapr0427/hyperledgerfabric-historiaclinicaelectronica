"use strict";

const logger = require("@hyperledger/caliper-core").CaliperUtils.getLogger(
  "currency-mint"
);

module.exports.info = "Creating a Patient HCE";

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
  patient = args.patient;
  doctor = args.doctor;
  historiaClinicaId = args.historiaClinicaId;

  // try {
  //   console.log(
  //     `Client ${clientIdx}: Setting trustline for ${receiver} to receive from ${minter}`
  //   );
  //   const trustlineArgs = {
  //     chaincodeFunction: currencyCode + "CurrencyContract:SetTrustline",
  //     invokerIdentity: receiverIdentity,
  //     chaincodeArguments: [minter, true, "-1"],
  //     targetPeers: targetPeers,
  //   };
  //   await bc.bcObj.invokeSmartContract(ctx, contractID, version, trustlineArgs);
  // } catch (error) {
  //   console.log(
  //     `Client ${clientIdx}: Smart Contract threw with error: ${error}`
  //   );
  // }

  logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX EAPR Initialized workload module");
  return Promise.resolve();
};

module.exports.run = async () => {
  let txArgs = {
    chaincodeFunction: "Store",
    chaincodeArguments: [patient, doctor, historiaClinicaId],
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
