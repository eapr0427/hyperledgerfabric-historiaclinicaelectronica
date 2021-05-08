# EPS 1
export CSR_NAMES_EPS1="C=CO,ST=Cundinamarca,L=Bogotá,O=Eps1,OU=Hyperledger Fabric"
# Enroll bootstrap identity of root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps1.historiaclinicaelectronica.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054 --csr.names "$CSR_NAMES_EPS1"
# Register intermediate CA in the root CA
fabric-ca-client register --id.name int.ca.eps1.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7054
# Enroll bootstrap identity of tls root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps1.historiaclinicaelectronica.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7055 --csr.names "$CSR_NAMES_EPS1"
# Register intermediate CA in the tls root CA
fabric-ca-client register --id.name tls.int.ca.eps1.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:7055

# EPS 2
export CSR_NAMES_EPS2="C=CO,ST=Valle del Cauca,L=Cali,O=Eps2,OU=Hyperledger Fabric"
# Enroll bootstrap identity of root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps2.historiaclinicaelectronica.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8054 --csr.names "$CSR_NAMES_EPS2"
# Register intermediate CA in the root CA
fabric-ca-client register --id.name int.ca.eps2.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:8054
# Enroll bootstrap identity of tls root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps2.historiaclinicaelectronica.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:8055 --csr.names "$CSR_NAMES_EPS2"
# Register intermediate CA in the tls root CA
fabric-ca-client register --id.name tls.int.ca.eps2.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:8055

# EPS 3
export CSR_NAMES_EPS3="C=CO,ST=Meta,L=Villavivencio,O=Eps3,OU=Hyperledger Fabric"
# Enroll bootstrap identity of root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps3.historiaclinicaelectronica.com/root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:9054 --csr.names "$CSR_NAMES_EPS3"
# Register intermediate CA in the root CA
fabric-ca-client register --id.name int.ca.eps3.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:9054
# Enroll bootstrap identity of tls root CA
export FABRIC_CA_CLIENT_HOME=../fabric-ca/eps3.historiaclinicaelectronica.com/tls-root/clients/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:9055 --csr.names "$CSR_NAMES_EPS3"
# Register intermediate CA in the tls root CA
fabric-ca-client register --id.name tls.int.ca.eps3.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:9055

## ORG historiaclinicaelectronica
#export CSR_NAMES_historiaclinicaelectronica="C=BE,ST=Flemish Brabant,L=Louvain,O=historiaclinicaelectronica,OU=Hyperledger Fabric"
## Enroll bootstrap identity of root CA
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/historiaclinicaelectronica.com/root/clients/admin
#fabric-ca-client enroll -u http://admin:adminpw@localhost:10054 --csr.names "$CSR_NAMES_historiaclinicaelectronica"
## Register intermediate CA in the root CA
#fabric-ca-client register --id.name int.ca.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:10054
## Enroll bootstrap identity of tls root CA
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/historiaclinicaelectronica.com/tls-root/clients/admin
#fabric-ca-client enroll -u http://admin:adminpw@localhost:10055 --csr.names "$CSR_NAMES_historiaclinicaelectronica"
## Register intermediate CA in the tls root CA
#fabric-ca-client register --id.name tls.int.ca.historiaclinicaelectronica.com --id.secret password --id.attrs 'hf.IntermediateCA=true' -u http://admin:adminpw@localhost:10055
