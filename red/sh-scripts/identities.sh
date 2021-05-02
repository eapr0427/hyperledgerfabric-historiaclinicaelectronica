function issueCertificates() {
    ca=$1
    ca_port=$2
    org=$3
    id_name=$4
    id_secret=$5
    id_type=$6
    csr_names=$7
    csr_hosts=$8


    # register identity with CA admin
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/admin
    fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type -u http://admin:adminpw@localhost:$ca_port
    # enroll registered identity
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/$id_name
    fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts"
}

function issueCertificatesWithAffiliation() {
    ca=$1
    ca_port=$2
    org=$3
    id_name=$4
    id_secret=$5
    id_type=$6
    id_affiliation=$7
    csr_names=$8
    csr_hosts=$9


    # register identity with CA admin
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/admin
    fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type --id.affiliation $id_affiliation -u http://admin:adminpw@localhost:$ca_port
    # enroll registered identity
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/$id_name
    fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts"
}

function issueTLSCertificates() {
    ca=$1
    ca_port=$2
    org=$3
    id_name=$4
    id_secret=$5
    id_type=$6
    csr_names=$7
    csr_hosts=$8


    # register identity with CA admin
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/admin
    fabric-ca-client register --id.name $id_name --id.secret $id_secret --id.type $id_type -u http://admin:adminpw@localhost:$ca_port
    # enroll registered identity
    export FABRIC_CA_CLIENT_HOME=../fabric-ca/$org/$ca/clients/$id_name
    fabric-ca-client enroll -u http://$id_name:$id_secret@localhost:$ca_port --csr.names "$csr_names" --csr.hosts "$csr_hosts" --enrollment.profile tls
}

# Eps1
export CSR_NAMES_ORG1="C=CO,ST=Cundinamarca,L=Bogotá,O=Eps1,OU=Hyperledger Fabric"

# issue certificates for admin user identity
issueCertificates int 7056 eps1.historiaclinicaelectronica.com admin@eps1.historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_ORG1" ""
issueTLSCertificates tls-int 7057 eps1.historiaclinicaelectronica.com admin@eps1.historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_ORG1" "admin@eps1.historiaclinicaelectronica.com,localhost"
# issue certificates for client identity and for client tls
issueCertificatesWithAffiliation int 7056 eps1.historiaclinicaelectronica.com client@eps1.historiaclinicaelectronica.com clientpw client marketplace "$CSR_NAMES_ORG1" ""
issueTLSCertificates tls-int 7057 eps1.historiaclinicaelectronica.com client@eps1.historiaclinicaelectronica.com clientpw client "$CSR_NAMES_ORG1" "client@eps1.historiaclinicaelectronica.com,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 7056 eps1.historiaclinicaelectronica.com peer0.eps1.historiaclinicaelectronica.com peerpw peer "$CSR_NAMES_ORG1" ""
issueTLSCertificates tls-int 7057 eps1.historiaclinicaelectronica.com peer0.eps1.historiaclinicaelectronica.com peerpw peer "$CSR_NAMES_ORG1" "peer0.eps1.historiaclinicaelectronica.com,localhost"
# issue certificates for orderer node identity and for orderer server tls
issueCertificates int 7056 eps1.historiaclinicaelectronica.com orderer.eps1.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_ORG1" ""
issueTLSCertificates tls-int 7057 eps1.historiaclinicaelectronica.com orderer.eps1.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_ORG1" "orderer.eps1.historiaclinicaelectronica.com,localhost"

# Eps2
export CSR_NAMES_ORG2="C=CO,ST=Valle del Cauca,L=Cali,O=Eps2,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 8056 eps2.historiaclinicaelectronica.com admin@eps2.historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_ORG2" ""
issueTLSCertificates tls-int 8057 eps2.historiaclinicaelectronica.com admin@eps2.historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_ORG2" "admin@eps2.historiaclinicaelectronica.com,localhost"
# issue certificates for client identity and for client tls
issueCertificatesWithAffiliation int 8056 eps2.historiaclinicaelectronica.com client@eps2.historiaclinicaelectronica.com clientpw client marketplace "$CSR_NAMES_ORG2" ""
issueTLSCertificates tls-int 8057 eps2.historiaclinicaelectronica.com client@eps2.historiaclinicaelectronica.com clientpw client "$CSR_NAMES_ORG2" "client@eps2.historiaclinicaelectronica.com,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 8056 eps2.historiaclinicaelectronica.com peer0.eps2.historiaclinicaelectronica.com peerpw peer "$CSR_NAMES_ORG2" ""
issueTLSCertificates tls-int 8057 eps2.historiaclinicaelectronica.com peer0.eps2.historiaclinicaelectronica.com peerpw peer "$CSR_NAMES_ORG2" "peer0.eps2.historiaclinicaelectronica.com,localhost"
# issue certificates for orderer node identity and for orderer server tls
issueCertificates int 8056 eps2.historiaclinicaelectronica.com orderer.eps2.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_ORG2" ""
issueTLSCertificates tls-int 8057 eps2.historiaclinicaelectronica.com orderer.eps2.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_ORG2" "orderer.eps2.historiaclinicaelectronica.com,localhost"

