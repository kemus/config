#!/bin/bash
# makes magnet links work
watch_folder=~/torrents/watch
cd
[[ "" =~ xt=urn:btih:([^&/]+) ]] || exit;
echo "d10:magnet-uri0:e" > "meta-.torrent"
