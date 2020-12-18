#!/bin/ash
/sbin/syslogd && /usr/sbin/ipsec start

sed -i -e "s/{{VPN_SERVER}}/$@.protonvpn.com/" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s/{{CTX_VPN_EAP_ID}}/$CTX_VPN_EAP_ID/g" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s@{{CTX_VPN_SECRET}}@$CTX_VPN_SECRET@" /etc/swanctl/conf.d/protonvpn.conf
/bin/sleep 3
/usr/sbin/swanctl -q && /usr/sbin/swanctl -i -c protonvpn

/usr/bin/tail -f /dev/null
