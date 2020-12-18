#!/bin/ash

TR_TORRENT_DIR=${TR_TORRENT_DIR:-$1}
TR_TORRENT_NAME=${TR_TORRENT_NAME:-$2}
TR_TORRENT_ID=${TR_TORRENT_ID:-$3}

PLEX_TORRENT_LIBRARY_SECTION=3

sourcePath="/root/Downloads"
destinationPath="/mnt/torrents"

transmission-remote localhost:9091 -t "${TR_TORRENT_ID}" --move "${sourcePath}"
transmission-remote localhost:9091 -t "${TR_TORRENT_ID}" --remove

if mv "${sourcePath}/$TR_TORRENT_NAME" "${destinationPath}"/ ; then
    detox -r "${destinationPath}/$TR_TORRENT_NAME"
    curl http://192.168.178.59:32400/library/sections/$PLEX_TORRENT_LIBRARY_SECTION/refresh?X-Plex-Token=$CTX_PLEX_TOKEN
fi
