#!/bin/ash
/sbin/syslogd && /usr/sbin/ipsec start

PROTONVPN_SERVER=$@
if [ -z $@ ]
then
    PROTONVPN_SERVER=nl-10.protonvpn.com
fi

sed -i -e "s/{{VPN_SERVER}}/$PROTONVPN_SERVER/" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s/{{CTX_VPN_EAP_ID}}/$CTX_VPN_EAP_ID/g" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s@{{CTX_VPN_SECRET}}@$CTX_VPN_SECRET@" /etc/swanctl/conf.d/protonvpn.conf
sed -i -e "s@{{GITHUB_RUN_ID}}@$GITHUB_RUN_ID@" /root/.config/transmission-daemon/settings.json
sed -i -e "s@{{TRANSMISSION_HOST_NAME}}@$TRANSMISSION_HOST_NAME@" /root/.config/transmission-daemon/settings.json

ping -c 5 google.com # prime DNS
/usr/sbin/swanctl -q && /usr/sbin/swanctl -i -c protonvpn

echo "https://github.com/ackersonde/vpnission/actions/runs/$GITHUB_RUN_ID" > /tmp/version

/usr/bin/tail -f /dev/null
