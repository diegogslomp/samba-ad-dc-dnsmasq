#!/bin/sh
set -ex

samba --version
echo -e "\n" | (testparm)
smbclient -L localhost -U%
echo -e "$ADMIN_PASS\n" | (smbclient //localhost/netlogon -UAdministrator -c 'ls')
nslookup $(hostname).${SEARCH_DOMAIN}
host -t SRV _ldap._tcp.${SEARCH_DOMAIN}
echo -e "$ADMIN_PASS\n" | (kinit administrator)
klist
/usr/local/samba/bin/wbinfo -u