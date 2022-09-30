#!/bin/bash -e
sudo apt-get update
sudo apt-get install mysql-client -y

wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem


# connect to mysql
# wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
# mysql -h devscvsqlsvr.mysql.database.azure.com -u devlabr@devscvsqlsvr -p --ssl-mode=REQUIRED --ssl-ca=DigiCertGlobalRootCA.crt.pem