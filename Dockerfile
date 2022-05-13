FROM multiarch/alpine:arm64-edge

# need edge@testing for detox binary ...
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk -u add wireguard-tools transmission-daemon transmission-cli curl bind-tools detox@testing

# Transmission stuff
RUN mkdir /root/Downloads /mnt/torrents
ADD config/settings.json /root/.config/transmission-daemon/

ADD scripts/finished_torrent.sh /root/
RUN chmod u+x /root/finished_torrent.sh

EXPOSE 9091 51413

ADD scripts/start.sh /root/
ENTRYPOINT ["/root/start.sh"]

# test torrent: https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso.torrent
