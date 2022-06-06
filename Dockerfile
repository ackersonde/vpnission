FROM multiarch/alpine:arm64-edge

# need edge@testing for detox binary ...
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk -u add wireguard-tools transmission-daemon transmission-cli curl bind-tools detox@testing

# Transmission stuff
RUN mkdir /root/Downloads /mnt/torrents
ADD config/settings.json /root/.config/transmission-daemon/

ADD scripts/finished_torrent.sh /root/
RUN chmod u+x /root/finished_torrent.sh

EXPOSE 9091 51413 51413/udp

RUN echo "net.core.rmem_max=4194304" >> /etc/sysctl.conf
RUN echo "net.core.wmem_max=1048576" >> /etc/sysctl.conf

ADD scripts/start.sh /root/
ENTRYPOINT ["/root/start.sh"]

# test torrent: https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso.torrent
