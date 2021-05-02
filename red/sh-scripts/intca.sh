# ORG 1
export CSR_NAMES_ORG1="C=CO,ST=Cundinamarca,L=Bogotá,O=Eps1,OU=Hyperledger Fabric"
# Enroll bootstrap identity of int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps1.historiaclinicaelectronica.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7056 --csr.names "$CSR_NAMES_ORG1"
# Enroll bootstrap identity of tls int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps1.historiaclinicaelectronica.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7057 --csr.names "$CSR_NAMES_ORG1"

# ORG 2
export CSR_NAMES_ORG2="C=CO,ST=Valle del Cauca,L=Cali,O=Eps2,OU=Hyperledger Fabric"
# Enroll bootstrap identity of int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps2.historiaclinicaelectronica.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8056 --csr.names "$CSR_NAMES_ORG2"
# Enroll bootstrap identity of tls int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps2.historiaclinicaelectronica.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8057 --csr.names "$CSR_NAMES_ORG2"

# ORG 3
export CSR_NAMES_ORG3="C=CO,ST=Meta,L=Villavivencio,O=Eps3,OU=Hyperledger Fabric"
# Enroll bootstrap identity of int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps3.historiaclinicaelectronica.com/int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:9056 --csr.names "$CSR_NAMES_ORG3"
# Enroll bootstrap identity of tls int CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps3.historiaclinicaelectronica.com/tls-int/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:9057 --csr.names "$CSR_NAMES_ORG3"

## ORG historiaclinicaelectronica
#export CSR_NAMES_historiaclinicaelectronica="C=BE,ST=Flemish Brabant,L=Louvain,O=historiaclinicaelectronica,OU=Hyperledger Fabric"
## Enroll bootstrap identity of int CA
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/historiaclinicaelectronica.com/int/clients/admin
#fabric-ca-client enroll -u http://admin:adminpw@localhost:10056 --csr.names "$CSR_NAMES_historiaclinicaelectronica"
## Enroll bootstrap identity of tls int CA
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/historiaclinicaelectronica.com/tls-int/clients/admin
#fabric-ca-client enroll -u http://admin:adminpw@localhost:10057 --csr.names "$CSR_NAMES_historiaclinicaelectronica"
