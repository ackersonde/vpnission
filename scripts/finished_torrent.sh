#!/bin/ash
TR_TORRENT_DIR=${TR_TORRENT_DIR:-$1}
TR_TORRENT_NAME=${TR_TORRENT_NAME:-$2}
TR_TORRENT_ID=${TR_TORRENT_ID:-$3}

sourcePath="/root/Downloads"
destinationPath="/mnt/torrents"

transmission-remote localhost:9091 -t "${TR_TORRENT_ID}" --move "${sourcePath}"
transmission-remote localhost:9091 -t "${TR_TORRENT_ID}" --remove

if mv "${sourcePath}/$TR_TORRENT_NAME" "${destinationPath}"/ ; then
    detox -r "${destinationPath}/$TR_TORRENT_NAME"
fi
