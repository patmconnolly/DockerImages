#!/bin/bash
SUFFIX="$1"
ROOTDN="$2"
ROOTPW="$3"

sed -i "/^suffix[[:space:]]*\"dc=my-domain,dc=com\"$/c\suffix\t\t\"${SUFFIX}\"" /usr/local/etc/openldap/slapd.conf
sed -i "/^rootdn[[:space:]]*\"cn=Manager,dc=my-domain,dc=com\"$/c\rootdn\t\t\"${ROOTDN}\"" /usr/local/etc/openldap/slapd.conf
sed -i "/^rootpw[[:space:]]*secret$/c\rootpw\t\t${ROOTPW}" /usr/local/etc/openldap/slapd.conf

/usr/local/libexec/slapd