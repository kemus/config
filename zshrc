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

fpath=( $HOME/.zsh/functions $fpath )

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

# add ~/bin and ruby to my path
typeset -U path
path=(~/bin $path ~/.gem/ruby/2.1.0/bin)
export path

# dont send hup when zsh closes
setopt no_hup

# if exit val != 0, print it
setopt print_exit_value

# history stuff
setopt hist_verify
setopt SHARE_HISTORY

# Should be on...
setopt ZLE

# vim is my editor, but emacs is my ZLE editor...
unsetopt VI
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

# man is an alias to run-help
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
export HELPDIR=~/.zsh/help
alias man='run-help'
export CLASSPATH=".:/usr/local/lib/antlr-3.5.2-complete.jar:$CLASSPATH"
export CLASSPATH=".:/usr/local/lib/antlr-4.5-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.5-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias antlr3='java -Xmx500M -cp "/usr/local/lib/antlr-3.5.2-complete.jar:$CLASSPATH" org.antlr.Tool'

alias grun4='java org.antlr.v4.runtime.misc.TestRig'
alias grun3='java org.antlr.v3.runtime.misc.TestRig'

# reload zshrc
alias rezsh='source ~/.zshrc'

# fix CTRL + arrow key
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey ';5A' history-beginning-search-backward
bindkey ';5B' history-beginning-search-forward

# directory colors
eval $(dircolors -b)

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/bin/virtualenvwrapper.sh

# say my cowfortune
cowfortune
