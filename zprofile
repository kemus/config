################
# ZSH sources: #
################
# ~/.zshenv    #
# /etc/profile #
# ~/.zprofile  #
# ~/.zshrc     #
# ~/.zlogin    #
# ~/.zlogout   #
################

# This file is generally used for automatic execution of user's scripts
# startx if x is not started
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