# Eps3
export CSR_NAMES_ORG3="C=CO,ST=Meta,L=Villavivencio,O=Eps3,OU=Hyperledger Fabric"
# issue certificates for admin user identity
issueCertificates int 9056 eps3.historiaclinicaelectronica.com admin@eps3.historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_ORG3" ""
issueTLSCertificates tls-int 9057 eps3.historiaclinicaelectronica.com admin@eps3.historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_ORG3" "admin@eps3.historiaclinicaelectronica.com,localhost"
# issue certificates for client identity and for client tls
issueCertificatesWithAffiliation int 9056 eps3.historiaclinicaelectronica.com client@eps3.historiaclinicaelectronica.com clientpw client marketplace "$CSR_NAMES_ORG3" ""
issueTLSCertificates tls-int 9057 eps3.historiaclinicaelectronica.com client@eps3.historiaclinicaelectronica.com clientpw client "$CSR_NAMES_ORG3" "client@eps3.historiaclinicaelectronica.com,localhost"
# issue certificates for peer node identity and for peer server tls
issueCertificates int 9056 eps3.historiaclinicaelectronica.com peer0.eps3.historiaclinicaelectronica.com peerpw peer "$CSR_NAMES_ORG3"
issueTLSCertificates tls-int 9057 eps3.historiaclinicaelectronica.com peer0.eps3.historiaclinicaelectronica.com peerpw peer "$CSR_NAMES_ORG3" "peer0.eps3.historiaclinicaelectronica.com,localhost"
# issue certificates for orderer node identity and for orderer server tls
issueCertificates int 9056 eps3.historiaclinicaelectronica.com orderer.eps3.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_ORG3" ""
issueTLSCertificates tls-int 9057 eps3.historiaclinicaelectronica.com orderer.eps3.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_ORG3" "orderer.eps3.historiaclinicaelectronica.com,localhost"

## historiaclinicaelectronica
#export CSR_NAMES_historiaclinicaelectronica="C=BE,ST=Flemish Brabant,L=Louvain,O=historiaclinicaelectronica,OU=Hyperledger Fabric"
## issue certificates for admin user identity and admin client tls
#issueCertificates int 10056 historiaclinicaelectronica.com admin@historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_historiaclinicaelectronica" ""
#issueTLSCertificates tls-int 10057 historiaclinicaelectronica.com admin@historiaclinicaelectronica.com adminpw admin "$CSR_NAMES_historiaclinicaelectronica" "admin@historiaclinicaelectronica.com,localhost"
## issue certificates for orderer node identity and for orderer server tls
#issueCertificates int 10056 historiaclinicaelectronica.com orderer.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_historiaclinicaelectronica" ""
#issueTLSCertificates tls-int 10057 historiaclinicaelectronica.com orderer.historiaclinicaelectronica.com ordererpw orderer "$CSR_NAMES_historiaclinicaelectronica" "orderer.historiaclinicaelectronica.com,localhost"

# User1@org1.historiaclinicaelectronica.com with OU of the departament it belongs to
# In the Fabric CA Server configurations you can configure these posible OU, good practice is to separate them by channel and role in the channel
#export CSR_NAMES_ORG1="C=CO,ST=Antioquia,L=Medellin,O=Org1,OU=Hyperledger Fabric"
## register identity with int CA user1
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/org1.historiaclinicaelectronica.com/int/clients/admin
#fabric-ca-client register --id.name user1@org1.historiaclinicaelectronica.com --id.secret user1pw --id.type client --id.affiliation org1.department2 -u http://admin:adminpw@localhost:7056
## enroll registered identity
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/org1.historiaclinicaelectronica.com/int/clients/user1@org1.historiaclinicaelectronica.com
#fabric-ca-client enroll -u http://user1@org1.historiaclinicaelectronica.com:user1pw@localhost:7056 --csr.names "$CSR_NAMES_ORG1"
## tls
## register identity with TLS int CA user1
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/org1.historiaclinicaelectronica.com/tls-int/clients/admin
#fabric-ca-client register --id.name user1@org1.historiaclinicaelectronica.com --id.secret user1pw --id.type client --id.affiliation org1.department2 -u http://admin:adminpw@localhost:7057
## enroll registered identity
#export FABRIC_CA_CLIENT_HOME=../fabric-ca/org1.historiaclinicaelectronica.com/tls-int/clients/user1@org1.historiaclinicaelectronica.com
#fabric-ca-client enroll -u http://user1@org1.historiaclinicaelectronica.com:user1pw@localhost:7057 --csr.names "$CSR_NAMES_ORG1" --csr.hosts "user1@org1.historiaclinicaelectronica.com,localhost" --enrollment.profile tls
