[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.xprofile ]] && source ~/.xprofile
[[ -f /usr/share/fonts/local ]] && xset +fp /usr/share/fonts/local && xset fp rehash
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
compton -b &
xbacklight -set 20
exec gnome-session
