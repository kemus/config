echo "$@: Done" | mailx 4028603490@vtext.com
echo "$@: Done" | mailx kevinmustelier@gmail.com
echo << EOF >> .rtorrent.rc
system.method.set_key = event.download.finished,notify_me,"execute=/path/to/mail.sh,.get_name="
