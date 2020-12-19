FROM multiarch/alpine:arm64-edge

# need edge@testing for detox binary ...
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk -u add strongswan transmission-daemon transmission-cli detox@testing

# Transmission stuff
RUN mkdir /root/Downloads /mnt/torrents
ADD config/settings.json /root/.config/transmission-daemon/

ADD scripts/finished_torrent.sh /root/
RUN chmod u+x /root/finished_torrent.sh

EXPOSE 9091

# IPsec stuff
RUN wget https://protonvpn.com/download/ProtonVPN_ike_root.der -O /etc/swanctl/x509/protonvpn.der
ADD config/charon.conf /etc/strongswan.d/
ADD config/protonvpn.conf /etc/swanctl/conf.d/
ADD scripts/updown_ipsec.sh /etc/

ADD scripts/start.sh /root/
ENTRYPOINT ["/root/start.sh"]

# test torrent: http://www.frostclick.com/torrents/video/animation/Big_Buck_Bunny_1080p_surround_frostclick.com_frostwire.com.torrent
