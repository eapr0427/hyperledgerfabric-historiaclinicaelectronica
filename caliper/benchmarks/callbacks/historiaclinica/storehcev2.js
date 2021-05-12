'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

// const colors = ['blue', 'red', 'green', 'yellow', 'black', 'purple', 'white', 'violet', 'indigo', 'brown'];
// const makes = ['Toyota', 'Ford', 'Hyundai', 'Volkswagen', 'Tesla', 'Peugeot', 'Chery', 'Fiat', 'Tata', 'Holden'];
// const models = ['Prius', 'Mustang', 'Tucson', 'Passat', 'S', '205', 'S22L', 'Punto', 'Nano', 'Barina'];
// const owners = ['Tomoko', 'Brad', 'Jin Soo', 'Max', 'Adrianna', 'Michel', 'Aarav', 'Pari', 'Valeria', 'Shotaro'];

const contractID = "controlhistoriaclinica";
const version = "v0.1";

/**
 * Workload module for the benchmark round.
 */
class CreateCarWorkload extends WorkloadModuleBase {
    /**
     * Initializes the workload module instance.
     */
    constructor() {
        super();
        this.txIndex = 0;
    }

    /**
     * Assemble TXs for the round.
     * @return {Promise<TxStatus[]>}
     */
    async submitTransaction() {
        // let carColor = colors[Math.floor(Math.random() * colors.length)];
        // let carMake = makes[Math.floor(Math.random() * makes.length)];
        // let carModel = models[Math.floor(Math.random() * models.length)];
        // let carOwner = owners[Math.floor(Math.random() * owners.length)];

        let historiaClinicaId = Math.floor(Math.random() * 1000000000).toString();
        let patient = 'Patient test' ;
        let doctor = 'Doctor test';

        let args = {
            contractId: 'controlhistoriaclinica',
            contractVersion: 'v1.0',
            contractFunction: 'Store',
            contractArguments: [historiaClinicaId, patient, doctor],
            timeout: 30
        };

        await this.sutAdapter.sendRequests(args);
    }
}

/**
 * Create a new instance of the workload module.
 * @return {WorkloadModuleInterface}
 */
function createWorkloadModule() {
    return new CreateCarWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;