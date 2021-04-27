package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// SmartContract provee funciones para el control de la historia clínica electrónica
type SmartContract struct {
	// El contractapi es una API de contratos inteligentes de Fabric para interactuar con el ledger
	contractapi.Contract
}

//Definimos una estructura básica de nuestro activo (EHR)
// Los atributos de una estructura deben escribirse la primera en Mayúscula
//TODO extender HEALTH RECORD para poner tipos de datos complejso (PACIENTE, Medications)
type HealthRecord struct {
	Patient  string `json:"patient"`
	Doctor string `json:"doctor"`
}

//Función que me permite guardar en la blockchain

func (s *SmartContract) Store(ctx contractapi.TransactionContextInterface, historiaClinicaId string, patient string, doctor string) error {

	//TODO Validaciones de sintaxis

	//TODO validaciones de negocio HCE

	// TODO Validar que no exista el ID
	//historiaClinicaRecord, err := s.Query(ctx, historiaClinicaId)

	//if(historiaClinicaRecord != nil){
	//	fmt.Printf("Historia Clínica ya existe: %s", err.Error())
	//	return err
	//}

	historiaClinica := HealthRecord{
		Patient:  patient,
		Doctor: doctor,
	}

	hceAsBytes, err := json.Marshal(historiaClinica)

	if err != nil {
		fmt.Printf("Error en el método Marshal: %s", err.Error())
		return err
	}

	// GUARDADO EN EL BLOCKCHAIN (ledger - libro distribuido clave - valor)
	// La clave es el id de la historia clínica
	return ctx.GetStub().PutState(historiaClinicaId, hceAsBytes)
}

func (s *SmartContract) Query(ctx contractapi.TransactionContextInterface, historiaClinicaId string) (*HealthRecord, error) {

	// Consultamos el último estado del mundo en el Ledger asociado a un id
	hceAsBytes, err := ctx.GetStub().GetState(historiaClinicaId)

	if err != nil {
		return nil, fmt.Errorf("Failed to read from world state. %s", err.Error())
	}

	if hceAsBytes == nil {
		return nil, fmt.Errorf("%s does not exist", historiaClinicaId)
	}

	historiaClinica := new(HealthRecord)

	err = json.Unmarshal(hceAsBytes, historiaClinica)

	if err != nil {
		return nil, fmt.Errorf("Unmarshal error. %s", err.Error())
	}

	return historiaClinica, nil
}


// main() es un tipo especial de función y es el punto de entrada de los programas ejecutables
func main() {

	// En golang no es necesario definir un tipo de dato.
	// Una función puede retornar más de un resultado
	// NewChaincode devuelve varios valores
	// Instanciación con :=
	// INicializamos un chaincode nuevo

	chaincode, err := contractapi.NewChaincode(new(SmartContract))

	if err != nil {
		fmt.Printf("Error al crear el chaincode hcecontrol: %s", err.Error())
		return
	}

	//Verificamos que no haya errores en el método Start
	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error al iniciar el chaincode hcecontrol: %s", err.Error())
	}
}
