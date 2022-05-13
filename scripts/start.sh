#!/bin/ash
/sbin/syslogd && /usr/sbin/ipsec start

PROTONVPN_SERVER=$@
if [ -z $@ ]
then
    PROTONVPN_SERVER=138.199.7.129
fi

sed -i -e "s/{{VPN_SERVER}}/$PROTONVPN_SERVER/" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s/{{CTX_VPN_EAP_ID}}/$CTX_VPN_EAP_ID/g" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s@{{CTX_VPN_SECRET}}@$CTX_VPN_SECRET@" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s@{{GITHUB_RUN_ID}}@$GITHUB_RUN_ID@" /root/.config/transmission-daemon/settings.json
sed -i -e "s@{{TRANSMISSION_HOST_NAME}}@$TRANSMISSION_HOST_NAME@" /root/.config/transmission-daemon/settings.json

ping -c 5 google.com # prime DNS
/usr/sbin/swanctl -q && /usr/sbin/swanctl -i -c protonvpn

/usr/bin/tail -f /dev/null
