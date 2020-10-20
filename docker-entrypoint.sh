#!/bin/sh
set -e

# Variables multiple lines
if [ -z ${LOCATION+x} ]; then
  echo "Undefined \"LOCATION\" env" && exit 1
fi

if [ -z ${NAME+x} ]; then
  echo "Undefined \"NAME\" env" && exit 1
fi

if [ -z ${MAIL+x} ]; then
  echo "Undefined \"MAIL\" env" && exit 1
fi

if [ -z ${USERNAME+x} ]; then
  echo "Undefined \"USERNAME\" env" && exit 1
fi

clear

GREEN='\033[1;32m'
NC='\033[0m' # No Color
BLUE='\033[1;34m'

echo -e "MADE BY @BUSHIDOSAN  \n\n"

echo "Use the following keys for registering this instance within your monitoring system:"
# Generates the keys :)
SHA=$(openssl genrsa 2>/dev/null | openssl dgst -sha512 | awk '{print $2}');
AES=$(openssl genrsa 2>/dev/null | openssl dgst -sha512 | awk '{print $2}');

# Print keys in nice colors :S
echo -e "${GREEN} SHA $SHA ${NC}"
echo -e "${BLUE} AES $AES ${NC}"

# Places keys on the right place in conf file
sed -i -e 's/SHAKEY/'$SHA'/' /etc/snmp/snmpd.conf
sed -i -e 's/AESKEY/'$AES'/' /etc/snmp/snmpd.conf

# Places location + contact on the right place in conf file
sed -i -e 's/LOCATION/'$LOCATION'/' /etc/snmp/snmpd.conf
sed -i -e 's/NAME/'$NAME'/' /etc/snmp/snmpd.conf
sed -i -e 's/MAIL/'$MAIL'/' /etc/snmp/snmpd.conf

# Places the Read-only username on the right place in conf file
sed -i -e 's/USERNAME/'$USERNAME'/' /etc/snmp/snmpd.conf

# Start primary process
exec "$@"
