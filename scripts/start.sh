#!/bin/ash
/sbin/syslogd

PROTONVPN_SERVER=$@
if [ -z $@ ]
then
    PROTONVPN_SERVER=NL_1
fi

sed -i -e "s@{{GITHUB_RUN_ID}}@$GITHUB_RUN_ID@" /root/.config/transmission-daemon/settings.json
sed -i -e "s@{{TRANSMISSION_HOST_NAME}}@$TRANSMISSION_HOST_NAME@" /root/.config/transmission-daemon/settings.json

/usr/bin/wg-quick up $PROTONVPN_SERVER
ping -c 5 google.com # prime DNS

/usr/bin/curl https://ackerson.de/ip
/usr/bin/transmission-daemon

/usr/bin/tail -f /dev/null
