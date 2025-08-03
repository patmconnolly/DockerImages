#!/bin/bash
SUFFIX="$1"
ROOTDN="$2"
ROOTPW="$3"

FIRST_RUN_FLAG_FILE="/usr/local/var/openldap-data/first-run-complete"
FIRST_RUN_FLAG_FILE_DATA="Do not delete this file. Created by docker container."

sed -i "/^suffix[[:space:]]*\"dc=my-domain,dc=com\"$/c\suffix\t\t\"${SUFFIX}\"" /usr/local/etc/openldap/slapd.conf
sed -i "/^rootdn[[:space:]]*\"cn=Manager,dc=my-domain,dc=com\"$/c\rootdn\t\t\"${ROOTDN}\"" /usr/local/etc/openldap/slapd.conf
sed -i "/^rootpw[[:space:]]*secret$/c\rootpw\t\t${ROOTPW}" /usr/local/etc/openldap/slapd.conf

sed -i "/^olcSuffix:[[:space:]]*dc=my-domain,dc=com$/c\olcSuffix: ${SUFFIX}" /usr/local/etc/openldap/slapd.ldif
sed -i "/^olcRootDN:[[:space:]]*cn=Manager,dc=my-domain,dc=com$/c\olcRootDN: ${ROOTDN}" /usr/local/etc/openldap/slapd.ldif
sed -i "/^olcRootPW:[[:space:]]*secret$/c\olcRootPW: ${ROOTPW}" /usr/local/etc/openldap/slapd.ldif

if [ ! -f "$FIRST_RUN_FLAG_FILE" ]; then
	echo "This is the first run, creating flag file."
	echo '$FIRST_RUN_FLAG_FILE_DATA' > '$FIRST_RUN_FLAG_FILE'
	/usr/local/sbin/slapadd -n 0 -F /usr/local/etc/slapd.d -l /usr/local/etc/openldap/slapd.ldif
else
	echo "This is not the first run, flag file detected."
fi