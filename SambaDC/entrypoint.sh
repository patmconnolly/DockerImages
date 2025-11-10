#!/bin/bash
REALM="$1"
DOMAIN="$2"
ADMINPASS="$3"

FIRST_RUN_FLAG_FILE="/SAMBA_DATA/first-run-complete"
FIRST_RUN_FLAG_FILE_DATA="Do not delete this file. Created by docker container."

echo "search $REALM" > /etc/resolv.conf
echo "nameserver $(hostname -I)" >> /etc/resolv.conf

if [ ! -f "$FIRST_RUN_FLAG_FILE" ]; then
        echo "This is the first run, creating flag file."
        echo "${FIRST_RUN_FLAG_FILE_DATA}" > "${FIRST_RUN_FLAG_FILE}"
        rm /SAMBA_CONFIG/smb.conf
        /usr/bin/samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL --realm=${REALM} --domain=${DOMAIN} --adminpass=${ADMINPASS} --option="acl_xattr:security_acl_name = user.samba_acls"
else
        echo "This is not the first run, flag file detected."
fi

cp /SAMBA_DATA/private/krb5.conf /etc/krb5.conf
