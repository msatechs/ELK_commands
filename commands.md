# CREATE CERT AUTHORITY
/usr/share/elasticsearch/bin/elasticsearch-certutil ca --out /etc/elasticsearch/ca --pass

# CREATE CERT MASTER
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca /etc/elasticsearch/ca --dns master1 --ip 192.168.60.140 --name master1 --out /etc/elasticsearch/master_1 --pass 

# CREATE CERT DATA1
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca /etc/elasticsearch/ca --dns data1 --ip 192.168.60.141 --name data1 --out /etc/elasticsearch/data_1 --pass 

# CREATE CERT DATA2
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca /etc/elasticsearch/ca --dns data2 --ip 192.168.60.142 --name data2 --out /etc/elasticsearch/data_2 --pass 

# Move certs to nodes
scp /etc/elasticsearch/data_1 data1@192.168.60.141:/tmp
scp /etc/elasticsearch/data_2 data2@192.168.60.142:/tmp

# FIX permissions
## On Master1
chmod 640 /etc/elasticsearch/master_1

## On Data1
mv /tmp/data_1 /etc/elasticsearch/
chown root:elasticsearch /etc/elasticsearch/data_1
chmod 640 /etc/elasticsearch/data_1

## On Data2
mv /tmp/data_2 /etc/elasticsearch/
chown root:elasticsearch /etc/elasticsearch/data_2
chmod 640 /etc/elasticsearch/data_2

# TRANSPORT
## CREATE KEYSTORE SECURE PASSWORD
/usr/share/elasticsearch/bin/elasticsearch-keystore add xpack.security.transport.ssl.keystore.secure_password

## CREATE TRUSTSTORE SECURE PASSWORD
/usr/share/elasticsearch/bin/elasticsearch-keystore add xpack.security.transport.ssl.truststore.secure_password

## HTTP
## CREATE KEYSTORE SECURE PASSWORD
/usr/share/elasticsearch/bin/elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password

## CREATE TRUSTSTORE SECURE PASSWORD
/usr/share/elasticsearch/bin/elasticsearch-keystore add xpack.security.http.ssl.truststore.secure_password

# SETUP PASSWORDS (cluster must be healthy)
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords interactive

# RESET PASSWORD (cluster must be healthy)
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u <user> -i

# TO CREATE USERS
/usr/share/elasticsearch/bin/elasticsearch-users useradd <user> -p <password> -r <role1>,<role2>

# TO GET DNS
hostname

# SSL BETWEEN KIBANA AND ELASTICSEARCH
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca /etc/elasticsearch/ca --ca-pass med123 --dns master1 --ip 192.168.60.140 --name master1 --out /etc/kibana/kibana-server.zip --pem


# GET FINGERPRINT
openssl x509 -fingerprint -sha256 -in /etc/elasticsearch/certs/http_ca.crt

# CREATE CERT FROM CA
/usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca /etc/elasticsearch/certs/http_ca.crt --out /home/esvoting/client-cert.pem