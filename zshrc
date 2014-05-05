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

# This is Zsh's main configuration file


# completions
if [[ -e ~/.zsh/completions.zsh ]];then
     source ~/.zsh/completions.zsh
fi

# set up the prompt
if [[ -e ~/.zsh/prompt.zsh ]];then
     source ~/.zsh/prompt.zsh
fi

# history
if [[ -e ~/.zsh/history.zsh ]];then
     source ~/.zsh/history.zsh
fi

# parse_options script sometimes required
if [[ -e ~/.zsh/parse_options.zsh ]];then
     source ~/.zsh/parse_options.zsh
fi

# command-not-found -- not currently working?
if [[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]];then
     source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# create a zkbd compatible hash
if [[ -e ~/.zsh/keyboard.zsh ]];then
     source ~/.zsh/keyboard.zsh
fi

# aliases I like
if [[ -e ~/.zsh/aliases.zsh ]];then
     source ~/.zsh/aliases.zsh
fi

[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

# This will set the default prompt to the walters theme
prompt walters

# add ~/bin to my path
typeset -U path
path=(~/bin $path)

# add ruby to my path
PATH=$PATH:/home/kemus/.gem/ruby/2.1.0/bin
export PATH
# dont send hup when zsh closes
setopt no_hup

# if exit val != 0, print it
setopt print_exit_value

# history stuff
setopt hist_verify
setopt SHARE_HISTORY

# Should be on...
setopt ZLE

# vim
unsetopt VI
export editor="vim"
bindkey -e

# don't exit on ^D [until it is hit 10 times]
setopt IGNORE_EOF

# beeps are annoying
setopt NO_BEEP

# globbing
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB

setopt no_clobber
#a${b}c has a and c surrounding all variables, not just first and last
setopt RC_EXPAND_PARAM

setopt no_clobber

# run-help is an alias to man
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
export HELPDIR=~/.zsh/help
alias man='run-help'
alias dialup='ssh kemus@athena.dialup'
alias rezsh='source ~/.zshrc'
cowfortune

bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey ';5A' history-beginning-search-backward
bindkey ';5B' history-beginning-search-forward
