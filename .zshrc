# prompt style
#PROMPT='%{%F{#5fd7ff}%}% $USER%{%f%}@%{%F{#00af5f	}%}% $HOST%{%f%}:%{%F{yellow}%}%~%{%f%}$ '
#PROMPT='%{%F{yellow}%}%~%{%f%}$ ' #yellow
PROMPT='%{%F{#008080}%}%~%{%f%}$ ' # dark green

# git branch
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
RPROMPT="\$vcs_info_msg_0_"
zstyle ':vcs_info:git*' formats "* %{%F{#1EC325}%}% %b%{%f%}"

bindkey -v

# autocompletion
autoload -U compinit
compinit

# autocompletion for docker, docker-compose
if [ $commands[docker] ]; then source /home/andrew/.config/autocompletion/_docker; fi
if [ $commands[docker-compose] ]; then source /home/andrew/.config/autocompletion/_docker-compose; fi
# autocompletion for kubectl
if [ /usr/bin/kubectl ]; then source <(kubectl completion zsh); fi
# autocompletion for helm
if [ $commands[helm] ]; then source <(helm completion zsh); fi
# autocompletion for gcloud
if [ $commands[gcloud] ]; then source /home/andrew/.config/autocompletion/gcloud.plugin.zsh; fi
# autocompletion for aws
if [ $commands[aws] ]; then source /home/andrew/.config/autocompletion/aws.plugin.zsh; fi
# autocompletion for ansible
if [ $commands[ansible] ]; then source /home/andrew/.config/autocompletion/ansible.plugin.zsh; fi

HISTCONTROL=ignoreboth

# history
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000

# AWS ansible exports
source ~/.aws/.export_credentials

# settings
#setopt correct_all	#correct misspelled commands
setopt autocd           #cd by typing directory name
setopt hist_ignore_dups #ignore repeated commands
setopt NO_BEEP
setopt globdots
setopt noautomenu
setopt nomenucomplete

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias ls='ls --group-directories-first --color=auto'
    alias la='ls -a --group-directories-first --color=auto'
    alias ll='ls -alh --group-directories-first --color=auto'
    alias l='ls -CF --group-directories-first --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi

chpwd() {
	ls -a --group-directories-first --color=auto
}

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Multiple Monitors aliases
alias monitor_mirror='xrandr --output HDMI2 --auto --same-as eDP1 --mode 1920x1080'
alias monitor_independent='xrandr --output HDMI2 --auto --right-of eDP1'
alias monitor_rotate='xrandr --output HDMI2 --rotate left --right-of eDP1'
alias monitor_off='xrandr --output HDMI2 --off'

# aliases
alias suspend='sudo systemctl suspend'
alias svim='sudo -E nvim'
alias vim='nvim'
alias bc='bc -l -q'
alias k='kubectl'

# nessus start/stop aliases
alias nessusstart='sudo /misc/init.d/nessusd start'
alias nessusstop='sudo /misc/init.d/nessusd stop'

# nfs mount aliases
alias showmounted='df -aTh'
alias nfsmount='sudo mount -t nfs4 -o proto=tcp,port=2049 raspberrypi:/media/shared/ /media/shared/'
alias nfsumount='sudo umount -f /media/shared/'

# S3 bucket mounting
alias bucketmount='s3fs fortnest-bucket /media/bucket/ -o endpoint="eu-central-1"'
alias bucketumount='sudo umount -f /media/bucket/'

# vpn aliases
alias epamvpn='sudo openconnect --protocol=gp vpn.epam.com'
alias homevpn='sudo openvpn --config /home/andrew/misc/openvpn/home.ovpn'
alias servervpn='sudo openvpn --config /home/andrew/misc/openvpn/server.ovpn'

# changing wget history location
alias wget="wget --hsts-file ~/.config/wget/wget-hsts"

# disabling less history
export LESSHISTFILE=/dev/null

# goto
alias godwm='cd ~/dotfiles/suckless/dwm-6.2'
alias gost='cd ~/dotfiles/suckless/st-0.8.2'

# export app
export TERM=xterm-256color
export EDITOR=nvim
#export TERM=st-256color
#export TERM=xterm

# export paths
export PATH=$PATH:~/downloads/blender
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/python
export GOPATH=/home/andrew/bin/go/golibs
export GOPATH=$GOPATH:/home/andrew/bin/go/gocode
export PATH=$PATH:/usr/local/go/bin

#export PATH=$PATH:/home/andrew/downloads/platform-tools/ # not needed, can't execute commands anyway *root needed*
