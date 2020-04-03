#!/bin/bash +x
#/usr/sbin/init
set +e

# Create certs directory
mkdir -p /usr/local/etc/certs

# Copy certs from s3 bucket
aws s3 cp s3://${SPG_CERTIFICATE_BUCKET}${SPG_CERTIFICATE_PATH}  /usr/local/etc/certs --recursive

cd /usr/local/etc/certs/spg-iso-alt-tls/

#Crete pam using public certificate and private key
cat ${SPG_PROXY_FQDN}.public-certificate.pem ${SPG_PROXY_FQDN}.key > server.pem

# Coppy the pem file
cp server.pem /usr/local/etc/haproxy/

set -e