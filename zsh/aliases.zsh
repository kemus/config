# Aliases and functions that I find useful
# ls aliases ########################################################
# make ls pretty
alias ls='pwd;ls --classify --color=auto --escape'

# typos become slightly amusing, while still useful
alias sl='ls --reverse'

# lists all (no group information)
alias la='ls -o --all --human-readable'

# lists less info, but still long-form
alias l='ls -g --no-group --all --human-readable --group-directories-first'

# lists sorted by time
alias lt="ls -l \
             --almost-all \
             --sort=time \
             --reverse \
             --human-readable \
             --time-style=+'%F %T' \
             --indicator-style=slash \
             --color=never | \
          awk '{print \$6,\$7,\$8,\$9,\$10}'"

# lists files larger than $1
function lz()
{
    if [[ -z $1 ]]; then
        find . -type f -a -size +1M -a -writable -a -readable;
    else
        find . -type f -a -size +$1 -a -writable -a -readable;
    fi
}

# cd aliases ##########################################################
# - goes to last directory
alias -- -='cd -'

# global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# suffix aliases ######################################################
alias -s tex=vim
alias -s html=chromium
alias -s gif=feh
alias -s png=feh
alias -s jpg=feh
alias -s jpeg=feh


# yay random numbers
function random()
{
    if [[ -z $1 ]] then;
        echo "Usage: random number1 [number2]"
    else
        if [[ -z $2 ]] then;
            [[ 0 -lt $1 ]]  && lo=0  && hi=$1
            [[ 0 -ge $1 ]]  && lo=$1 && hi=0
        else
            [[ $1 -lt $2 ]] && lo=$1 && hi=$2
            [[ $1 -ge $2 ]] && lo=$2 && hi=$1
        fi
        let "range = $hi - $lo + 1"
        if [[ $range -ne 0 ]] then;
            let "rand = ( ${RANDOM} % $range ) + $lo"
            echo $[$rand]
        else
            echo $lo
        fi
    fi
}

# always use my pager to page
alias less=$PAGER
alias more=$PAGER

# give redshift my location
alias redshift='redshift -l 42.360026:-71.088179 &'

# colorful grep
alias grep='grep --color=auto'

# mkdir makes recursively and is verbose
alias mkdir='mkdir --parents --verbose'

# colorful diff
alias diff='colordiff'

# useful du defaults
alias du='du --total --human-readable --max-depth 1 --one-file-system'

# useful df defaults
alias df='df --total --human-readable'

# nowrap on nano
alias nano='nano --nowrap'

# not infinite pings
alias ping='ping -c 5'

# readable dmesg
alias dmesg='dmesg --human --color'

# safer rm prompts when removing recursively or many files, preserves root, with a timeout
alias rm=' timeout 3 rm -Iv --one-file-system --preserve-root'

# safer mv prompts before overwrite and is verbose
alias mv='mv --interactive --verbose'

# safer cp prompts before overwrite and is verbose
alias cp='cp --interactive --verbose'

# safer ch* preserves root
alias chown='chown --preserve-root --verbose'
alias chmod='chmod --preserve-root --verbose'
alias chgrp='chgrp --preserve-root --verbose'


# reverse a word
function ohce()
{
    echo "${(j::)${(@Oa)${(s::):-$1}}}"
}

# test if a parameter is numeric
function numeric()
{
    [[ $1 == <-> ]] && echo true || echo false
}

# Remove zero length files from a directory
alias rmclean='rm -i *(.L0);find . -maxdepth 1 -not -name . -type d -ok rmdir --ignore-fail-on-non-empty {} \;'

# Show only the ip-address from ``ifconfig device''
alias myip="ifconfig | grep $WIRELESS -A8 | grep 'inet ' | awk '{print \$2}'"

# get a "ls -l" on all the files in the tree that are younger than a
# specified age (e.g "ls -l" all the files in the tree that where
# modified in the last 2 days)
alias ly='ls -tld **/*(m-2)'

alias history='fc -l 1'


#rtorrent
alias rt='tmux attach -t rt'

# push/pop
alias pu='pushd'
alias po='popd'

# fix 'sound card used more than once' issue, by closing all things using sound card
alias fixsnd="for id in \$(lsof | grep snd | awk '{print \$2}' | sort -u); do kill \$id; done; pulseaudio -k"

# because I'm lazy
alias wifi='sudo wifi-menu'

# reload zshrc
alias rezsh='source ~/.zshrc'
